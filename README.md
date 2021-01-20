
# aDRAC (*Archives des datations radiocarbone d’Afrique centrale*)

[![DOI](https://zenodo.org/badge/20329/dirkseidensticker/aDRAC.svg)](https://zenodo.org/badge/latestdoi/20329/dirkseidensticker/aDRAC)

**Dirk Seidensticker** & **Wannes Hubau**

The *archive for radiocarbon datings from Central Africa* (aDRAC)
provides a catalogue of available radiocarbon dates from Central Africa.
The data cover published radiocarbon dates and the most essential
metadata for each date as well as available references.

<img src="README_files/figure-gfm/map-1.png" width="100%" style="display: block; margin: auto;" />

The [aDRAC-Webapp](https://dirkseidensticker.shinyapps.io/webapp/) will
help you to explore the dataset.

## Main Dataset **adrac.csv**

The main dataset is to be found within `/data/adrac.csv` The csv-file is
encoded in ‘UTF-8’. Geocoordinates are storred as longitude (`LONG`) and
latitude (`LAT`).

| Datafield     | Description                                                                                                                                             |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| LABNR         | Laboratory number; all spaces where changed/unified to dashes                                                                                           |
| C14AGE        | Carbon-14 Age                                                                                                                                           |
| C14STD        | Standard deviation                                                                                                                                      |
| C13           | Carbon-13 amount                                                                                                                                        |
| MATERIAL      | Dated Material                                                                                                                                          |
| SITE          | Name of the Site                                                                                                                                        |
| COUNTRY       | [ISO 3166-1 alpha-3](https://en.wikipedia.org/wiki/ISO_3166-1) three-letter country code                                                                |
| FEATURE       | Designation of the Feature                                                                                                                              |
| FEATURE\_DESC | Category of the Feature                                                                                                                                 |
| PHASE         | Basic chronological association                                                                                                                         |
| POTTERY       | Associated pottery styles; see [List of style groups](https://github.com/dirkseidensticker/nwCongo/blob/master/bib/StilGrChrono.csv)                    |
| REL           | Reliability of the context of a date and if it should be used for archaeological questions (e.g. settlement history); 0 not to be relied on; 1 reliable |
| LAT           | Latitude as decimal degrees                                                                                                                             |
| LONG          | Longitude as decimal degrees                                                                                                                            |
| DEPTH         | Depth below surface in meters. In case that the original source only gave a range, then the mean depth has been recorded.                               |
| SOURCE        | Source                                                                                                                                                  |

The literature used to compile the dataset is to be found within the
`SOURCES.md` file.

### Coordinates

All geo-coordinates included within **aDRAC** are either obtained from
the published sources that contained the radiocarbon dates itself or
were derived by searching for the name of the site in
[geonames.org](http://www.geonames.org/). If published the coordinates
were converted into WGS84 (EPSG:4326). Coordinates are rounded to three
degrees, giving a rough precision of about 100m.

## c14bazAAR

The data are accessible through the
[c14bazAAR](https://github.com/ropensci/c14bazAAR) of [Clemens
Schmid](https://github.com/nevrome) *et al.* through a **custom module**
(`c14bazAAR::get_c14data("adrac")`).

## License

The aDRAC-dataset is made available under the [Open Database
License](http://opendatacommons.org/licenses/odbl/1.0/). Any rights in
individual contents of the database are licensed under the [Database
Contents License](http://opendatacommons.org/licenses/dbcl/1.0/).

## How to cite

Seidensticker, D. & W. Hubau (2021), ‘aDRAC. Archives des datations
radiocarbone d’Afrique centrale’, Version 2.0
<https://github.com/dirkseidensticker/aDRAC>.
