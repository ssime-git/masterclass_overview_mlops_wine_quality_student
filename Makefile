dvc-setup:
	dvc remote add origin s3://dvc --force
	dvc remote modify origin endpointurl https://dagshub.com/ssime-git/masterclass_overview_mlops_wine_quality_student.s3
	dvc remote default origin
	dvc remote modify origin --local access_key_id 5381c3491d216fe52c6437c5e7e7b102e59477e9
	dvc remote modify origin --local secret_access_key 5381c3491d216fe52c6437c5e7e7b102e59477e9

