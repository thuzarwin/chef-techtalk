Learning Chef
=============

 - Presentation - Intro to the problem # 5 - 10 Minutes
   - What is a configuration management tool?
   - Why should I use one?
   - What makes Chef different from other configuration managers?

 - Presentation - Intro to Chef # 10 - 20 Minutes
   - What is ChefDK?
   - Chef server, Workstations, clients/nodes
     - https://docs.chef.io/chef_overview.html
     - Chart?
   - Cookbooks, recipes (recipes DSL), attributes
     - What are cookbooks?
       - The fundamental unit of configuration and policy distribution.
       - Contents include recipes, attributes, static files, templates, and extensions to Chef (Resources/Providers).
     - What are recipes?
       - Are authored using Ruby, a programming language designed to be easily readible and behave in a predictable manner.
       - Mostly a collection of resources, resource is a block of ruby with an action, name, and a number of attribute-value pairs.
       - Also may have helper Ruby code, when necessary.
       - Must be stored in a cookbook.
       - May be included in other recipes (or include other recipes).
       - May query Chef server for information.
     - How do I write a recipe?
       - Recipes are just Ruby code!
       - Example of a resource.
       - What are resources?
       - Common/Useful resources.
         - directory, user, template, package, execute
     - What are attributes?  How do I use them?
       - The `node` keyword in recipes
       - Attribute Precedence - Picture
       - Attribute Persistence 
         - node.save
       - Touch on Ohai?
   - The run-list
     - Each node has a runlist
     - Details which recipes should be run, and in what order
   - Chef Supermarket
     - Where to find Chef Community Cookbooks
     - Great to base your Cookbooks on ones already available.
     - Each cookbook has its own set of recipes, attributes, etc.  The Supermarket contains this information.

 - Lab 0 - Install ChefDK # 10 - 30 Minutes

 - Lab 1 - Getting your feet wet with Chef Solo & Vagrant # 2.5 Hours
   - Use Chef to configure a Vagrant machine to install Postgres
   - First challenge - Move configurable options to attributes
   - Second challenge - Use the already existing Postgresql cookbook in yours to install Postgres
     - https://supermarket.chef.io
   - Third challenge - Use Berkshelf with Vagrant to manage the Postgresql cookbook dependency.
     - http://berkshelf.com

 - Presentation - Wrapping up # 10 Minutes
   - Where to find help
   - A lot of added complexity, what does it get us?
   - Where Chef isn't a good option
