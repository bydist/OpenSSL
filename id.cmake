set(package OpenSSL)
set(version 1.0.2o)

byd__package__info(${package}
    MAINTAINER_NAME "David Callu"
    MAINTAINER_EMAIL "callu.david@gmail.com"
    VERSION ${version}-3
    ABI 1.0
    )

byd__package__download_info(${package}
    URL "https://github.com/openssl/openssl/archive/OpenSSL_1_0_2o.tar.gz"
    URL_HASH SHA1=ec7ad3650206f1045d48f2fe9ed4ad93a1228ec5
    )
