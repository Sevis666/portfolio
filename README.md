# Sevis's Portfolio

This website is meant to be completely independant from its content, but it was
designed to hold David ROBIN's portfolio. Its content should be located in
the /data directory, which must contain a structure.xml file.

Each post consists of a mardown file and an xml file containing the relevant
information about this post

## Structure file
This is how the structure file should look like :

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

## Post information file
The post info should have the same name as the post, with .xml extension instead
of .md, and this is how it should look like :

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
