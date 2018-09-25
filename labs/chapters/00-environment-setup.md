# Environement Setup


## AWS Account Setup


## Terraform Installation

### Ubuntu
Follow the following steps to install Terraform on ubuntu.

```
wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
unzip terraform_0.11.8_linux_amd64.zip
sudo mv terraform /usr/bin/local
sudo chmod +x /usr/bin/local/terraform
```

### Windows

Visit the following link to download the Terraform executable.

[Terraform for Windows](https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_windows_amd64.zip).

Extract the file.

![zip](./images/00-windows-zip.png)

Copy the extracted file.

![copy](./images/00-windows-copy.png)

Create a new directory called `Terrafrom` insice `C:\Program Files\`

![dir](./images/00-windoes-dir.png)

Paste the file we have copied in the previous step.

![paste](./images/00-windows-paste.png)

Copy the file path for the executable.
![file-path](./images/00-windows-file-path.png)

Search for `environment` from your start menu.
![env](./images/00-windows-env-search.png)

Then select environment variables form the window.
![env-select](./images/00-windows-env-select.png)

Select Path variable and edit it.
![env-path-edit](./images/00-windows-env-path-edit.png)

Add the path that we have copied earlier.
![windows-path-env-paste](./images/00-windows-path-env-paste.png)

### MacOS

```
wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_darwin_amd64.zip
unzip terraform_0.11.8_darwin_amd64.zip
sudo mv terraform /usr/bin/local
sudo chmod +x /usr/bin/local/terraform
```

## Validate the Installation

Open a Shell session and run `terraform -v`. This should produce the following output.

```
terraform -v

[output]
Terraform v0.11.7
```