select * from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01];

select SaleDate from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01];
--populate property address column removing null values
select *
from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01];
where PropertyAddress is null;

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01] a
join Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01] b
	on a.ParcelID = b.ParcelID
	and a.UniqueID <> b.UniqueID
where a.propertyAddress is null;

update a
set PropertyAddress =isnull(a.PropertyAddress,b.PropertyAddress)
from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]; a
join Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01] b
	on a.ParcelID = b.ParcelID
	and a.UniqueID <> b.UniqueID
where a.propertyAddress is null;


--Breaking out propertyaddress into ( Address, city , State)

select PropertyAddress
from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]
 PropertyAddress 


 select 
 SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1) as PropertyAdress,
 SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress)) as PropertyAdress
from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]

alter table dbo.[Nashville Housing Data for Data Cleaning-01]
add PropertySplitAddress nvarchar(255);


update Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]
set PropertySplitAddress =SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1);


alter table dbo.[Nashville Housing Data for Data Cleaning-01]
add PropertySplitCity nvarchar(255);

update Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]
set PropertySplitCity =SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress));

select *
from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]
 
 --- Split OwneAddress table
select OwnerAddress 
fromPortfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01];

select 
PARSENAME(replace(OwnerAddress,',','.'), 3),
PARSENAME(replace(OwnerAddress,',','.'), 2),
PARSENAME(replace(OwnerAddress,',','.'), 1)
from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]

alter table dbo.[Nashville Housing Data for Data Cleaning-01]
add OwnerSplitAddress nvarchar(255);


update Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]
set OwnerSplitAddress =PARSENAME(replace(OwnerAddress,',','.'), 3);


alter table dbo.[Nashville Housing Data for Data Cleaning-01]
add OwnerSplitCity nvarchar(255);

update Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]
set OwnerSplitCity =PARSENAME(replace(OwnerAddress,',','.'), 2);

alter table dbo.[Nashville Housing Data for Data Cleaning-01]
add OwnerSplitState nvarchar(255);


update Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]
set OwnerSplitState =PARSENAME(replace(OwnerAddress,',','.'), 1);


select *
from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]


--chnage "y" adn "N" to yes and No in 

select *
from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]
 
 -- Change "y" and "N" into Yes And No

 select distinct(SoldAsVacant),COUNT(SoldAsVacant)
 from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]
 Group by SoldAsVacant;

 select SoldAsVacant, 
	case when SoldAsVacant = 0 then REPLACE(SoldAsVacant,0,"YES"
	when SoldAsVacant = 1 then "N"
	else SoldAsVacant 
	end
from Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01];


--- Remove Duplicate

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress;

---Remove dulicate Column

Select *
From Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]


ALTER TABLE Portfolio_Projects.dbo.[Nashville Housing Data for Data Cleaning-01]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
