-- Select data base
USE LAB_MYSQL_SELECT;

-- 1. join for authorid / last name / first name / title / publisher

select 
    authors.au_id as "author id", 
    authors.au_lname as "last name", 
    authors.au_fname as "first name", 
    titles.title as "title", 
    publishers.pub_name as "publisher"
from authors
join titleauthor
    on authors.au_id = titleauthor.au_id
join titles
    on titles.title_id = titleauthor.title_id
join publishers
    on publishers.pub_id = titles.pub_id;

-- 2. count of titles by author and publisher based on output 1
select 
    authors.au_id as "author id", 
    authors.au_lname as "last name", 
    authors.au_fname as "first name", 
    count(titles.title) as "title count", 
    publishers.pub_name as "publisher"
from authors
join titleauthor
    on authors.au_id = titleauthor.au_id
join titles
    on titles.title_id = titleauthor.title_id
join publishers
    on publishers.pub_id = titles.pub_id
group by authors.au_id, authors.au_lname, authors.au_fname, publishers.pub_name;

-- 3. top 3 authors by total number of sales
select 
    authors.au_id as "author id", 
    authors.au_lname as "last name", 
    authors.au_fname as "first name", 
    sum(sales.qty) as "total sales", 
from authors
join titleauthor
    on authors.au_id = titleauthor.au_id
join sales
    on sales.title_id = titleauthor.title_id
group by authors.au_id, authors.au_lname, authors.au_fname
order by sum(sales.qty) desc
limit 3;

-- 4. show the total sales for all the authors
select 
    authors.au_id as "author id", 
    authors.au_lname as "last name", 
    authors.au_fname as "first name", 
    sum(sales.qty) as "total sales", 
from authors
join titleauthor
    on authors.au_id = titleauthor.au_id
join sales
    on sales.title_id = titleauthor.title_id
group by authors.au_id, authors.au_lname, authors.au_fname
order by sum(sales.qty) desc;