cmake_minimum_required(VERSION 3.16)
project(GlobeApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Quick3D QuickControls2)

qt_add_executable(GlobeApp
    main.cpp
)

qt_add_resources(GlobeApp "configuration"
    PREFIX "/"
    FILES
        main.qml
        earth_texture.jpg
        earth_normal.jpg
)

target_link_libraries(GlobeApp
    PRIVATE Qt6::Quick Qt6::Quick3D Qt6::QuickControls2
)

install(TARGETS GlobeApp
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
