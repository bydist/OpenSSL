set(package OpenSSL)
set(version 1.1.0h)

byd__package__info(${package}
    MAINTAINER_NAME "David Callu"
    MAINTAINER_EMAIL "callu.david@gmail.com"
    VERSION ${version}-3
    ABI 1.1
    )

byd__package__download_info(${package}
    URL "https://github.com/openssl/openssl/archive/OpenSSL_1_1_0h.tar.gz"
    URL_HASH SHA1=2168c88516556332ebaf7c31791132025a093c2b
    )
