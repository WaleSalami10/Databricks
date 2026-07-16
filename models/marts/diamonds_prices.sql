select color, avg(price) as price
from workspace.default.diamonds
group by color
order by price desc