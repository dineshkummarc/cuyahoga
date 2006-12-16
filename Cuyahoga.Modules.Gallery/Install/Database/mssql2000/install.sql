CREATE TABLE cm_gal_description (
	descriptionid int IDENTITY (1, 1) NOT NULL ,
	culture nvarchar (8) NOT NULL ,
	class nvarchar (255)NOT NULL ,
	ouid int NOT NULL ,
	description nvarchar (2400)  NULL ,
	created datetime NOT NULL ,
	modified datetime NOT NULL 
)
GO

CREATE TABLE cm_gal_gallery (
	galleryid int IDENTITY (1, 1) NOT NULL ,
	galleryname nvarchar (50)  NOT NULL ,
	title nvarchar (50)  NOT NULL ,
	gallerythumb nvarchar (255)  NULL ,
	virtualpath nvarchar (255)  NULL ,
	artist nvarchar (255)  NULL ,
	created datetime NOT NULL ,
	modified datetime NOT NULL ,
	owner int NOT NULL ,
	include bit NOT NULL ,
	sequence int NOT NULL 
) 
GO

CREATE TABLE cm_gal_gallerycomment (
	commentid int IDENTITY (1, 1) NOT NULL ,
	galleryid int NOT NULL ,
	userid int NULL ,
	name nvarchar (100)  NULL ,
	culture nvarchar (8)  NULL ,
	website nvarchar (100)  NULL ,
	commenttext nvarchar (2000)  NOT NULL ,
	userip nvarchar (15)  NULL ,
	created datetime NOT NULL ,
	updated datetime NOT NULL 
) 
GO

CREATE TABLE cm_gal_gallerysection (
	gallerymoduleid int IDENTITY (1, 1) NOT NULL ,
	sectionid int NOT NULL ,
	galleryid int NOT NULL 
) 
GO

CREATE TABLE cm_gal_photo (
	photoid int IDENTITY (1, 1) NOT NULL ,
	galleryid int NOT NULL ,
	photoseq int NOT NULL ,
	views bigint NOT NULL ,
	photoname nvarchar (50)  NOT NULL ,
	thumbimage nvarchar (255)  NULL ,
	thumbover nvarchar (255)  NULL ,
	largeimage nvarchar (255)  NOT NULL ,
	created datetime NOT NULL ,
	modified datetime NOT NULL ,
	serie nvarchar (255)  NULL ,
	category nvarchar (255)  NULL ,
	originalsize nvarchar (255)  NULL ,
	downloadallowed bit NOT NULL ,
	rank1 bigint NOT NULL ,
	rank2 bigint NOT NULL ,
	rank3 bigint NOT NULL ,
	rank4 bigint NOT NULL ,
	rank5 bigint NOT NULL ,
	rank6 bigint NOT NULL ,
	rank7 bigint NOT NULL ,
	rank8 bigint NOT NULL ,
	rank9 bigint NOT NULL ,
	downloads bigint NOT NULL 
) 
GO

ALTER TABLE cm_gal_description WITH NOCHECK ADD 
	CONSTRAINT PK_cm_gal_description PRIMARY KEY  CLUSTERED 
	(
		descriptionid
	)  
GO

ALTER TABLE cm_gal_gallery WITH NOCHECK ADD 
	CONSTRAINT PK_cm_gal_gallery PRIMARY KEY  CLUSTERED 
	(
		galleryid
	)  
GO

ALTER TABLE cm_gal_gallerycomment WITH NOCHECK ADD 
	CONSTRAINT PK_cm_gal_gallerycomment PRIMARY KEY  CLUSTERED 
	(
		commentid
	)  
GO

ALTER TABLE cm_gal_gallerysection WITH NOCHECK ADD 
	CONSTRAINT PK_cm_gal_gallerysection PRIMARY KEY  CLUSTERED 
	(
		gallerymoduleid
	)  
GO

ALTER TABLE cm_gal_photo WITH NOCHECK ADD 
	CONSTRAINT PK_cm_gal_photo PRIMARY KEY  CLUSTERED 
	(
		photoid
	)  
GO

ALTER TABLE cm_gal_description ADD 
	CONSTRAINT DF_cm_gal_description_culture DEFAULT ('EN-US') FOR culture,
	CONSTRAINT DF_cm_gal_description_created DEFAULT (getdate()) FOR created,
	CONSTRAINT DF_cm_gal_description_updated DEFAULT (getdate()) FOR modified
GO

