# git-changelog-maven-plugin
```
<plugin>
		        <groupId>se.bjurr.gitchangelog</groupId>
		        <artifactId>git-changelog-maven-plugin</artifactId>
		        <version>1.50</version>
		        <executions>
		          <execution>
		            <id>GenerateGitChangelog</id>
		            <phase>generate-sources</phase>
		            <goals>
		              <goal>git-changelog</goal>
		            </goals>
		            <configuration>
		              <!-- A file on filesystem //-->
		              <file>CHANGELOG.md</file>
		              <toRef>HEAD</toRef>
		
		              
		            </configuration>
		          </execution>
		        </executions>
		      </plugin>
```    

# get a copy of mustache template and save as changelog.mustache under the project home directory

```
https://github.com/tomasbjerre/git-changelog-lib/tree/master/src/test/resources/templates
```

# mvn compile to create the CHANGELOG.md
```
mvn compile
```

# upload the CHANGELOG.md to nginx as a release not

# config nginx support browser MD 
```
mime.types

text/markdown                         md;
```

# reload nginx and check the release note as text



# use template with StrapDown.js torender Markdown as html

``` 



<!DOCTYPE html>
<html>
<title>etender release</title>

<xmp theme="united" style="display:none;">

# Etender release note from Git Changelog 

[etender](http://etender.io)

Git Changelog.

{{#commits}}
## {{authorName}} - {{commitTime}}
[{{hashFull}}](https://etender.io/{{hash}})

{{{message}}}

{{/commits}}


</xmp>

<script src="http://strapdownjs.com/v/0.2/strapdown.js"></script>
</html>
```
