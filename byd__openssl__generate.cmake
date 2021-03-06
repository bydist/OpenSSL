


include("${BYD_ROOT}/cmake/modules/func.cmake")
include("${BYD_ROOT}/cmake/modules/build_system/byd__build_system__default.cmake")
include("${BYD_ROOT}/cmake/modules/package.cmake")
include("${BYD_ROOT}/cmake/modules/private.cmake")
include("${BYD_ROOT}/cmake/modules/script.cmake")



##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##

function(byd__openssl__generate_configure_command package)

    set(__property_name BYD__EP__CONFIGURE__CONFIGURE_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)
    byd__package__get_source_dir(${package} source_dir)
    byd__package__get_install_dir(${package} install_dir)


    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        set(openssl_build_type "debug-")
    endif()

    if(WIN32)
        if(MSVC)
            set(openssl_platform "VC-WIN32")
            set(openssl_compiler "")
        endif()
    elseif(APPLE)
        set(openssl_platform "darwin64")
        set(openssl_architecture "-x86_64")
        set(openssl_compiler "-cc")
    elseif(UNIX)
        set(openssl_platform "linux")
        if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
            if(CMAKE_SIZEOF_VOID_P EQUAL 8)
                set(openssl_architecture "-generic64")
            else()
                set(openssl_architecture "-generic32")
            endif()
            set(openssl_compiler "")
        elseif(CMAKE_C_COMPILER_ID STREQUAL "Clang")
            set(openssl_architecture "-x86_64")
            set(openssl_compiler "-clang")
        endif()
    endif()


    if(NOT DEFINED openssl_compiler)
        cmut_fatal("compiler \"${CMAKE_C_COMPILER_ID}\" not supported by OpenSSL byd script")
        return()
    endif()
    if(NOT DEFINED openssl_platform)
        cmut_fatal("platform not supported by OpenSSL byd script")
        return()
    endif()


    set(configure_args "")
    list(APPEND configure_args "${openssl_build_type}${openssl_platform}${openssl_architecture}${openssl_compiler}")

    if(CMAKE_INSTALL_PREFIX)
        set(prefix "${install_dir}")
        list(APPEND configure_args "--prefix=${prefix}")
    endif()


    if(BUILD_SHARED_LIBS)
        list(APPEND configure_args "shared")
    else()
        list(APPEND configure_args "no-shared")
    endif()


	list(APPEND configure_args "zlib")
	if(CMAKE_INSTALL_PREFIX)
		list(APPEND configure_args "--with-zlib-include=${CMAKE_INSTALL_PREFIX}/include")

		set(zlib_option_path "${CMAKE_INSTALL_PREFIX}/lib")
		if(WIN32)
			if(CMAKE_BUILD_TYPE STREQUAL "Release")
				set(zlib_option_path "${zlib_option_path}/zdll.lib")
			elseif(CMAKE_BUILD_TYPE STREQUAL "Debug")
				set(zlib_option_path "${zlib_option_path}/zdlld.lib")
			else()
				cmut_fatal("[byd][OpenSSL] - build type \"${CMAKE_BUILD_TYPE}\" not handle by this script. Patch me if you can.")
			endif()
		endif()
		list(APPEND configure_args "--with-zlib-lib=${zlib_option_path}")
	endif()


    set(command "perl" "Configure" "${configure_args}")



    byd__script__begin("${script_dir}/configure.cmake")
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_configure_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__openssl__generate_build_command package)

    set(__property_name BYD__EP__BUILD__BUILD_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)
    byd__package__get_source_dir(${package} source_dir)


    if(UNIX)
        byd__private__get_num_core_available(num_core)
        set(command make -j${num_core})
    elseif(WIN32 AND MSVC)
        set(command nmake)
    endif()

    byd__script__begin("${script_dir}/build.cmake")
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_build_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__openssl__generate_install_command package)

    set(__property_name BYD__EP__INSTALL__INSTALL_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)
    byd__package__get_source_dir(${package} source_dir)



    if(UNIX)
        byd__private__get_num_core_available(num_core)
        set(command make install_sw -j${num_core})
    elseif(WIN32 AND MSVC)
        set(command nmake install_sw)
    endif()


    byd__script__begin("${script_dir}/install.cmake")
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_install_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##

function(byd__openssl__generate_test_command package)

    set(__property_name BYD__EP__TEST__TEST_COMMAND__${package})
    byd__private__error_if_property_is_defined(${__property_name})

    byd__package__get_script_dir(${package} script_dir)
    byd__package__get_source_dir(${package} source_dir)



    if(UNIX)
        # disable -j option ==>> fail the test
        set(command make test)
    elseif(WIN32 AND MSVC)
        set(command nmake test)
    endif()



    byd__script__begin("${script_dir}/test.cmake")
        byd__script__command("${command}")
    byd__script__end()


    byd__build_system__default_test_command(${package})

endfunction()

##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
##--------------------------------------------------------------------------------------------------------------------##
