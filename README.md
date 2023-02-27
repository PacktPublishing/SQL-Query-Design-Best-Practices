# SQL Query Design Patterns and Best Practices	

<a href=""> <img src="https://m.media-amazon.com/images/I/413ivVqCWFL.jpg" alt="SQL Query Design Patterns and Best Practices" height="256px" align="right"></a>

This is the code repository for [SQL Query Design Patterns and Best Practices] (https://www.amazon.in/Query-Design-Patterns-Best-Practices-ebook/dp/B0BWRD7HQ7/ref=sr_1_3?crid=721FT536W1GL&keywords=SQL+Query+Design+Patterns+and+Best+Practices&qid=1677486001&sprefix=sql+query+design+patterns+and+best+practices+%2Caps%2C494&sr=8-3), published by Packt.

**A practical guide to writing readable and maintainable SQL queries using its design patterns**

## What is this book about?
SQL has been the de facto standard when interacting with databases for decades and shows no signs of going away. Through the years, report developers or data wranglers have had to learn SQL on the fly to meet the business needs, so if you are someone who needs to write queries, SQL Query Design and Pattern Best Practices is for you.
This book will guide you through making efficient SQL queries by reducing set sizes for effective results. You’ll learn how to format your results to make them easier to consume at their destination. From there, the book will take you through solving complex business problems using more advanced techniques, such as common table expressions and window functions, and advance to uncovering issues resulting from security in the underlying dataset. Armed with this knowledge, you’ll have a foundation for building queries and be ready to shift focus to using tools, such as query plans and indexes, to optimize those queries. The book will go over the modern data estate, which includes data lakes and JSON data, and wrap up with a brief on how to use Jupyter notebooks in your SQL journey.
By the end of this SQL book, you’ll be able to make efficient SQL queries that will improve your report writing and the overall SQL experience.

This book covers the following exciting features: 
* Build efficient queries by reducing the data being returned
* Manipulate your data and format it for easier consumption
* Form common table expressions and window functions to solve complex business issues
* Understand the impact of SQL security on your results
* Understand and use query plans to optimize your queries
* Understand the impact of indexes on your query performance and design
* Work with data lake data and JSON in SQL queries
* Organize your queries using Jupyter notebooks

If you feel this book is for you, get your [copy](https://www.amazon.com/dp/1837633282) today!

<a href="https://www.packtpub.com/?utm_source=github&utm_medium=banner&utm_campaign=GitHubBanner"><img src="https://raw.githubusercontent.com/PacktPublishing/GitHub/master/GitHub.png" alt="https://www.packtpub.com/" border="5" /></a>

## Instructions and Navigations
All of the code is organized into folders.

The code will look like the following:
```
SELECT TOP (3) [Order Key]
,[Description]
FROM [Fact].[Order]
```

**Following is what you need for this book:**
This book is for SQL developers, data analysts, report writers, data scientists, and other data gatherers looking to expand their skills for complex querying as well as for building more efficient and performant queries.
For those new to SQL, this book can help you accelerate your learning and keep you from making common mistakes.

With the following software and hardware list you can run all code files present in the book (Chapter 1-14).

### Software and Hardware List

| Chapter  | Software required                                                                    | OS required                        |
| -------- | -------------------------------------------------------------------------------------| -----------------------------------|
|  1-14	   |   		Microsoft Azure Storage Explorer                                                | Windows, macOS, or Linux (Any)|
|1-14      |      SQL Server 2022 or Azure SQL Database                                           | Windows, macOS, or Linux (Any)|
|1-14      |      Azure Data Studio              			                                            | Windows, Mac OS X, and Linux (Any) |


We also provide a PDF file that has color images of the screenshots/diagrams used in this book. [Click here to download it](https://packt.link/Xxotr).


### Related products <Other books you may enjoy>
* SQL Server Query Tuning and Optimization [[Packt]](<Book link on Packtpub>) [[Amazon]](https://www.amazon.com/dp/1803242620)

* Business Intelligence with Databricks SQL [[Packt]](<Book link on Packtpub>) [[Amazon]](https://www.amazon.com/dp/1803235330)

## Get to Know the Author(s)
**Steve Hughes* is a Senior Director, Data & Analytics, at 3Cloud. In this role, he focuses on growing the teams' skills and capabilities to deliver data projects on Azure. He has been working with technology for over 20 years with much of that time spent on creating business intelligence solutions and helping customers implement leading BI and cloud solutions. He is passionate about using data effectively and helping customers understand that data is valuable and profitable. Steve has recently been diagnosed with ALS but continues to work and share with others what he has learned. Steve is also the founder of Data on Wheels where he blogs with one of his daughters on topics around data, analytics, and work enablement.

**Dennis Neer* is a Senior Architect, Data & Analytics, at 3Cloud. In this role, he focuses on working with clients to design Azure solutions for their data and analytic needs so that they may use that data to make business decisions based on that data. This includes using tools such as SQL Server databases, Synapse, data lakes and Power BI. He has been working with technology for over 30 years with 25 of the years in designing and building database and visualization solutions. He is passionate about data and helping businesses to understand the information contained in their data and how it can be used to make important decisions regarding their business to improve the strength of their business.

**Chi Zhang* is a Lead Data Architect at 3Cloud. Working for the past 5 years in consulting, she has helped clients from various industries to deliver customized data solutions within Azure. Chi’s areas of expertise include ETL, data warehousing, data modelling and business intelligence reporting. Chi currently holds several Microsoft certifications related to Azure technologies for data engineering and data science. She is passionate about solving data problems for clients and building data solutions that provide business users better operational insights and a smoother experience. Chi gave her first public tech talk recently and is thrilled about her first go at co-authoring a technical book with her very experienced colleagues.

**Leslie Andrews* is a Data Architect, Data & Analytics, at 3Cloud. Working in the IT sector for 20+ years in local government, electrical supply, law enforcement, and health care, she has broad experience to draw from to assist clients in making data more accessible for end users. Leslie's expertise includes SQL development, ETL, data warehousing, data modelling and analytics. Leslie currently holds several Microsoft certifications related to Azure technologies for data engineering. She approaches each day as an opportunity to use data and technology to make it easier for others to do their daily work. Leslie has been speaking since 2015, was an Idera ACE in 2019, and is a supporter of and contributor to the SQL community.

**Dr. Ram Babu Singh* has a Doctorate (PhD) in Computer Science and is a Microsoft Certified Professional. He is a Lead Architect, Data & Analytics, at 3Cloud. In this role, he focuses on designing and developing data analytics and data science solutions. He has been working on the Microsoft data platform since March 2002. He exemplifies a recognized level of expertise in the core competencies of Azure Databricks, Data Factory, Synapse Analytics, AI/ML – architecting, designing, and developing lakehouse, data warehouse, data analytics and data science solutions, SQL database administration, configuration and management. He has 6 publications published in international journals and has a patent on ISP – crime site analysis.

**Shabbir H. Mala* is a Director, Data & Analytics at 3Cloud. He has over 22 years of experience in thought leadership and consulting, developing complex data solutions, business systems, and processes using Microsoft BI tools. He currently manages a Data Architecture team with around 40 Principals and Senior Architects with focus on business growth, successful project delivery, and client experience. He has done a few talks at Power BI conferences and local Power BI user groups. He has been awarded the Microsoft Fast Track Solution Architect twice. He was born & raised in Mumbai (India) and came to the United States in 2006, currently living in the Chicago suburbs. He is married and has 3 kids – twin daughters (12 years) and a boy (7 years).	
