# Quick Triage Script

For situations where a quick assessment needs to be made of a powered up, Windows device.
This script is designed to be configured for collection of specfic data. As more data requirements are identified they will be added to the body of the script.

In additon to any collection output (such as process lists), this script will keep a log of activities and timestamps.

## Use

Run this script as an administrator.

## Functionality List

As of 20 Jan 1018, this script carries out the following:

* List running processes into a text file
* Check for thread injection
* Check for _obvious_ signs of process impersonation
* List running services into a text file
* List stopped services into a text file
