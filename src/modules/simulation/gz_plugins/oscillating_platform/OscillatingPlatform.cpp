#include "OscillatingPlatform.hpp"
#include <chrono>
#include <cmath>
#include <gz/common/Profiler.hh>
#include <gz/math/Pose3.hh>
#include <gz/math/Vector3.hh>
#include <gz/plugin/Register.hh>
#include <gz/sim/Link.hh>
#include <gz/sim/Util.hh>
#include <gz/sim/components/LinearVelocity.hh>
#include <gz/sim/components/Name.hh>
#include <gz/sim/components/Pose.hh>
#include <iostream>
#include <sdf/sdf.hh>

using namespace gz::sim::covenant;

OscillatingPlatformPlugin::OscillatingPlatformPlugin()
    : dataPtr(std::make_unique<OscillatingPlatformPluginConfig>()) {}

void OscillatingPlatformPlugin::Configure(
    const gz::sim::Entity &_entity,
    const std::shared_ptr<const sdf::Element> &_sdf,
    gz::sim::EntityComponentManager &_ecm,
    gz::sim::EventManager & /*_eventMgr*/) {
  this->dataPtr->model = gz::sim::Model(_entity);

  if (!this->dataPtr->model.Valid(_ecm)) {
    gzerr << "OscillatingPlatformPlugin should be attached to a model entity. "
          << "Failed to initialize." << std::endl;
    return;
  }

  // Read plugin parameters from SDF
  if (_sdf->HasElement("amplitude")) {
    this->dataPtr->amplitude = _sdf->Get<double>("amplitude");
  }

  if (_sdf->HasElement("period")) {
    this->dataPtr->period = _sdf->Get<double>("period");
  }

  if (_sdf->HasElement("link")) {
    this->dataPtr->link = _sdf->Get<std::string>("link");
  }

  if (_sdf->HasElement("axis")) {
    this->dataPtr->axis = _sdf->Get<std::string>("axis");
  }

  // Validate axis parameter
  if (this->dataPtr->axis != "x" && this->dataPtr->axis != "y" &&
      this->dataPtr->axis != "z") {
    gzerr << "Invalid axis parameter: " << this->dataPtr->axis
          << ". Must be 'x', 'y', or 'z'. Defaulting to 'x'." << std::endl;
    this->dataPtr->axis = "x";
  }

  // Get initial pose
  auto poseComp = _ecm.Component<gz::sim::components::Pose>(_entity);
  if (poseComp) {
    this->dataPtr->initialPose = poseComp->Data();
  }

  this->dataPtr->startTime = std::chrono::steady_clock::now();
  this->dataPtr->initialized = true;

  // gzinfo << "OscillatingPlatformPlugin initialized with:" << std::endl;
  // gzinfo << "  Amplitude: " << this->dataPtr->amplitude << " meters" <<
  // std::endl; gzinfo << "  Period: " << this->dataPtr->period << " seconds" <<
  // std::endl; gzinfo << "  Axis: " << this->dataPtr->axis << std::endl; gzinfo
  // << "  Initial pose: " << this->dataPtr->initialPose << std::endl;
}

//////////////////////////////////////////////////
void OscillatingPlatformPlugin::PreUpdate(
    const gz::sim::UpdateInfo &_info, gz::sim::EntityComponentManager &_ecm) {
  GZ_PROFILE("OscillatingPlatformPlugin::Update");

  if (!this->dataPtr->initialized)
    return;

  // Calculate elapsed time in seconds
  auto currentTime = std::chrono::steady_clock::now();
  auto elapsed = std::chrono::duration_cast<std::chrono::microseconds>(
                     currentTime - this->dataPtr->startTime)
                     .count() /
                 1000000.0;

  // Calculate angular frequency
  double omega = 2.0 * M_PI / this->dataPtr->period;

  // Calculate offset from initial position
  double offset = this->dataPtr->amplitude * sin(omega * elapsed);

  // Create new pose based on initial pose and calculated offset
  gz::math::Pose3d newPose = this->dataPtr->initialPose;

  if (this->dataPtr->axis == "x") {
    newPose.Pos().X() += offset;
  } else if (this->dataPtr->axis == "y") {
    newPose.Pos().Y() += offset;
  } else if (this->dataPtr->axis == "z") {
    newPose.Pos().Z() += offset;
  }

  // Calculate velocity for smooth motion
  double velocity = this->dataPtr->amplitude * omega * cos(omega * elapsed);
  gz::math::Vector3d velocityVector = gz::math::Vector3d::Zero;

  if (this->dataPtr->axis == "x") {
    velocityVector.X() = velocity;
  } else if (this->dataPtr->axis == "y") {
    velocityVector.Y() = velocity;
  } else if (this->dataPtr->axis == "z") {
    velocityVector.Z() = velocity;
  }

  // Apply forces to create physics-based motion instead of kinematic movement
  auto linkEntity = this->dataPtr->model.LinkByName(_ecm, this->dataPtr->link);
  if (linkEntity != gz::sim::kNullEntity) {
    // Calculate current position
    auto currentPose = gz::sim::worldPose(linkEntity, _ecm);

    // Calculate position error
    double currentPos, targetPos;
    if (this->dataPtr->axis == "x") {
      currentPos = currentPose.Pos().X();
      targetPos = this->dataPtr->initialPose.Pos().X() + offset;
    } else if (this->dataPtr->axis == "y") {
      currentPos = currentPose.Pos().Y();
      targetPos = this->dataPtr->initialPose.Pos().Y() + offset;
    } else {
      currentPos = currentPose.Pos().Z();
      targetPos = this->dataPtr->initialPose.Pos().Z() + offset;
    }

    double posError = targetPos - currentPos;

    // PD controller for smooth motion
    double kp = 1000.0; // Position gain
    double kd = 100.0;  // Damping gain

    // Get current velocity
    auto currentVel = gz::sim::relativeVel(linkEntity, _ecm);
    double currentVelAxis;
    if (this->dataPtr->axis == "x") {
      currentVelAxis = currentVel.X();
    } else if (this->dataPtr->axis == "y") {
      currentVelAxis = currentVel.Y();
    } else {
      currentVelAxis = currentVel.Z();
    }

    double velError = velocity - currentVelAxis;

    // Calculate force
    double force = kp * posError + kd * velError;

    // Apply force
    gz::math::Vector3d forceVector = gz::math::Vector3d::Zero;
    if (this->dataPtr->axis == "x") {
      forceVector.X() = force;
    } else if (this->dataPtr->axis == "y") {
      forceVector.Y() = force;
    } else {
      forceVector.Z() = force;
    }

    // Apply the force to the link
    gz::sim::Link link(linkEntity);
    link.AddWorldForce(_ecm, forceVector);
  }
}

// Register this plugin
GZ_ADD_PLUGIN(OscillatingPlatformPlugin, gz::sim::System,
              OscillatingPlatformPlugin::ISystemConfigure,
              OscillatingPlatformPlugin::ISystemPreUpdate)
