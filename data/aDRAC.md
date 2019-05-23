# Description of the aDRAC-Dataset

| Datafield | Description |
|-----------|-------------|
| LABNR | Laboratory number; all spaces where changed/unified to dashes |
| C14AGE | Carbon-14 Age |
| C14STD | Standard deviation |
| C13 | Carbon-13 amount |
| MATERIAL | Dated Material |
| SITE | Name of the Site |
| COUNTRY | [ISO 3166-1 alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1) three-letter country code |
| FEATURE | Designation of the Feature |
| FEATURE_DESC | Category of the Feature |
| PHASE | Basic chronological association |
| POTTERY | Associated pottery styles; see [List of style groups](https://github.com/dirkseidensticker/nwCongo/blob/master/bib/StilGrChrono.csv) |
| REL | Reliability of the context of a date and if it should be used for archaeological questions (e.g. settlement history); 0 not to be relied on; 1 reliable |
| LAT | Latitude as decimal degrees <sup>1</sup> |
| LONG | Longitude as decimal degrees <sup>1</sup> |
| DEPTH | Depth below surface in meters. In case that the original source only gave a range, then the mean depth has been recorded. |
| SOURCE | Source |

---
1 All geo-coordinates included within aDRAC are either obtained from the published sources that contained the radiocarbon dates itself or were derived by searching for the name of the site within [geonames.org](http://www.geonames.org/)
