#!/bin/bash
echo "enter value for env"
read env
echo "Environment is set to $env"

if [ $env = "dev_qphi" ];
then
    sed -i 's+"qa_ax360_portal"+"ax360_portal_qphi"+g' manifest.lkml
    sed -i 's+"iapw-dm-d-qa1-datahub-connection"+"prj-iapw-dm-d-dev1-datahub"+g' manifest.lkml
    sed -i 's+"iapw-dm-d-qa1-datahub-1000"+"iapw-dm-d-dev1-datahub-1000"+g' manifest.lkml
    sed -i 's+value: "business_vault"+value: "business_vault_portal"+g' manifest.lkml
    sed -i 's+value: "ods_portal"+value: "ods"+g' manifest.lkml
    sed -i 's+value: "control_portal"+value: "control"+g' manifest.lkml
    sed -i 's+https://iapw.cloud.looker.com/dashboards/239+https://iawealthstg.cloud.looker.com/dashboards/239+g' manifest.lkml
    sed -i 's+_user_attributes\[\x27last_business_date_12_months\x27]+_user_attributes[\x27last_business_date_12_months_dev\x27]+g' */*.lkml
    sed -i 's+_user_attributes\[\x27latest_holding_date\x27]+_user_attributes[\x27latest_holding_date_dev\x27]+g' */*.lkml
    sed -i 's+_user_attributes\[\x27prev_holding_date\x27]+_user_attributes[\x27prev_holding_date_dev\x27]+g' */*.lkml
    sed -i 's+user_attribute: user_id+user_attribute: user_id_dev+g' */*.lkml
    if [ -e ./models/qa_ax360_portal.model.lkml ]
    then 
        mv ./models/qa_ax360_portal.model.lkml ./models/ax360_portal_qphi.model.lkml
    fi
    sed -i 's+model: qa_ax360_portal+model: ax360_portal_qphi+g' ./dashboards/*.lookml
    echo "the env is dev and variables are updated for supporting dev looker instance"
elif [ $env = "qa_qphi" ];
then
    sed -i 's+"ax360_portal_qphi"+"qa_ax360_portal"+g' manifest.lkml
    sed -i 's+"prj-iapw-dm-d-dev1-datahub"+"iapw-dm-d-qa1-datahub-connection"+g' manifest.lkml
    sed -i 's+"iapw-dm-d-dev1-datahub-1000"+"iapw-dm-d-qa1-datahub-1000"+g' manifest.lkml
    sed -i 's+value: "ods"+value: "ods_portal"+g' manifest.lkml
    sed -i 's+value: "control"+value: "control_portal"+g' manifest.lkml
    sed -i 's+https://iawealthstg.cloud.looker.com/dashboards/239+https://iapw.cloud.looker.com/dashboards/239+g' manifest.lkml
    sed -i 's+_user_attributes\[\x27last_business_date_12_months_dev\x27]+_user_attributes\[\x27last_business_date_12_months\x27]+g' */*.lkml
    sed -i 's+_user_attributes\[\x27latest_holding_date_dev\x27]+_user_attributes\[\x27latest_holding_date\x27]+g' */*.lkml
    sed -i 's+_user_attributes\[\x27prev_holding_date_dev\x27]+_user_attributes\[\x27prev_holding_date\x27]+g' */*.lkml
    sed -i 's+user_attribute: user_id_dev+user_attribute: user_id+g' */*.lkml
    if [ -e ./models/ax360_portal_qphi.model.lkml ]
    then 
        mv ./models/ax360_portal_qphi.model.lkml ./models/qa_ax360_portal.model.lkml
    fi
    sed -i 's+model: ax360_portal_qphi+model: qa_ax360_portal+g' ./dashboards/*.lookml
    echo "the env is qa and variables are updated for supporting qa looker instance"
elif [ $env = "uat" ];
then
    sed -i 's+"qa_ax360_portal"+"ax360_portal"+g' manifest.lkml
    sed -i 's+"iapw-dm-d-qa1-datahub-connection"+"uat1-datahub"+g' manifest.lkml
    sed -i 's+"iapw-dm-d-qa1-datahub-1000"+"iapw-dm-a-uat1-datahub-1000"+g' manifest.lkml
    sed -i 's+value: "business_vault_portal"+value: "business_vault"+g' manifest.lkml
    sed -i 's+value: "ods_portal"+value: "ods"+g' manifest.lkml
    sed -i 's+value: "control_portal"+value: "control"+g' manifest.lkml
    sed -i 's+https://iawealthstg.cloud.looker.com/dashboards/239+https://iapw.cloud.looker.com/dashboards/239+g' manifest.lkml
    sed -i 's+user_attribute: user_id_dev+user_attribute: user_id+g' */*.lkml
    if [ -e ./models/qa_ax360_portal.model.lkml ]
    then 
        mv ./models/qa_ax360_portal.model.lkml ./models/ax360_portal.model.lkml
    fi
    sed -i 's+model: qa_ax360_portal+model: ax360_portal+g' ./dashboards/*.lookml
    echo "the env is uat and variables are updated for supporting uat looker instance"
elif [ $env = "uat-to-qa" ];
then
    sed -i 's+"prj_ax360_portal"+"qa_ax360_portal"+g' manifest.lkml
    sed -i 's+"uat1-datahub"+"iapw-dm-d-qa1-datahub-connection"+g' manifest.lkml
    sed -i 's+"iapw-dm-a-uat1-datahub-1000"+"iapw-dm-d-qa1-datahub-1000"+g' manifest.lkml
    sed -i 's+value: "ods"+value: "ods_portal"+g' manifest.lkml
    sed -i 's+value: "control"+value: "control_portal"+g' manifest.lkml
    sed -i 's+https://iapw.cloud.looker.com/dashboards/239+https://iapw.cloud.looker.com/dashboards/239+g' manifest.lkml
    if [ -e ./models/ax360_portal.model.lkml ]
    then 
        mv ./models/ax360_portal.model.lkml ./models/qa_ax360_portal.model.lkml
    fi
    sed -i 's+model: ax360_portal+model: qa_ax360_portal+g' ./dashboards/*.lookml
    echo "the env is updated from uat to qa and variables are updated for supporting qa looker instance"
elif [ $env = "dev" ];
then
    sed -i 's+"qa_ax360_portal"+"prj_ax360_portal"+g' manifest.lkml
    sed -i 's+"iapw-dm-d-qa1-datahub-connection"+"prj-iapw-dm-d-dev1-datahub"+g' manifest.lkml
    sed -i 's+"iapw-dm-d-qa1-datahub-1000"+"iapw-dm-d-dev1-datahub-1000"+g' manifest.lkml
    sed -i 's+value: "ods_portal"+value: "ods"+g' manifest.lkml
    sed -i 's+value: "control_portal"+value: "control"+g' manifest.lkml
    sed -i 's+value: "business_vault_portal"+value: "business_vault"+g' manifest.lkml
    sed -i 's+https://iapw-acf-a-uat1-ax360-1000.web.app/looker-icons+https://iapw-acf-d-qa1-ax360-1000.web.app/looker-icons+g' manifest.lkml
    sed -i 's+_user_attributes\[\x27last_business_date_12_months\x27]+_user_attributes[\x27last_business_date_12_months_dev\x27]+g' */*.lkml
    sed -i 's+_user_attributes\[\x27latest_holding_date\x27]+_user_attributes[\x27latest_holding_date_dev\x27]+g' */*.lkml
    sed -i 's+_user_attributes\[\x27prev_holding_date\x27]+_user_attributes[\x27prev_holding_date_dev\x27]+g' */*.lkml
    sed -i 's+user_attribute: user_id+user_attribute: user_id_dev+g' */*.lkml
    if [ -e ./models/qa_ax360_portal.model.lkml ]
    then 
        mv ./models/qa_ax360_portal.model.lkml ./models/ax360_portal.model.lkml
    fi
    sed -i 's+model: qa_ax360_portal+model: ax360_portal+g' ./dashboards/*.lookml
    echo "the env is dev and variables are updated for supporting Accenture Dev looker instance"
elif [ $env = "qa" ];
then
    sed -i 's+"prj_ax360_portal"+"qa_ax360_portal"+g' manifest.lkml
    sed -i 's+"prj-iapw-dm-d-dev1-datahub"+"iapw-dm-d-qa1-datahub-connection"+g' manifest.lkml
    sed -i 's+"iapw-dm-d-dev1-datahub-1000"+"iapw-dm-d-qa1-datahub-1000"+g' manifest.lkml
    sed -i 's+value: "ods"+value: "ods_portal"+g' manifest.lkml
    sed -i 's+value: "control"+value: "control_portal"+g' manifest.lkml
    sed -i 's+value: "business_vault"+value: "business_vault_portal"+g' manifest.lkml
    sed -i 's+https://iapw-acf-d-qa1-ax360-1000.web.app/looker-icons+https://iapw-acf-a-uat1-ax360-1000.web.app/looker-icons+g' manifest.lkml
    sed -i 's+_user_attributes\[\x27last_business_date_12_months_dev\x27]+_user_attributes\[\x27last_business_date_12_months\x27]+g' */*.lkml
    sed -i 's+_user_attributes\[\x27latest_holding_date_dev\x27]+_user_attributes\[\x27latest_holding_date\x27]+g' */*.lkml
    sed -i 's+_user_attributes\[\x27prev_holding_date_dev\x27]+_user_attributes\[\x27prev_holding_date\x27]+g' */*.lkml
    sed -i 's+user_attribute: user_id_dev+user_attribute: user_id+g' */*.lkml
    if [ -e ./models/ax360_portal.model.lkml ]
    then 
        mv ./models/ax360_portal.model.lkml ./models/qa_ax360_portal.model.lkml
    fi
    sed -i 's+model: ax360_portal+model: qa_ax360_portal+g' ./dashboards/*.lookml
    echo "the env is qa and variables are updated for supporting QA looker instance"
elif [ $env = "training" ];
then
    sed -i 's+"prj_ax360_portal"+"ax360_portal"+g' manifest.lkml
    sed -i 's+"uat1-datahub"+"uat1-training"+g' manifest.lkml
    sed -i 's+"business_vault"+"business_vault_training"+g' manifest.lkml
    sed -i 's+value: "ods"+value: "ods_training"+g' manifest.lkml
    sed -i 's+value: "control"+value: "control_training"+g' manifest.lkml
    sed -i 's+https://iapw-acf-a-uat1-ax360-1000.web.app/looker-icons+https://ax360.iaprivatewealth.com/looker-icons+g' manifest.lkml
    sed -i 's+https://iapw.cloud.looker.com/dashboards/239+https://iawealth.cloud.looker.com/dashboards/239+g' manifest.lkml
    if [ -e ./models/ax360_portal.model.lkml ]
    then 
        mv ./models/ax360_portal.model.lkml ./models/model_ax360_training.model.lkml
    fi
    sed -i 's+model: ax360_portal+model: model_ax360_training+g' ./dashboards/*.lookml
    echo "the env is updated from uat to training and variables are updated for supporting training looker instance"
else
    echo "file is unchanged"
fi
