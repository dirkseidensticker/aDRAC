# CARD (Central African Radiocarbon Database)

*[Dirk Seidensticker M.A. (University of Cologne)](https://uni-koeln.academia.edu/DirkSeidensticker)*

The *Central African Radiocarbon Database* (CARD) aims at delivering a reliable and free to use dataset containing all available radiocarbon datings from Central Africa. Contributions are highly welcome.

The [CARD-Webapp](https://dirkseidensticker.shinyapps.io/webapp/) will help you to explore the dataset.

The [radiocarbon5-Web-App](https://nevrome.shinyapps.io/radiocarbon5/) of [Clemens Schmid](https://github.com/nevrome) provides another overview. The data are compiled through an [custom module](https://github.com/nevrome/neolithicR/blob/master/modules/CARD/data_processor.R).


## Structure of the Repository

| Folder | Description |
|-----------|-----------------------------------------------|
| /data | Contains the dataset itself as well as a description (.md file) |
| /Python | Examples of Python-Code |
| /R | Examples of R-Code  |
| /webapp | Files for a Shiny-Webapp which helps to explore the dataset | 


## Roadmap and ToDo's

* Refine the [Shiny-Web-App](https://dirkseidensticker.shinyapps.io/webapp/) (Code inside /webapp) which delivers a first easy-to-use interface
* Deploy R-Code which covers the same steps as the Python-Code
* Including the CARD-dataset into the 
## License

The dataset (inside /data) is licensed under the [Creative Commons Attribution 3.0 license](http://creativecommons.org/licenses/by/3.0/us/deed.en_US) while all source code is licensed under the [MIT license](http://opensource.org/licenses/mit-license.php).

## Citation

[![DOI](https://zenodo.org/badge/20329/dirkseidensticker/CARD.svg)](https://zenodo.org/badge/latestdoi/20329/dirkseidensticker/CARD)

Seidensticker, D. (2016), ‘CARD. Central African Radiocarbon Database’, Version 0.1 <https://github.com/dirkseidensticker/CARD>.