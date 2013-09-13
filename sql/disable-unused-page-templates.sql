-- Use at your own risk, back up your database first.
-- This script does not delete templates. It simply disables them for a site (you can enable them again any time),
-- and only disables templates not currently used in the site. Templates in use are left untouched.

declare @siteid int = 1

Select * 
from CMS_PageTemplate
where 
-- not used
	(Select count(*) from View_CMS_Tree_Joined where View_CMS_Tree_Joined.DocumentPageTemplateID = CMS_PageTemplate.PageTemplateID) = 0
-- leave any adhoc templates, just in case (?)
	and PageTemplateIsReusable = 1
-- leave any dashboard templates, just in case
	and (not(PageTemplateType = 'dashboard') or PageTemplateType is null)


/*
delete
from CMS_PageTemplateSite
where 
SiteID = @siteid
and PageTemplateID in( 
		Select CMS_PageTemplate.PageTemplateID 
		from CMS_PageTemplate
		where 
		-- not used
			(Select count(*) from View_CMS_Tree_Joined where View_CMS_Tree_Joined.DocumentPageTemplateID = CMS_PageTemplate.PageTemplateID) = 0
		-- leave any adhoc templates, just in case (?)
			and PageTemplateIsReusable = 1
		-- leave any dashboard templates, just in case
			and (not(PageTemplateType = 'dashboard') or PageTemplateType is null)
	)
*/
