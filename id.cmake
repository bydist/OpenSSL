set(package OpenSSL)
set(version 1.0.2l)

byd__package__info(${package}
    MAINTAINER_NAME "David Callu"
    MAINTAINER_EMAIL "callu.david@gmail.com"
    VERSION ${version}-1
    ABI ${version}
    )

byd__package__download_info(${package}
    URL "https://github.com/openssl/openssl/archive/OpenSSL_1_0_2l.tar.gz"
    URL_HASH SHA1=5bea0957b371627e8ebbee5bef221519e94d547c
    )
