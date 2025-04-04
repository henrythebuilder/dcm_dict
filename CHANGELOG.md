# DcmDict project Changelog
---
## v0.63.1 (2025-03-23)
* Updated dcm_dict.gemspec due to a security update for the Nokogiri gem

### Note
* Nokogiri v1.18.4 updates packaged libxslt to v1.1.43 to resolve multiple CVEs

[Advisory GHSA-mrxw-mxhj-p664 (nokogiri)](https://rubysec.com/advisories/GHSA-mrxw-mxhj-p664/)
___
## v0.63.0 (2025-03-16)
* Update to 2025a Base Standard
---
## v0.62.0 (2025-02-20)
* Fix Ruby 3.4 compatibility for 'Frozen String Literal'
---
## v0.61.2 (2025-02-20)
* Updated dcm_dict.gemspec due to a security update for the Nokogiri gem

### Note
* Nokogiri v1.18.3 upgrades its dependency libxml2 to v2.13.6

[resolve CVE-2025-24928 and CVE-2024-56171](https://rubysec.com/advisories/GHSA-vvfq-8hwr-qm4m)
___
## v0.61.1 (2025-01-01)
* Not publish on [RubyGems](https://rubygems.org/gems/dcm_dict)
* Update copyright years
* Updated gemspec requirements
#### Note for gemspec
> Development Dependency fixed to latest tested version
___
## v0.61.0 (2024-12-28)
* Update to 2024e Base Standard
___
## v0.60.0 (2024-10-15)
* Update to 2024d Base Standard
___
## v0.59.0 (2024-07-09)
* Update to 2024c Base Standard
___
## v0.58.0 (2024-04-03)
* Update to 2024b Base Standard
___
## v0.57.0 (2024-02-07)
* Update to 2024a Base Standard
___
## v0.56.1 (2024-01-02)
* Bump copyright years
* Not publish on [RubyGems](https://rubygems.org/gems/dcm_dict)
___
## v0.56.0 (2023-12-15)
* Update to 2023e Base Standard
___
## v0.55.0 (2023-09-20)
* Update to 2023d Base Standard
* Not publish on [RubyGems](https://rubygems.org/gems/dcm_dict)
___
## v0.54.0 (2023-07-16)
* Update to 2023c Base Standard
___
## v0.53.0 (2023-05-03)
* Update to 2023b Base Standard
___
## v0.52.0 (2023-02-09)
* Update to 2023a Base Standard
___
## v0.51.0 (2023-02-09)
* Not publish on [RubyGems](https://rubygems.org/gems/dcm_dict)
* Updated gemspec requirements
#### Note for gemspec
> Required Ruby Version fixed for stable releases (>= 3.0)
> Development Dependency fixed to latest tested version
___
## v0.50.0 (2023-02-09)
* Not publish on [RubyGems](https://rubygems.org/gems/dcm_dict)
* Updated gemspec(dcm_dict requires Ruby version >= 2.1, < 3.2)
#### Note for gemspec
> Refinement#include is deprecated and will be removed in Ruby 3.2
___
## v0.41.0 (2023-01-14)
* Update to 2022e Base Standard
* Update copyright year
___
## v0.40.0 (2022-11-25)
* Update to 2022d Base Standard
___
## v0.39.0 (2022-07-29)
* Update to 2022c Base Standard
___
## v0.38.1 (2022-04-29)
* Fix Changelog for release 0.38.0
* Not publish on [RubyGems](https://rubygems.org/gems/dcm_dict)
___
## v0.38.0 (2022-04-29)
* Update to 2022b Base Standard
___
## v0.37.0 (2022-01-30)
* Update to 2022a Base Standard
___
## v0.36.0 (2021-11-23)
* Update to 2021e Base Standard
___
## v0.35.0 (2021-09-16)
* Update to 2021d Base Standard
___
## v0.34.0 (2021-08-09)
* Update to 2021c Base Standard
___
## v0.33.0 (2021-04-13)
* Update to 2021b Base Standard
___
## v0.32.0 (2021-02-07)
* Update to 2021a Base Standard
___
## v0.31.0 (2020-12-07)
* Update to 2020e Base Standard
___
## v0.30.0 (2020-10-03)
* Update to 2020d Base Standard
* Add keywords support for standard UIDs
___
## v0.29.0 (2020-07-21)
* Update to 2020c Base Standard
___
## v0.28.1 (2020-03-18)
* Updated dcm_dict.gemspec due to a security vulnerabilities into the Rake gem as defined into gemspec (>=10.3 to >=12.3.3)
#### Note for gemspec security report:
>rake vulnerability found in dcm_dict.gemspec:
>CVE-2020-8130 (moderate severity)
>Vulnerable versions: <= 12.3.2
>Patched version: 12.3.3
>There is an OS command injection vulnerability in Ruby Rake before 12.3.3 in Rake::FileList when supplying a filename that begins with the pipe character |.
>
>Remediation:
>Upgrade rake to version 12.3.3 or later.
>
>["OS Command Injection in Rake"](https://github.com/advisories/GHSA-jppv-gw3r-w3q8)
>["CVE-2020-8130 Detail"](https://nvd.nist.gov/vuln/detail/CVE-2020-8130)
___
## v0.28.0 (2020-03-18)
* Update to 2020b Base Standard
* Remove warning for deprecated method 'Kernel#open'
___
## v0.27.0 (2020-02-05)
* Update to 2020a Base Standard
___
## v0.26.2 (2020-02-05)
* Update copyright year
___
## v0.26.1 (2020-01-03)
* Fix test to be compatible with ruby 2.7
* (No Dictionary Change from 2019e)
___
## v0.26.0 (2019-11-20)
* Update to 2019e Base Standard
___
## v0.25.0 (2019-10-04)
* Update to 2019d Base Standard
___
## v0.24.0 (2019-06-19)
* Update to 2019c Base Standard
* (No Dictionary Change from 2019b)
___
## v0.23.0 (2019-05-18)
* Update to 2019b Base Standard
* Update source url for xml data
___
## v0.22.0 (2019-02-15)
* Update to 2019a Base Standard
* Update copyright year
___
## v0.21.1 (2018-12-07)
* Update gemspec (fix CHANGELOG.md file reference)
___
## v0.21.0 (2018-12-07)
* Update to 2018e Base Standard
___
## v0.20.3 (2018-12-07)
* Migrate Changelog file to markdown format (CHANGELOG.md)
___
## v0.20.2 (2018-10-12)
* Update Changelog
___
## v0.20.1 (2018-10-12)
* Updated dcm_dict.gemspec for Nokogiri gem due to a security vulnerabilities into libxml2 library (ref 1.8.5).
#### Note:
* [Rubysec advisories (cve #2018-14404 - 2018-10-04)](https://rubysec.com/advisories/nokogiri-CVE-2018-14404)
* [Ruby Weekly Issue (#420 - 2018-10-11)](https://rubyweekly.com/issues/420)
___
## v0.20.0 (2018-10-01)
* Update to 2018d Base Standard
___
## v0.19.0 (2018-07-16)
* Update to 2018c Base Standard
___
## v0.18.1 (2018-06-05)
* Updated dcm_dict.gemspec due to a security vulnerabilities into the Nokogiri gem as defined into gemspec (v1.6 to v1.8)
#### Note for gemspec security report:
>Security vulnerability detected in GemSpec:
>Found a potential security vulnerability in one dependencies (sparklemotion/nokogiri).*
>A dependency defined in dcm_dict.gemspec has known security vulnerabilities and should be updated.*
>Known vulnerability found 'CVE-2017-9050' (Critical severity)*
>
>["libxml2 20904-GITv2.9.4-16-g0741801 is vulnerable to a heap-based buffer over-read in the xmlDictAddString function in dict.c..."](https://www.cvedetails.com/cve/CVE-2017-9050/)
>
>dcm_dict.gemspec update suggested: nokogiri ~> 1.8.1*
___
## v0.18.0 (2018-04-13)
* Update to 2018b Base Standard
___
## v0.17.1 (2018-03-07)
* Update DICOM reference into 'README'
* Update dcm_dict.gemspec
___
## v0.17.0 (2018-02-23)
* Update to 2018a Base Standard
___
## v0.16.0 (2017-12-13)
* Update to 2017e Base Standard
___
## v0.15.0 (2017-09-27)
* Update to 2017d Base Standard
___
## v0.14.0 (2017-06-08)
* Update to 2017c Base Standard
___
## v0.13.0 (2017-05-15)
* Update to 2017b Base Standard
___
## v0.12.1 (2017-03-14)
* Update Changelog file
___
## v0.12.0 (2017-03-14)
* Update to 2017a Base Standard
___
## v0.11.0 (2016-11-26)
* Update to 2016e Base Standard
___
## v0.10.0 (2016-10-10)
* Update to 2016d Base Standard
* Fix symbol extraction for keyword tag with "RTROI", "DVHROI", "OCTZ", "WADORS", "STOWRS", "CIExy", "RGBLUT", "VOILUT", "CTDIvol", "XAXRF", "CurrentInuA", "TimeInuS", "ExposureInuAs" and "dBdt" values
___
## v0.9.0 (2016-06-15)
* Update to 2016c Base Standard
___
## v0.8.0 (2016-04-13)
* Update to 2016b Base Standard
___
## v0.7.0 (2016-02-24)
* Update to 2016a Base Standard
___
## v0.6.1 (2015-07-06)
* Update Changelog file
___
## v0.6.0 (2015-07-06)
* Update to 2015c Base Standard
___
## v0.5.0 (2015-04-24)
* Update to 2015b Base Standard
___
## v0.4.0 (2015-02-09)
* Update to 2015a Base Standard
___
## v0.3.0 (2014-12-01)
* Update to 2014c Base Standard
___
## v0.2.0 (2014-09-22)
* Update to 2014b Base Standard
___
## v0.1.1 (2014-08-16)
* Update README file to fix some issues on files generated by rubydoc.info
___
## v0.1.0 (2014-08-16)
* Initial version
___
