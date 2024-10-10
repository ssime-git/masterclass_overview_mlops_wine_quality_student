# Setting up an MLOps project step by step 🚀

Welcome to the setup guide! Here, we'll outline the steps needed to configure and implement the various first stages of the MLOps pipeline. Follow along and fill in the details as you proceed through each step in the `workflow_steps.ipynb` notebook.

You can start by getting familiar with the architecture of the project: 

```bash
.
├── Makefile
├── README.md
├── __init__.py
├── __pycache__
│   ├── custom_logger.cpython-311.pyc
│   └── custom_logger.cpython-312.pyc
├── custom_logger.py
├── data
│   ├── processed
│   │   ├── X_test.csv
│   │   ├── X_train.csv
│   │   ├── y_test.csv
│   │   └── y_train.csv
│   ├── raw
│   │   ├── data.zip
│   │   └── winequality-red.csv
│   └── status.txt
├── dvc.lock
├── dvc.yaml
├── logs
│   └── logs.log
├── metrics
│   └── metrics.json
├── models
│   └── model.joblib
├── notebooks
│   └── workflow_steps.ipynb
├── requirements.txt
├── src
│   ├── __init__.py
│   ├── app
│   │   └── app.py
│   ├── common_utils.py
│   ├── config.py
│   ├── config.yaml
│   ├── config_manager.py
│   ├── data_module_def
│   │   ├── __init__.py
│   │   │   ├── data_ingestion.cpython-311.pyc
│   │   │   ├── data_ingestion.cpython-312.pyc
│   │   │   ├── data_transformation.cpython-312.pyc
│   │   │   └── data_validation.cpython-312.pyc
│   │   ├── data_ingestion.py
│   │   ├── data_transformation.py
│   │   ├── data_validation.py
│   │   └── schema.yaml
│   ├── entity.py
│   ├── models_module_def
│   │   ├── __init__.py
│   │   ├── model_evaluation.py
│   │   ├── model_trainer.py
│   │   └── params.yaml
│   └── pipeline_steps
│       ├── __init__.py
│       ├── prediction.py
│       ├── stage01_data_ingestion.py
│       ├── stage02_data_validation.py
│       ├── stage03_data_transformation.py
│       ├── stage04_model_trainer.py
│       └── stage05_model_evaluation.py
├── templates
│   ├── index.html
│   ├── login.html
│   ├── register.html
│   └── results.html
└── users
    └── users.json
```
Through this project we'll work with a wine dataset 🍷 The goal will be to implement a model that will predict its quality, all while adhering to the best practices in MLOps in terms of version control, use of pipelines and the most commonly used tools.

## Project setup
First of all you need to start by forking and cloning the project. Then, you will need to create a copy of the github repo within dagshub. This will allow you to use the version control system and the data version control system (DVC) to keep track of the changes you make to the project.

Finally, you must create a virtual environment `.venv`where you'll install all the necessary libraries. These can be found in the `requirements.txt` file. 

> 📚 Make sure you activate your virtual environment before you use it 😉.
> If you have an error, you can remove the versions specified in the `requirements.txt` file.

Now let's go through the files that are readily available.

## Configuration Files 📘
Let's have a quick look at the three `yaml` files in our `src` folder.

You can start by having a look at the `config.yaml` 📂 You will see that it sets the paths to the different files that will be used and created in each of the steps we'll put in place.

Next, inside the `data_module_def` folder we have the `schema.yaml` 🗃️ If you have a look at it you'll see it defines the data types for each column in the dataset we'll work with.

Finally, inside the `models_module_def` folder  you can have a look at `params.yaml` 📊 What this file does is set the hyperparameters of the model we'll put in place.

⚠️ The file `src/config.py` defines the global variables containing the paths to these yaml files to facilitate their access. 

## Common Utilities 🛠️ 
In `src/common_utils.py` we have reusable functions:

* read_yaml(filepath: str) -> dict
* create_directories(paths: List[str])
* save_json(path: str, data: dict)
* load_json

These utilities will streamline the loading of configurations and ensure necessary directories are created.

Let' get to work!

