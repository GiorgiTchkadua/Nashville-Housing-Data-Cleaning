select *
from nashville;

-- date change
select saledate, STR_TO_DATE(saledate, '%M %d, %Y')
from nashville;

update nashville
set saledate = STR_TO_DATE(saledate, '%M %d, %Y');
-- something
select propertyaddress
from nashville
where propertyaddress is null;


select nm.parcelid, nm.propertyaddress, nk.parcelid, nk.propertyaddress
from nashville as nm
join nashville as nk
	on nm.parcelid=nk.parcelid 
    and nm.uniqueid <> nk.uniqueid;
    
-- substring gancalkeveba erti columnis ramdenimed

select propertyaddress,
 substring(propertyaddress, 1, locate(',', '1808  FOX CHASE DR, GOODLETTSVILLE') -1 ) as address, 
 trim(substring(propertyaddress, locate(',', '1808  FOX CHASE DR, GOODLETTSVILLE') +1 )) as location
from nashville;

alter table nashville
add propertysplitaddress  nvarchar(255);

update nashville
set propertysplitaddress= substring(propertyaddress, 1, locate(',', '1808  FOX CHASE DR, GOODLETTSVILLE') -1 );

alter table nashville
add propertysplitcity nvarchar(255);

update nashville
set propertysplitcity =trim(substring(propertyaddress, locate(',', '1808  FOX CHASE DR, GOODLETTSVILLE') +1 ));

-- es igive zevita ufro mosaxerxebeli da martivi

select owneraddress, substring(owneraddress,1, locate(',','1808  FOX CHASE DR, GOODLETTSVILLE, TN') - 1)
from nashville;

select
substring_index('1808  FOX CHASE DR, GOODLETTSVILLE, TN', ',', -1),
substring_index('1808  FOX CHASE DR, GOODLETTSVILLE, TN', ',', -2),
substring_index('1808  FOX CHASE DR, GOODLETTSVILLE, TN', ',', -3)
from nashville;

-- updatebs gavuketeb jer table sheiqmneba da mere update

select *
from nashville;

select distinct soldasvacant, count(soldasvacant)
from nashville
group by 1
order by 2;

select soldasvacant,
	case when soldasvacant = 'y' then 'yes'
		when soldasvacant = 'n' then 'no'
        else soldasvacant
        end
from nashville;

update nashville
set soldasvacant = case when soldasvacant = 'y' then 'yes'
		when soldasvacant = 'n' then 'no'
        else soldasvacant
        end;

-- remove dublicates

with rownum as
(select *,
row_number() over (partition by parcelid, propertyaddress, saleprice, saledate, legalreference
	order by uniqueid) row_num
from nashville
order by parcelid)
select * -- aq tu chavwer delete* washlis ubralod ar minda rom waishalos radgan nagida ubralod delete chavwerot select-is nacvlad da egaa amoishleba dublikatebi
from rownum
where row_num > 1;


-- delete unused columns
-- aq vshli imas rom propertyaddress i xo ukve davanawile 2 nawilad romelic uketesia egre gvqondes da es property addres ukve agar gvchirdeba
-- aseve wavllit taxdistricts radgan esec ar gvchirdeba

alter table nashville
drop column propertyaddress,-- arr daachiro tore waishleba
drop column taxdistrict; -- ar vacher radgan ar minda waishalos. 


WITH rownum AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY parcelid, propertyaddress, saleprice, saledate, legalreference
                              ORDER BY uniqueid) AS row_num
    FROM nashville
)
DELETE FROM nashville
WHERE uniqueid IN (
    SELECT uniqueid
    FROM rownum
    WHERE row_num > 1
);


