set(package OpenSSL)
set(version 1.0.2n)

byd__package__info(${package}
    MAINTAINER_NAME "David Callu"
    MAINTAINER_EMAIL "callu.david@gmail.com"
    VERSION ${version}-2
    ABI 1.0.2
    )

byd__package__download_info(${package}
    URL "https://github.com/openssl/openssl/archive/OpenSSL_1_0_2n.tar.gz"
    URL_HASH SHA1=6d507bb849c8156f14c2b6f3e269a5e782ff6b82
    )