ALTER TABLE cm_gal_gallery ADD 
	CONSTRAINT DF_cm_gal_gallery_created DEFAULT (getdate()) FOR created,
	CONSTRAINT DF_cm_gal_gallery_modified DEFAULT (getdate()) FOR modified,
	CONSTRAINT DF_cm_gal_gallery_include DEFAULT (1) FOR include,
	CONSTRAINT DF_cm_gal_gallery_sequence DEFAULT (0) FOR sequence
GO

ALTER TABLE cm_gal_gallerycomment ADD 
	CONSTRAINT DF_cm_gal_gallerycomment_inserttimestamp DEFAULT (getdate()) FOR created,
	CONSTRAINT DF_cm_gal_gallerycomment_updatetimestamp DEFAULT (getdate()) FOR updated
GO

ALTER TABLE cm_gal_photo ADD 
	CONSTRAINT DF_cm_gal_photo_views DEFAULT (0) FOR views,
	CONSTRAINT DF_cm_gal_photo_created DEFAULT (getdate()) FOR created,
	CONSTRAINT DF_cm_gal_photo_modified DEFAULT (getdate()) FOR modified,
	CONSTRAINT DF_cm_gal_photo_downloadallowed DEFAULT (0) FOR downloadallowed,
	CONSTRAINT DF_cm_gal_photo_rank1 DEFAULT (0) FOR rank1,
	CONSTRAINT DF_cm_gal_photo_rank11 DEFAULT (0) FOR rank2,
	CONSTRAINT DF_cm_gal_photo_rank12 DEFAULT (0) FOR rank3,
	CONSTRAINT DF_cm_gal_photo_rank13 DEFAULT (0) FOR rank4,
	CONSTRAINT DF_cm_gal_photo_rank14 DEFAULT (0) FOR rank5,
	CONSTRAINT DF_cm_gal_photo_rank51 DEFAULT (0) FOR rank6,
	CONSTRAINT DF_cm_gal_photo_rank52 DEFAULT (0) FOR rank7,
	CONSTRAINT DF_cm_gal_photo_rank53 DEFAULT (0) FOR rank8,
	CONSTRAINT DF_cm_gal_photo_rank54 DEFAULT (0) FOR rank9,
	CONSTRAINT DF_cm_gal_photo_downloads DEFAULT (0) FOR downloads
GO

ALTER TABLE cm_gal_gallery ADD 
	CONSTRAINT FK_gallery_user_owner FOREIGN KEY 
	(
		owner
	) REFERENCES cuyahoga_user (
		userid
	)
GO

ALTER TABLE cm_gal_gallerycomment ADD 
	CONSTRAINT FK_gallerycomment_user_userid FOREIGN KEY 
	(
		userid
	) REFERENCES cuyahoga_user (
		userid
	),
	CONSTRAINT FK_gallerycomment_gallery_galleryid FOREIGN KEY 
	(
		galleryid
	) REFERENCES cm_gal_gallery (
		galleryid
	)
GO

ALTER TABLE cm_gal_gallerysection ADD 
	CONSTRAINT FK_gallerysection_section_sectionid FOREIGN KEY 
	(
		sectionid
	) REFERENCES cuyahoga_section (
		sectionid
	),
	CONSTRAINT FK_gallerysection_gallery_galleryid FOREIGN KEY 
	(
		galleryid
	) REFERENCES cm_gal_gallery (
		galleryid
	)
GO

ALTER TABLE cm_gal_photo ADD 
	CONSTRAINT FK_photo_gallery_galleryid FOREIGN KEY 
	(
		galleryid
	) REFERENCES cm_gal_gallery (
		galleryid
	)
GO

/*
*  Insert data
*/

DECLARE @moduletypeid int

INSERT INTO cuyahoga_moduletype (name, assemblyname, classname, path, editpath, inserttimestamp, updatetimestamp) 
VALUES ('Gallery', 'Cuyahoga.Modules.Gallery', 'Cuyahoga.Modules.Gallery.GalleryModule', 'Modules/Gallery/Gallery.ascx', 'Modules/Gallery/AdminGalleries.aspx', '2006-05-15 14:36:28.324', '2006-05-15 14:36:28.324')

SELECT @moduletypeid = Scope_Identity()

INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'ALLOW_COMMENTS','Allow comments','System.Boolean',0,1)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'ALLOW_ANONYMOUS_COMMENTS', 'Allow anonymous comments', 'System.Boolean', 0, 1)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'TARGET_PAGE', 'User Friendly name of the target photo list', 'System.String', 0, 0)
GO

