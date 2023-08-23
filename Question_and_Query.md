question link: https://leetcode.com/problems/invalid-tweets/submissions/
```sql
SELECT tweet_id 
FROM tweets
WHERE LENGTH(content) > 15;
```
question link: https://leetcode.com/problems/the-number-of-rich-customers/description/
```sql:
select Count(count(*)) as rich_count 
from store 
where amount > 500
group by customer_id;
```
