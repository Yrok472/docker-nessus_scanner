# Unofficial Nessus Scanner

[github]: https://github.com/Yrok472/docker-nessus_scanner/
[docker]: https://hub.docker.com/r/yrok472/nessus_scanner/

Tenable's Nessus Scanner is a vulnerability scanner that looks for known vulnerabilities, malware, configuration issues, etc. both through network inspection of hosts and through authenticated analysis of the host itself.  For more information about Nessus, please consult the following links:

* [Nessus Scanner product page](http://www.tenable.com/products/nessus-vulnerability-scanner)
* [Nessus Scanner latest docs](https://docs.tenable.com/nessus/Content/GettingStarted.htm)

# Build files

The github repository for the build files is located [here](https://github.com/Yrok472/docker-nessus_scanner).

# Supported tags

Each image is tagged with the major, minor, and patch releases.  The most current image is always tagged as "latest".  For the current listing of tags, please refer to the [tags tab](https://hub.docker.com/r/yrok472/nessus_scanner/tags/) for a current listing.

# Usage

```
docker run -dt \
    -e LINKING_KEY={LINKING_KEY}\
    -e PRODUCT_INITIALIZATION={TRUE_OR_FALSE}\
    -e SCANNER_NAME={SCANNER_NAME}\
    --name nessus_scanner
    yrok472/nessus_scanner:latest
```

If running from a Kubernetes pod make sure to set `tty: true`.

# Modifications

* `/opt/nessus/bin` and `/opt/nessus/sbin` have been added to the system $PATH variable.
* `nessus_adduser.exp` has been loaded into `/usr/bin` to facilitate in programmatic user creation when necessary.
* `nessus.sh` has been loaded into `/usr/bin` as a wrapper to configure the Nessus daemon before launch.

# Environmental Variables

## **One** of the following **MUST** be set:

* **PRODUCT_INITIALIZATION** _**(required)**_ - Initialize new installation or not. Actual if you use PVC in kubernetes
* **LINKING_KEY** _**(required)**_ - Linking key to use for linking the scanner to Tenable.io
* **LICENSE** _**(required)**_ - Activation code (if not a Tenable.io linked scanner)
* **SECURITYCENTER** _**(required)**_ - If the scanner is to be SecurityCenter linked, then simply set this variable to `Yes` instead of setting a _LICENSE_ or _LINKING_KEY_ variable.

## The following are **OPTIONAL** parameters

* **SCANNER_NAME** _(optional)_ - Override the default behavior of registering with the hostname
* **MANAGER_HOST** _(optional)_ - Nessus Manager address
* **MANAGER_PORT** _(optional)_ - Nessus Manager service port
* **PROXY_HOST** _(optional)_ - Proxy address
* **PROXY_PORT** _(optional)_ - Proxy service port
* **PROXY_USER** _(optional)_ - Proxy account username
* **PROXY_PASS** _(optional)_ - Proxy account password
* **PROXY_AGENT** _(optional)_ - Proxy agent string
* **ADMIN_USER** _(optional)_ - Username for admin user creation.  If not provided, defaults to `admin`.
* **ADMIN_PASS** _(optional)_ - Password for admin user creation.  If not provided, a password will be generated.
* **NO_ROOT** _(optional)_ - Set to `Yes` when wanting to [run Nessus as a non-privileged user](https://docs.tenable.com/nessus/6_9/Content/LinuxNonPrivileged.htm). You should only use this environment variable if you know _what_ you are doing and _why_ you are doing it.
* **NON_PRIV_USER** _(optional)_ - If _NO_ROOT_ is set, you may use this to specify a username that will be created and used. If left unset, the default is `nessus`.

# How-to update plugins

* Just re-activate existing license key in UI and wait