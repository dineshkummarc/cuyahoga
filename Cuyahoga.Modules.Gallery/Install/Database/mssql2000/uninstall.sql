/*
 *  Remove module definitions
 */
 
DELETE FROM cuyahoga_version WHERE assembly = 'Cuyahoga.Modules.Gallery'
go
 
DELETE cuyahoga_modulesetting 
FROM cuyahoga_modulesetting ms
	INNER JOIN cuyahoga_moduletype mt ON mt.moduletypeid = ms.moduletypeid AND mt.classname = 'Cuyahoga.Modules.Gallery.GalleryModule'
go

DELETE FROM cuyahoga_moduletype
WHERE classname = 'Cuyahoga.Modules.Gallery.GalleryModule'
go

DELETE cuyahoga_modulesetting 
FROM cuyahoga_modulesetting ms
	INNER JOIN cuyahoga_moduletype mt ON mt.moduletypeid = ms.moduletypeid AND mt.classname = 'Cuyahoga.Modules.Gallery.PhotoListModule'
go

DELETE FROM cuyahoga_moduletype
WHERE classname = 'Cuyahoga.Modules.Gallery.PhotoListModule'
go

DELETE cuyahoga_modulesetting 
FROM cuyahoga_modulesetting ms
	INNER JOIN cuyahoga_moduletype mt ON mt.moduletypeid = ms.moduletypeid AND mt.classname = 'Cuyahoga.Modules.Gallery.PhotoShowModule'
go

DELETE FROM cuyahoga_moduletype
WHERE classname = 'Cuyahoga.Modules.Gallery.PhotoShowModule'
go

DELETE cuyahoga_modulesetting 
FROM cuyahoga_modulesetting ms
	INNER JOIN cuyahoga_moduletype mt ON mt.moduletypeid = ms.moduletypeid AND mt.classname = 'Cuyahoga.Modules.Gallery.GalleryCommentsModule'
go

DELETE FROM cuyahoga_moduletype
WHERE classname = 'Cuyahoga.Modules.Gallery.GalleryCommentsModule'
go

/*
 *  Remove module specific tables
 */

DELETE FROM cm_gal_description
go

DELETE FROM cm_gal_gallerycomment
go

DELETE FROM cm_gal_gallerysection
go

DELETE FROM cm_gal_photo
go

DELETE FROM cm_gal_gallery
go


DROP TABLE cm_gal_description
go

DROP TABLE cm_gal_gallerycomment
go

DROP TABLE cm_gal_gallerysection
go

DROP TABLE cm_gal_photo
go

DROP TABLE cm_gal_gallery

