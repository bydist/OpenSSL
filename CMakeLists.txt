include("${CMAKE_CURRENT_LIST_DIR}/id.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/byd__openssl__generate.cmake")



#if(version_to_build STREQUAL LibreSSL-2.5.5)
#    byd__cmake__add(${package})
#    return()
#endif()

byd__EP__compile_in_source(${package} 1)

byd__openssl__generate_configure_command(${package})
byd__openssl__generate_build_command(${package})
byd__openssl__generate_install_command(${package})

if(BUILD_TESTING)
    byd__openssl__generate_test_command(${package})
endif()

if(APPLE)
    byd__fixup_dylib(${package})
endif()

byd__EP__add(${package})
