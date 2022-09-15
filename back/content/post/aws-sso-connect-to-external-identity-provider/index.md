+++
title = "AWS SSO Connect to External SAML Identity Provider"
date = 2020-11-21T16:10:31+08:00
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["SSO", "IAM"]
categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++


# Create an external identity provider in AWS

IAM/Access management/identity_providers/

create a SAML type identity_providers

# Set up an external identity provider in AWS

AWS SSO/Settings

# Configure SAML SSO in your own identity provider

# Create AWS IAM role

Access Management/SAML 2.0 Federation

set the provider you created above as the SAML provider. Select Allow programmatic and AWS Management Console access. 

On the Attach Permission Policies page, select the appropriate policies to attach to the role. These define the permissions that users granted this role will have with AWS. For example, to grant your users read-only access to IAM, filter for and select the IAMReadOnlyAccess policy.

Review the Trusted entities and Policies information, then click Create Role


# Map AWS role to a user

```
context.samlConfiguration.mappings = {
    'https://aws.amazon.com/SAML/Attributes/Role': 'awsRole',
    'https://aws.amazon.com/SAML/Attributes/RoleSessionName': 'awsRoleSession'
};
```
