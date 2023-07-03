# From Pattern to Process - COSMOS

This repo contains the code and sample data for a [COSMOS 2023](https://cosmos-konstanz.github.io/) group project. The code and data are from _The interplay between age structure and cultural transmission (Kandler, Fogarty & Karsdorp, 2023; in press.)_.

## ./Code

contains code generating a random sample from a population evolving through unbiased transmission at equilibrium. The code is not written for speed but for easy understanding.

Matlab:

- main_unbiased.m

- get_hillNumbers.m

R:

- main_unbiased.R

Julia:

- main_unbiased.jl


## ./Data

contains files for five populations. They contain samples of size 100. Each value describes the type of the variant. E.g. [11,303,11,712] means that there are two variants of type 11, one of type 303 and one of type 712.