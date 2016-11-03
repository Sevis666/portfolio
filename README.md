# Sevis's Portfolio

This is a framework that serves a tree of markdown and xml files, with some nice styles. It includes SMACSS-compliant mobile-oriented stylesheets, Mathjax, asynchronous loading and offline caching of scripts and stylesheets, and supports markdown (see [redcarpet](https://github.com/vmg/redcarpet)'s page for more details).

This website is meant to be completely independant from its content, and you are free to reuse it, but it was designed to hold [David ROBIN](http://www.sevis.pro)'s portfolio. If you have any proposal to improve this framework, or want to contribute to this project, feel free to send me an email or create a pull request.

You can have a look at the resulting website at [sevis.pro](http://www.sevis.pro).

## Setup

The content should be located in the /data directory, which must contain a structure.xml file.

Each post consists of a mardown file and an xml file containing the relevant information about this post

### data/structure.xml

This is how the content of the structure file should be organised :

<pre>
structure :
|- section :
|   |- order : integer
|   |- slug  : spaceless lowercase string
|   |- name  : string
|   |- display: string in ["folders", "all_posts", "latest_posts"]
|   `- subsections :
|      |- subsection :
|      |  |- slug : spaceless lowercase string
|      |  |- name : string
|      |  |- image-name: path or url for the cover image
|      |  `- display : string like previously
|      |- subsection
|      `- subsection
|- section
`- section
</pre>

### data/section/subsection/postname.xml

The post info should have the same name as the post, with .xml extension instead
of .md, and have the following organisation :

<pre>
post :
|- title : string
|- creation-date | cd : date in YYYY-MM-DD format
|- last-modification-date | lmd : date in YYYY-MM-DD format
|- image-name: path or url for the cover image
|- related-posts :
|  |- post : spaceless lowercase string
|  `- post
`- tags :
   |- tag : string
   `- tag
</pre>

The slug of the post, used for the url, is the name of the post file, and both the .xml and .md file *must* have the same name
