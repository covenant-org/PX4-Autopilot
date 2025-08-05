project(OscillatingPlatformPlugin)

# Add external dependencies if needed
# include(${CMAKE_CURRENT_SOURCE_DIR}/dependency.cmake)

# Find required packages
# find_package(PackageName REQUIRED)

add_library(${PROJECT_NAME} SHARED
    # Add your source files here
    OscillatingPlatform.cpp
)


target_link_libraries(${PROJECT_NAME}
    PUBLIC gz-sensors${gz-sensors_VERSION_MAJOR}::gz-sensors${gz-sensors_VERSION_MAJOR}
    PUBLIC gz-plugin${gz-plugin_VERSION_MAJOR}::gz-plugin${gz-plugin_VERSION_MAJOR}
    PUBLIC gz-sim${gz-sim_VERSION_MAJOR}::gz-sim${gz-sim_VERSION_MAJOR}
    PUBLIC gz-transport${gz-transport_VERSION_MAJOR}::gz-transport${gz-transport_VERSION_MAJOR}
    PUBLIC gz-common${gz-common_VERSION_MAJOR}::gz-common${gz-common_VERSION_MAJOR}
    # Add other dependencies as needed
    # PUBLIC ${OtherLib_LIBS}
)

target_include_directories(${PROJECT_NAME}
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
    PUBLIC ${CMAKE_CURRENT_BINARY_DIR}
)
