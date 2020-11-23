# MGH Center for Addiction Data Challenge

Congratulations! If you've made it this far in our application process, we were very impressed with your experience and interview(s)!

Because we would like to hire you for a technical position, we want to make sure your skills have prepared you well to succeed at our Center. Rather than ask you on-the-spot coding/technical questions, we would rather see how you perform with a take-home assignment. As fellow coders, we know that Google is often your best friend!

We take this process seriously and only ask very few people to work on this, so our expectation is that you'll do well at it! Don't stress--think of this as an opportunity to both show us your skills and to learn the types of problems we encounter in our daily work.

## Data Challenge

We have created a shuffled and partially redacted dataset (to avoid any HIPAA violations). Otherwise, it is actual data that you will encounter at CAM.

There are several parts to this challenge. At any point, do not hesitate to contact us:

- Statistician: Kevin Potter, <kpotter5@mgh.harvard.edu>
- Programmer: William Schmitt, <waschmitt@mgh.harvard.edu>

We expect this to take a few hours of your time, and it is okay if you reach a roadblock and would like to check in with us/ask us questions.

### Part 1: Wrangle the data

You've been given two .csv files, `baseline.csv` and `cleaned_quit_and_co.csv` that come from our large-scale, pragmatic Patient-Centered Outcomes Research Institute (PCORI) trial. 

This study examined the impact of two types of intervention to help patients with severe mental illness (SMI) quit smoking. The first intervention was academic detailing (AD), a indirect approach where a patient's primary care physician (PCP) was taught about the efficacy of cessation medications for helping patients quit. The second intervention involved having patients work with a community health worker (CHW). Patients completed surveys over 3 time points, baseline, year 1, and year 2 of the intervention.

We'd like you to merge these two datasets into one tidy dataset for your subsequent analyses. As part of this, we expect you will need to do the following:

- Transition the `cleaned_quit_and_co.csv` to [long format](https://www.theanalysisfactor.com/wide-and-long-data/). 
- Reduce the dataset to the variables you need for subsequent work (see below)
- Build a data dictionary to describe the variables present within your final dataset.

In [/docs](./docs) we have provided the "Codebook" for the REDCap project where data was collected. This codebook provides a window into what data some of the variables in the `.csv` files reflect. The leftmost column reflects the variable name, while the rightmost column provides the mapping between values and labels. If you have questions about variables and what they represent, feel free to contact Kevin Potter or William Schmitt. It is a usual part of the process to have to check in with team members regarding confusingly-labeled variables, so do not worry if you have questions!

### Part 2: Summarize the data

Using your freshly created tidy dataset, please produce a demographic table describing the sample. We expect this to split the participants according to randomization group, and have the following information:

- Sample Size
- Race/Ethnicity
- Sex
- Age
- Other relevant baseline variables (use your discretion here--what might seem relevant to know, particularly given what you will graph in part 3)?

### Part 3: Graph the data

Pick one outcome variable from the `cleaned_quit_and_co.csv` that interests you and create a figure that investigates that variable by experimental arm and time.


## What We are Looking For

While good research requires a lot of qualities, this position will require, above all, extreme meticulousness and attention to detail. You will be a crucial step between data wrangling/management and publicized results, so you need to ensure the integrity and validity of the deliverables you provide. In particular:

- **Code:** We value (and endeavor ourselves to write) clean, well-commented, and reproducible code. We rely on each other's code all the time, and our goal is to standardize the work we do across projects at the Center, so we hope that the code written for one problem can often be ported over to solve another. We've included the script that we used to shuffle the data to give you a window into how we write and structure our code.

- **Thought Process:** More important than your code, we would love to see you walk us through how you arrived at your final product. What assumptions or technical decisions did you make along the way? Can you communicate those decisions in a clear, concise, and intuitive manner? How can we trace the transformations from the original dataset to your final results?

- **Deliverables:** At CAM, you would be working both with the Statistician, Programmer, and other technical users who would be interested in your code and analyses. However, you will also need to show your reports and products to RAs, PIs, and the Director, who value clean, simple reports. Thus, we expect that in addition to any code you write, you'll have intuitive final data files, figures, and tables in universal file formats (e.g. `.csv`, `.pdf`, `.docx`, etc.)

## What You'll Need

### Data

The data can be found in [/data](./data) in `.csv` files. Please save your final dataset in a similar format, or one that plays nicely with R (e.g. `.RData`). We often share our work using `.csv`, as there are often non-technical users that would like to look through the dataset.

### Software/Programming Languages

Our lab's codebase is predominantly R. We would love to see your work in this language, but we have intentionally designed this to be language agnostic. If there is another language that comes more naturally, feel free to rely on that. What we care more about is your ability to wrangle and manipulate the data. If you have a good handle on how to do this in another language, we think you will have no trouble learning R. You might even teach us a thing or two, too! Regardless of the path you choose, make sure there's a way for us to see the steps you've taken and to know what dependencies we need to install/use. We have taken to GitLab to provide this record, but again, if there's a system you already have, feel free to rely on that.

## Submission

To submit your work, please upload the relevant files including code, a README file that allows us to navigate your work, and the final deliverables to this [DropBox folder](https://www.dropbox.com/request/NNPDIjcjG4AeSy2QqdMO). If you would prefer to submit a git repo, please feel free to upload a file (e.g. `.docx` or `.pdf`) with the link to your GitHub repo. Please ensure your visiblity settings allow us to see and clone the repo.
