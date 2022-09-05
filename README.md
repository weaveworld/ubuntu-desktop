# **ubuntu-desktop** and **selenium** docker images

## Ubuntu Desktop `(weaveworld/ubuntu-desktop)`

**[Ubuntu Desktop](https://en.wikipedia.org/wiki/Ubuntu_version_history#Ubuntu_20.04_LTS_(Focal_Fossa))** (LXDE) docker image with **[Firefox](https://www.mozilla.org/en-US/firefox/)**, **[Chrome](https://www.google.com/chrome/)** and **[Edge](https://www.microsoft.com/en-us/edge)** browsers.

Dockerhub: https://hub.docker.com/repository/docker/weaveworld/ubuntu-desktop

The user is `app` (`1111:1111`), having the `/home/app` home directory.

Access:
  - novnc port: `7900` ; e. g., http://localhost:7900/vnc_auto.html
  - vnc port: `5900`

Example:
  - `docker-compose.yml`
```docker-compose.yml
version: "3.8"

services:
  desktop:
    image: "weaveworld/ubuntu-desktop:u20-20220901"  
    ports:
      - 7900:7900
      - 5900:5900
    shm_size: '2gb'
    environment:
      - DISPLAY_WIDTH=1024
      - DISPLAY_HEIGHT=768
```  
- start: `docker-compose up -d`
- visit: http://localhost:7900/vnc_auto.html
- end: `docker-compose down`

## Selenium `(weaveworld/selenium)`

**[Ubuntu Desktop](https://en.wikipedia.org/wiki/Ubuntu_version_history#Ubuntu_20.04_LTS_(Focal_Fossa))** (LXDE) docker image with **[Firefox](https://www.mozilla.org/en-US/firefox/)**, **[Chrome](https://www.google.com/chrome/)** and **[Edge](https://www.microsoft.com/en-us/edge)** browsers and the corresponding **[Selenium](https://www.selenium.dev/) [WebDrivers](https://www.selenium.dev/documentation/webdriver/)**, i. e., **[GeckoDriver](https://github.com/mozilla/geckodriver)**, **[ChromeDriver](https://chromedriver.chromium.org/)** and **[EdgeDriver](https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/)**, that are accessible by the Selenium **[Remote WebDriver](https://www.selenium.dev/documentation/webdriver/remote_webdriver/)** using the Selenium Server.

Dockerhub: https://hub.docker.com/repository/docker/weaveworld/selenium

Example:
  - `docker-compose.yml`
```docker-compose.yml
version: "3.8"

services:
  desktop:
    image: "weaveworld/selenium:u20-20220901"  
    ports:
      - 7900:7900
      - 5900:5900
      - 4444:4444
    shm_size: '2gb'
```  
- start: `docker-compose up -d`
- visit: http://localhost:7900/vnc_auto.html
- connect:
```
FirefoxOptions firefoxOptions = new FirefoxOptions();
WebDriver driver = new RemoteWebDriver(new URL("http://host.docker.internal:4444"), firefoxOptions);
driver.get("http://www.google.com");
driver.quit();
```  
- use `ChromeOptions` for Chrome or `EdgeOptions` for Edge with the same `:4444` port
- get browser and driver version info:<br>
`docker run -it --rm weaveworld/selenium:u20-20220901 /etc/selenium_info`
- end: `docker-compose down`

## Images

  - [weaveworld/ubuntu](weaveworld_ubuntu) - base ubuntu docker image
  - [weaveworld/ubuntu-desktop](weaveworld_ubuntu-desktop) - Ubuntu Desktop with Firefox, Chrome and Edge browsers 
  - [weaveworld/selenium](weaveworld_selenium) - Ubuntu Desktop with browsers and selenium drivers 

Docker image tag format: `u`*<sup>{{ubuntu}}</sup>*`-`*<sup>{{date}}</sup>*
  - *<sup>{{ubuntu}}</sup>* - Ubuntu version
  - *<sup>{{date}}</sup>* - version-date
  - e. g., `ubuntu-desktop:u20-20220901` 