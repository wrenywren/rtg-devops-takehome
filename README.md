# Devops Take Home Test

Message for Joshua Starrett:
On my very first build if you take a look at my commit and GitAction history I got the website running in its most simple capacity.
I just used a simple public s3 bucket to get the site up :)
First Build Address:  http://rtg-takehome.com.s3-website-us-east-1.amazonaws.com


I wanted to accomplish getting the website an offical domain name starting with www.rtg-takehome.com. 
I did make the neccssarry cloudfront and route53 code to do that, but then I realized I would need to purchase a domain
to get the route53 addresses in aws to point there. So, thats where I stopped. In addition I would have added in a cert.tf file 
to account for the fact that using the cloudfront default cert would bring up an unsecured message for users that visisted the 
site. 

Route53 address: d2g4b3edhul9lc.cloudfront.net

Anyway I had a great deal of fun with the test and learned alot I hope it is up to par and I would enjoy discussing it with you further as well. Take a look at the link as well. They should work for you. Thanks Josh.

This project is setup to allow devops candidates so show their skills and ability to deploy a static site to the cloud

## Requirements
- Fork the repository into your own account
- Build and deploy the gatsby site to the cloud
- Use Terraform to standup your cloud infrastructure
- Use github actions to deploy infrastructure changes and publish the site

## Things to remember
- Make use of free tier services to deploy the site
- Make sure any api keys are stored in secrets. A bot will scrape it if its public

## Resources
- [Gatsby](https://www.gatsbyjs.com/docs/)
- [AWS Free Tier](https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Categories=categories%23storage)
- [Terraform](https://www.terraform.io/docs/index.html)
- [Github Actions](https://docs.github.com/en/free-pro-team@latest/actions
)
