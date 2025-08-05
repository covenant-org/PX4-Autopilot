#ifndef OSCILLATING_PLATFORM_PLUGIN_HH
#define OSCILLATING_PLATFORM_PLUGIN_HH

#include <gz/common/Timer.hh>
#include <gz/math/Pose3.hh>
#include <gz/math/Vector3.hh>
#include <gz/sim/Model.hh>
#include <gz/sim/System.hh>
#include <gz/sim/components/LinearVelocity.hh>
#include <gz/sim/components/Pose.hh>
#include <memory>

namespace gz::sim::covenant {
class OscillatingPlatformPluginConfig {
  /// \brief Model interface
public:
  gz::sim::Model model{gz::sim::kNullEntity};
  double amplitude{5.0};
  double period{10.0};
  std::string axis{"x"};
  std::string link{"link"};
  gz::math::Pose3d initialPose{gz::math::Pose3d::Zero};
  std::chrono::steady_clock::time_point startTime;
  bool initialized{false};
};

/// \brief Plugin that makes a model oscillate horizontally in a sinusoidal
class OscillatingPlatformPlugin : public gz::sim::System,
                                  public gz::sim::ISystemConfigure,
                                  public gz::sim::ISystemPreUpdate {
public:
  OscillatingPlatformPlugin();
  ~OscillatingPlatformPlugin() override = default;

public:
  void Configure(const gz::sim::Entity &_entity,
                 const std::shared_ptr<const sdf::Element> &_sdf,
                 gz::sim::EntityComponentManager &_ecm,
                 gz::sim::EventManager &_eventMgr) override;

  void PreUpdate(const gz::sim::UpdateInfo &_info,
                 gz::sim::EntityComponentManager &_ecm) override;

private:
  std::unique_ptr<class OscillatingPlatformPluginConfig> dataPtr;
};
} // namespace gz::sim::covenant

#endif