INSERT INTO cuyahoga_version (assembly, major, minor, patch) VALUES ('Cuyahoga.Modules.Gallery', 1, 0, 0)
GO

DECLARE @moduletypeid int

INSERT INTO cuyahoga_moduletype (name, assemblyname, classname, path, editpath, inserttimestamp, updatetimestamp) VALUES ('PhotoList', 'Cuyahoga.Modules.Gallery', 'Cuyahoga.Modules.Gallery.PhotoListModule', 'Modules/Gallery/PhotoList.ascx', 'Modules/Gallery/AdminGallerySection.aspx', '2006-05-15 14:36:28.324', '2006-05-15 14:36:28.324')

SELECT @moduletypeid = Scope_Identity()

INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'LIST_COLUMN_COUNT','Number of thumbnails per row','System.Int32',0,1)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'DISPLAY_TYPE', 'Show information', 'Cuyahoga.Modules.Gallery.PhotoListDisplay', 1, 1)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'ALLOW_DOWNLOAD', 'Allow Image download', 'System.Boolean', 0, 1)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'LIST_ACTION', 'On click action', 'Cuyahoga.Modules.Gallery.PhotoShowAction', 1, 1)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'POPUP_WIDTH', 'Popup window width', 'System.Int32', 0, 0)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'POPUP_HEIGHT', 'Popup window height', 'System.Int32', 0, 0)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'POPUP_TOP', 'Popup window top', 'System.Int32', 0, 0)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'POPUP_LEFT', 'Popup window left', 'System.Int32', 0, 0)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'SHOW_GALLERY_DESCRIPTION', 'Show the gallery description', 'System.Boolean', 0, 1)
GO

INSERT INTO cuyahoga_moduletype (name, assemblyname, classname, path, editpath, inserttimestamp, updatetimestamp) VALUES ('PhotoShow', 'Cuyahoga.Modules.Gallery', 'Cuyahoga.Modules.Gallery.PhotoShowModule', 'Modules/Gallery/PhotoShow.ascx', 'Modules/Gallery/AdminGallerySection.aspx', '2006-05-15 14:36:28.324', '2006-05-15 14:36:28.324')

DECLARE @moduletypeid int

SELECT @moduletypeid = Scope_Identity()

INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'FADEIN_TIME','(For Fade In show only) Time in seconds','System.Int32',0,0)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'PHOTOSHOW_ACTION', 'On click Action (for random only)', 'Cuyahoga.Modules.Gallery.PhotoShowAction', 1, 0)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'PHOTOSHOW_AREASIZE', 'Show area size (in pixels)', 'System.Int32', 0, 1)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'PHOTOSHOW_TYPE', 'Type of Photo Show', 'Cuyahoga.Modules.Gallery.PhotoShowType', 1, 1)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'POPUP_WIDTH', 'Popup window width', 'System.Int32', 0, 0)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'POPUP_HEIGHT', 'Popup window height', 'System.Int32', 0, 0)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'POPUP_TOP', 'Popup window top', 'System.Int32', 0, 0)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'POPUP_LEFT', 'Popup window left', 'System.Int32', 0, 0)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'USE_THUMBNAILS', 'Use thumbnails instead of large image', 'System.Boolean', 0, 1)

GO

INSERT INTO cuyahoga_moduletype (name, assemblyname, classname, path, editpath, inserttimestamp, updatetimestamp) VALUES ('GalleryComments', 'Cuyahoga.Modules.Gallery', 'Cuyahoga.Modules.Gallery.GalleryCommentsModule', 'Modules/Gallery/GalleryComments.ascx', 'Modules/Gallery/AdminGalleries.aspx', '2006-05-15 14:36:28.324', '2006-05-15 14:36:28.324')

DECLARE @moduletypeid int

SELECT @moduletypeid = Scope_Identity()

INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'ALLOW_COMMENTS','Allow comments','System.Boolean',0,1)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'ALLOW_ANONYMOUS_COMMENTS', 'Allow anonymous comments', 'System.Boolean', 0, 1)
INSERT INTO cuyahoga_modulesetting (moduletypeid, name, friendlyname, settingdatatype, iscustomtype, isrequired) VALUES (@moduletypeid, 'COMMENTS_ROW_COUNT', 'Number of comments to display (default 10)', 'System.Int32', 0, 0)

GO
