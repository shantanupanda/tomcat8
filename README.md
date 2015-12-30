tomcat8 Cookbook
================
Installs base Tomcat 8 and Java 8 to have a tomcat server to deploy 


Requirements
------------

Platforms:

    Debian / Ubuntu derivatives
    RHEL derivatives
    Fedora

Chef

    Chef 12.1+

Cookbooks

    java
    tomcat

Attributes
---------- 
#### tomcat8::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['tomcat']['base_version']</tt></td>
    <td>String</td>
    <td>Yes</td>
    <td><tt>8.0.30</tt></td>
  </tr>
</table>


Usage
-----
#### tomcat8::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `tomcat8` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[tomcat8]"
  ]
}
```

Contributing
------------
If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Shantanu Panda
# tomcat8