## The task
For the next steps you can use the notebook `workflow_steps.ipynb` to guide you through the code you'll need to write on each of the corresponding files 🧑‍💻 The task consist of five steps which will help you implement a modularized workflow of an MLOps project.

## Step 1: Define Configuration Classes 🧩
Start by writing the configuration objects in `src/entity.py`. These configurations will help in managing the settings and parameters required for each stage in a clean and organized manner. Using the *Step 1* section in the notebook, define `dataclasses` for configuration objects:

* DataIngestionConfig
* DataValidationConfig
* DataTransformationConfig
* ModelTrainerConfig
* ModelEvaluationConfig

## Step 2: Configuration Manager 🗄️
Create the class `ConfigurationManager` in `src/config_manager.py` using the *Step 2* of the notebook. This class will:

* Read paths from `config.yaml`.
* Read hyperparameters from `params.yaml`.
* Read the data types from `schema.yaml`.
* Create configuration objects for each of the stages through the help of the objects defined on the step before: DataIngestionConfig, DataValidationConfig, ModelTrainerConfig and ModelEvaluationConfig.
* Create necessary folders.

⚠️ Pay attention to the `mlflow_uri` on the `get_model_evaluation_config`, make sure you adapt it with your own dagshub credentials. 

## Step 3: Data module definition and model module definition.

### Data module definition
Using the *Step 3* section of the notebook, in the corresponding files of the  `src/data_module_def` folder, create:

1. Data Ingestion module 📥

This class will:
* Download the dataset into the appropriate folder.
* Unzip the dataset into the appropriate folder.

2. Data Validation module ✅

This class will:
* Validate columns against the schema. Optional: you can also verify the informatic type.
* Issue a text file saying if the data is valid.

3. Data Transformation module 🔄

This class will:
* Split the data into training and test sets.
* Save the corresponding csv files into the appropriate folder.

### Model module definition
Similarly, in the corresponding files of the `src/models_module_def` folder, create:

1. Model trainer module 🏋️‍♂️

This class will:
* Train the model using the hyperparameters specified in `params.yaml`.
* Save the trained model into the appropriate folder.

2. Model Evaluation module 📝

Make sure to update the `repo_name`and `repo_name`in the `model_evaluation/py` file with your own dagshub credentials.

This class will
* Evaluate the model and log metrics using MLFlow

## Step 4: Pipeline Steps 🚀
Using the *Step 4* of the notebook, in `src/pipeline_steps` create scripts for each stage of the pipeline to instantiate and run the processes:

* stage01_data_ingestion.py
* stage02_data_validation.py
* stage03_data_transformation.py
* stage04_model_trainer.py
* stage05_model_evaluation.py

On each script you have to complete the classes with two methods: an `__init__` that doesn't do anything, and a `main` where you have to implement the code in each section of the *Step 4* of the notebook.

## Step 5: Use DVC to connect the different stages of your pipeline 🦉
Start by setting DagsHub as your distant storage through DVC.
> you can find the command to execute on dagshub account `remote > data > dvc >s3`

```bash
	dvc remote add origin s3://dvc --force
	dvc remote modify origin endpointurl https://dagshub.com/ssime-git/masterclass_overview_mlops_wine_quality_student.s3
	dvc remote default origin
	dvc remote modify origin --local access_key_id <your_access_key_id>
	dvc remote modify origin --local secret_access_key <your_secret_access_key>
```

Use dvc to connect the different steps of your pipeline.

For example, the command for addind the first step of the pipeline is: 

```bash
dvc stage add -n data_ingestion -d wine_quality/src/pipeline_steps/stage01_data_ingestion.py -d wine_quality/src/config.yaml -o wine_quality/data/raw/winequality-red.csv python wine_quality/src/pipeline_steps/stage01_data_ingestion.py
```
Add the following steps for the data transformation, data validation, model training and model evaluation.

You can run the pipeline through the command `dvc repro`.

Congratulations! 🎉 Now that you have a structured and well-defined MLOps project you're ready for the next step which is the creation of the API.

Each step is modularized, making it easy to maintain, extend, and scale your Machine Learning pipeline. 

Don't forget to commit your changes and push them to your GitHub repository.
```sh
git add .
git commit -m "commit message"
git push
dvc commit
dvc push
```
