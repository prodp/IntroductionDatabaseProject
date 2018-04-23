/*
 * if no ON DELETE action is specified, then by default it will be
 * ON DELETE RESTRICT (do not allow deletion)
 * so, if an entry from a table has to be deleted, we have to delete
 * the according entries in the referenced tables first
 */

CREATE TABLE Story
  (
    id INTEGER,
    title VARCHAR(128),
    feature VARCHAR(64),
    issue_id INTEGER,
    letters VARCHAR(64),
    editing CHAR(16),
    genre CHAR(64),
    characters VARCHAR(256),
    synopsis VARCHAR(256),
    reprint_notes VARCHAR(64),
    notes VARCHAR(256),
    type_id INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(issue_id) REFERENCES Issue(id)
      ON UPDATE CASCADE,
    FOREIGN KEY(type_id) REFERENCES Story_Type(id)
      ON UPDATE CASCADE
  )


CREATE TABLE Story_Script
  (
    story_id INTEGER,
    script_id INTEGER,
    PRIMARY KEY(story_id, script_id),
    FOREIGN KEY(story_id) REFERENCES Story(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY(script_id) REFERENCES Contributor(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
  )


CREATE TABLE Story_Pencils
  (
    story_id INTEGER,
    pencil_id INTEGER,
    PRIMARY KEY(story_id, pencil_id),
    FOREIGN KEY(story_id) REFERENCES Story(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY(pencil_id) REFERENCES Contributor(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
  )


CREATE TABLE Story_Inks
  (
    story_id INTEGER,
    ink_id INTEGER,
    PRIMARY KEY(story_id, ink_id),
    FOREIGN KEY(story_id) REFERENCES Story(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY(ink_id) REFERENCES Contributor(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
  )


CREATE TABLE Story_Colors
  (
    story_id INTEGER,
    color_id INTEGER,
    PRIMARY KEY(story_id, color_id),
    FOREIGN KEY(story_id) REFERENCES Story(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY(color_id) REFERENCES Contributor(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
  )


CREATE TABLE Issue
  (
    id INTEGER,
    number CHAR(16),
    series_id INTEGER,
    indicia_publisher_id INTEGER,
    publication_date CHAR(32),
    price CHAR(32),
    page_count INTEGER,
    indicia_frequency CHAR(32),
    notes VARCHAR(256),
    isbn CHAR(16),
    valid_isbn INTEGER,
    barcode INTEGER,
    title CHAR(32),
    on_sale_date CHAR(32),
    rating CHAR(32),
    PRIMARY KEY(id),
    FOREIGN KEY(series_id) REFERENCES Series(id)
      ON UPDATE CASCADE,
    FOREIGN KEY(indicia_publisher_id) REFERENCES Indicia_Publisher(id)
      ON UPDATE CASCADE
  )


CREATE TABLE Issue_Editing
  (
    story_id INTEGER,
    editor_id INTEGER,
    PRIMARY KEY(story_id, editor_id),
    FOREIGN KEY(story_id) REFERENCES Story(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY(editor_id) REFERENCES Contributor(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
  )


CREATE TABLE Series
  (
    id INTEGER,
    name VARCHAR(256),
    format CHAR(64),
    year_began INTEGER,
    year_ended INTEGER,
    publication_dates CHAR(64),
    first_issue_id INTEGER,
    last_issue_id INTEGER,
    publisher_id INTEGER,
    country_id INTEGER,
    language_id INTEGER,
    notes VARCHAR(256),
    color VARCHAR(256),
    dimensions CHAR(64),
    paper_stock VARCHAR(256),
    binding VARCHAR(256),
    publishing_format CHAR(64),
    publication_type_id INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(first_issue_id) REFERENCES Issue(id)
      ON UPDATE CASCADE,
    FOREIGN KEY(last_issue_id) REFERENCES Issue(id)
      ON UPDATE CASCADE,
    FOREIGN KEY(publisher_id) REFERENCES Publisher(id)
      ON UPDATE CASCADE,
    FOREIGN KEY(country_id) REFERENCES Country(id)
      ON UPDATE CASCADE,
    FOREIGN KEY(language_id) REFERENCES Language(id)
      ON UPDATE CASCADE,
    FOREIGN KEY(publication_type_id) REFERENCES Publication_Type(id)
      ON UPDATE CASCADE
  )


CREATE TABLE Indicia_Publisher
  (
    id INTEGER,
    name CHAR(64),
    publisher_id INTEGER,
    country_id INTEGER,
    year_began INTEGER,
    year_ended INTEGER,
    is_surrogate BOOLEAN,
    notes VARCHAR(256),
    url CHAR(64),
    PRIMARY KEY(id),
    FOREIGN KEY(publisher_id) REFERENCES Publisher(id)
      ON UPDATE CASCADE,
    FOREIGN KEY(country_id) REFERENCES Country(id)
      ON UPDATE CASCADE
  )


CREATE TABLE Publisher
  (
    id INTEGER,
    name CHAR(64),
    country_id INTEGER,
    year_began INTEGER,
    year_ended INTEGER,
    notes VARCHAR(256),
    url CHAR(64),
    PRIMARY KEY(id)
      ON UPDATE CASCADE,
    FOREIGN KEY(country_id) REFERENCES Country(id)
      ON UPDATE CASCADE
  )


CREATE TABLE Brand_Group
  (
    id INTEGER,
    name char(64),
    year_began INTEGER,
    year_ended INTEGER,
    notes VARCHAR(256),
    url CHAR(64),
    publisher_id INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(publisher_id) REFERENCES Publisher(id)
      ON UPDATE CASCADE
  )


CREATE TABLE Story_Type
  (
    id INTEGER,
    name char(64),
    PRIMARY KEY(id)
  )


CREATE TABLE Series_Publication_Type
  (
    id INTEGER,
    name CHAR(32),
    PRIMARY KEY(id)
  )


CREATE TABLE Language
  (
    id INTEGER,
    code CHAR(4),
    name CHAR(32),
    PRIMARY KEY(id)
  )


CREATE TABLE Country
  (
    id INTEGER,
    code CHAR(4),
    name CHAR(32),
    PRIMARY KEY(id)
  )


CREATE TABLE Story_Reprint
  (
    id INTEGER,
    origin_id INTEGER,
    target_id INTEGER,
    PRIMARY KEY(id)
    FOREIGN KEY(origin_id) REFERENCES Story(id)
      ON UPDATE CASCADE,
    FOREIGN KEY(target_id) REFERENCES Story(id)
      ON UPDATE CASCADE
  )


CREATE TABLE Issue_Reprint
  (
    id INTEGER,
    origin_issue_id INTEGER,
    target_issue_id INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(origin_issue_id) REFERENCES Issue(id)
      ON UPDATE CASCADE,
    FOREIGN KEY(target_issue_id) REFERENCES Issue(id)
      ON UPDATE CASCADE
  )


CREATE TABLE Contributor
  (
    id INTEGER,
    name CHAR(64),
    PRIMARY KEY(id)
  )
