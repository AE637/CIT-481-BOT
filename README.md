# CIT-481-BOT
New repo for final 481 project - ChatOps
- Alex Enaceanu
- Erik Blomquist

## Tools/Technologies used
![Diagram Image](./images/Diagram.png)
- [Terraform](#terraform)
- [Slack and Hubot](#slack-and-hubot)
- [StackStorm](#stackstorm)
- [Ansible](#ansible)


## How to execute

Make sure that you have downloaded your private-key-file.pem before starting. Follow instructions below carefully.

### Terraform
1. Clone Project

        git clone https://github.com/ErikBlomquist/CIT-481-BOT
        cd CIT-481-BOT/terraform

2. Initialize Terraform

        terraform init

3. Pass Environment Variables

        export TF_VAR_aws_access_key='ACCESS-KEY-GOES-HERE'
        export TF_VAR_aws_secret_key='SECRET-KEY-GOES-HERE'
        export TF_VAR_aws_region='us-west-2'
        export TF_VAR_aws_key_pair='test'
        export TF_VAR_aws_private_key_pem='~/ChatOps/test.pem'
        export TF_VAR_stackstorm_password="testp"

4. Terraform Plan & Apply

        terraform plan
        terraform apply 

6. SSH into your instance

        ssh -i ~/path-to-your-key/test.pem ubuntu@YOUR-PUBLIC-IP


## Slack and Hubot
### Prepare Slack
1. Head over to https://api.slack.com/
2. Click ``Start Building``
3. Fill out ``App Name`` (I picked Fat-Lou) and then select your workspace under ``Development Slack Workspace`` and then ``Create App``.
4. Click ``Bots``.
5. Click ``Add a Bot User``.
6. Click ``OAuth & Permissions`` and then ``Install App to Workspace``.
7. Select your workspace and click ``Authorize``.
8. Copy the ``Bot User OAuth Access Token``, we'll need it later.

### Setup Hubot
1. Go to your Slack workspace where you want to implement the bot and click ``Apps`` in the bottom left corner.
2. In the search field, type ``hubot``and click on the only showing result.
3. You should be re-directed to a slack wegpage. Click ``Install``.
4. Add a Username and then click ``Add Hubot Integration``.
5. Scroll down to ``Integration Settings`` and save the ``API Token`` securely.

## Invite Bot
Go to your Slack workspace and type /invite @name-of-your-bot:

        /invite @fat-lou 

## StackStorm
1. Once you have logged into your instance, you need to create a Stackstorm API key, once created copy it.

        st2 apikey create -k
2. We need to configure Stackstorm.

        sudo vi /opt/stackstorm/chatops/st2chatops.env
3. Uncomment the following variables and make sure to replace them with your own values.

        export HUBOT_NAME=fat-lou 
        export HUBOT_ALIAS='!' 

        export ST2_API_KEY="INSERT-YOUR-API-KEY-GENERATED-IN-STEP-1"
        export ST2_AUTH_USERNAME="st2admin" 
        export ST2_AUTH_PASSWORD="testp" 

        export HUBOT_ADAPTER="slack" 
        export HUBOT_SLACK_TOKEN="xoxb-YOUR-HUBOT_SLACK_TOKEN" 

4. From your cmd, install the Ansible plugin for StackStorm.

        st2 pack install ansible 

4. Start/Stop/Restart service 

        sudo systemctl start st2chatops
        sudo systemctl restart st2chatops

        sudo st2ctl start
        sudo st2ctl reload
                
        sudo st2ctl reload --register-aliases

5. You should be able to see your bot online on Slack once your StackStorm service has restarted.

6. Install pack 
                !pack install https://github.com/armab/st2_chatops_aliases

## Ansible
### Run Ansible Playbook from Slack
        !ansible ansible-playbook /path/of/file.yaml

 etc.

        !ansible ansible-playbook /home/ubuntu/test.yaml

### StackStorm Web UI

        https://your-public-dns


### Destroy

A good practice is to destroy the resources while they are not being used to avoid charges. 

        terraform destroy

### Issues
- t2.micro instances do not meet the minimal requirements. t2.medium instances are recommended for testing.
- StackStorm Web UI blocked, need to open ports for it.
- Invalid permissions (IAM, Roles, Policy, StackStorm)
