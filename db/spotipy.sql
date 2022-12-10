CREATE DATABASE spotipy;

CREATE
USER 'webapp'@'%' IDENTIFIED BY 'abc123';
GRANT ALL PRIVILEGES ON spotipy.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

USE spotipy;

CREATE TABLE Listener(
    username         varchar(255) PRIMARY KEY,
    creationTime     time,
    postalCode       varchar(255),
    birthdate        date,
    country          varchar(255),
    gender           varchar(255),
    mobileNumber     varchar(12),
    email            varchar(255),
    friends          varchar(255),
    podcastListeners varchar(255),
    listeners        varchar(255),
    listenedSongs    varchar(255),
    playlists        varchar(255));

CREATE TABLE Artist(
    artistID   varchar(255) PRIMARY KEY,
    nameArtist varchar(225),
    numOfSongs int,
    listeners  varchar(255),
    worksWith  varchar(255));

CREATE TABLE Producer(
    producerID    varchar(255) PRIMARY KEY,
    numOfSongs    int,
    producerName  varchar(255),
    worksWith     varchar(255),
    songsProduced varchar(255));

CREATE TABLE Album (
    albumID     varchar(255) PRIMARY KEY,
    releaseDate DATE,
    numOfTracks int,
    nameAlbum  varchar(255),
    artistID    varchar(255),
    producerID  varchar(255),
    FOREIGN KEY (artistID) REFERENCES Artist (artistID) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (producerID) REFERENCES Producer (producerID) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Genre(
    genreID varchar(255) PRIMARY KEY,
    genreName varchar(255)
);

CREATE TABLE Podcast(
    podcastId     varchar(255) PRIMARY KEY,
    title         varchar(255),
    releaseDate   date,
    sponsor       varchar(255),
    numOfEpisodes int,
    artistID      varchar(255),
    listeners     varchar(255),
    FOREIGN KEY (artistID) REFERENCES Artist (artistID) ON UPDATE RESTRICT ON DELETE RESTRICT);

CREATE TABLE Songs(
    songID       varchar(255) PRIMARY KEY,
    trackURL     varchar(255),
    msPlayed     int,
    trackName    varChar(255),
    length       int,
    genreID      varchar(255),
    performerID  varchar(255),
    albumOnID    varchar(255),
    producedByID varchar(255),
    playlists    varchar(255),
    listeners    varchar(255),
    FOREIGN KEY (genreID) REFERENCES Genre (genreID) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (performerID) REFERENCES Artist (artistID) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (albumOnID) REFERENCES Album (albumID) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (producedByID) REFERENCES Producer (producerID) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Playlist(
    playlistID  varchar(255) PRIMARY KEY,
    dateCreated date,
    playlistName varchar(255),
    length      int,
    numOfSongs  int,
    makers      varchar(255),
    songs       varchar(255));

CREATE TABLE Listens_to(
    listensToID      varchar(255) PRIMARY KEY,
    monthlyListeners int,
    artistID         varchar(255),
    listenerID       varchar(255),
    FOREIGN KEY (artistID) REFERENCES Artist (artistID) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (listenerID) REFERENCES Listener (username) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Works_with(
    worksWithID varchar(255) PRIMARY KEY,
    artistID    varchar(255),
    producerID  varchar(255),
    label       varchar(255),
    FOREIGN KEY (artistID) REFERENCES Artist (artistID) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (producerID) REFERENCES Producer (producerID) ON UPDATE RESTRICT ON DELETE RESTRICT
);


CREATE TABLE Listened_songs(
    listenedSongsID varchar(255),
    listenerID      varchar(255),
    songID          varchar(255),
    timePlayed varchar(255),
    FOREIGN KEY (listenerID) REFERENCES Listener (username) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (songID) REFERENCES Songs (songID) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Friends(
    friendRelID varchar(255) PRIMARY KEY,
    friend1ID   varchar(255),
    friend2ID   varchar(255),
    FOREIGN KEY (friend1ID) REFERENCES Listener (username) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (friend2ID) REFERENCES Listener (username) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Podcast_Listener(
    podListenerID varchar(255) PRIMARY KEY,
    timePlayed    int,
    podcastID     varchar(255),
    listenerID    varchar(255),
    FOREIGN KEY (podcastID) REFERENCES Podcast (podcastId) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (listenerID) REFERENCES Listener (username) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Playlist_Maker(
    playlistMakerID varchar(255),
    playlistID      varchar(255),
    listenerID      varchar(255),
    minutesPlayed   int,
    FOREIGN KEY (playlistID) REFERENCES Playlist (playlistID) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (listenerID) REFERENCES Listener (username) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE SongsInPlaylist(
    songPlaylistID varchar(255),
    songID         varchar(255),
    playlistID     varchar(255),
    FOREIGN KEY (songID) REFERENCES Songs (songID) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (playlistID) REFERENCES Playlist (playlistID) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE Song_Prod(
    songProdID varchar(255),
    producerID varchar(255),
    songID     varchar(255),
    FOREIGN KEY (songID) REFERENCES Songs (songID) ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY (producerID) REFERENCES Producer (producerID) ON UPDATE RESTRICT ON DELETE RESTRICT
);


insert into Listener values (1, '10:16', '02115', '2022-7-3', 'Canada', 'Female', '891-381-3755',
                             'shills0@sbwire.com', 1, 1, 1, 1, 1);
insert into Listener values (2, '11:18', '02116', '2022-10-15', 'Indonesia', 'Male', '580-747-6821',
                             'bstlouis1@phoca.cz', 2, 2, 2, 2, 2);
insert into Listener values (3, '15:34', '28950', '2022-6-15', 'Turkmenistan', 'Female', '660-528-3630',
                             'lvoysey2@w3.org', 3, 3, 3, 3, 3);
insert into Listener values (4, '23:04', '76201', '2022-11-10', 'Canada', 'Female', '622-622-3980',
                             'swinridge3@hhs.gov', 4, 4, 4, 4, 4);
insert into Listener values (5, '21:40', '04536', '2022-5-24', 'Philippines', 'Male', '974-276-9527',
                             'tleddie4@google.pl', 5, 5, 5, 5, 5);

INSERT INTO Artist VALUES (1, 'Maxx', 80, 1, 1);
INSERT INTO Artist VALUES (2, 'Joani', 72, 2, 2);
INSERT INTO Artist VALUES (3, 'Daisy', 32,  3, 3);
INSERT INTO Artist VALUES (4, 'Betty', 1, 4, 4);
INSERT INTO Artist VALUES (5, 'ALEXGREAT', 18, 5, 5);

insert into Producer values (1, 12, 'Millie', 1, 1);
insert into Producer values (2, 122, 'Bobbie', 2, 2);
insert into Producer values (3, 45, 'Brown', 3, 3);
insert into Producer values (4, 90, 'JacksonJ', 4, 4);
insert into Producer values (5, 200, 'Samuel Sam', 5, 5);

INSERT INTO Album VALUES (1, '2002-11-23', 15, 'Sounds', 5, 4);
INSERT INTO Album VALUES (2, '1986-03-04', 20, 'Ghost', 3, 1);
INSERT INTO Album VALUES (3, '1999-08-08', 19, 'Flying', 1, 2);
INSERT INTO Album VALUES (4, '2020-09-24', 17, 'Radio', 2, 3);
INSERT INTO Album VALUES (5, '2017-02-09', 29, 'Carseat', 2, 5);

INSERT INTO Genre VALUES (1, 'Rock');
INSERT INTO Genre VALUES (2, 'Pop');
INSERT INTO Genre VALUES (3, 'Jazz');
INSERT INTO Genre VALUES (4, 'R_and_B');
INSERT INTO Genre VALUES (5, 'Folk');

insert into Podcast values (1, 'Planet Money', '2021-09-02', 'Clorox', 12, 1, 1);
insert into Podcast values (2, 'NPR News', '2021-09-02', 'Red Sox', 90, 2, 2);
insert into Podcast values (3, 'Lore', '2021-09-02', 'Old Spice', 899, 3, 3);
insert into Podcast values (4, 'National Parks After Dark', '2021-09-02', 'Beats', 03, 4, 4);
insert into Podcast values (5, 'Ologies with Alie Ward', '2021-09-02', 'Otterbox', 100, 5, 5);

insert into Songs values (1, 'https://open.spotify.com/track/3AgqQbQWYLGsemeBHk1U1d?si=6bd8b561b5a646de',
                          5000, 'Autumn Leaves', 5500, 3, 1, 1, 1, 1, 1);
insert into Songs values (2, 'https://open.spotify.com/track/6qMMQzYTKabamnMPlCmfxb?si=85414c2662ed4b99',
                          4000, 'On the Street Where You Live', 4510, 1, 2, 2, 2, 2, 2);
insert into Songs values (3, 'https://open.spotify.com/track/0UqcNRmbuZuxUihXzdQ2br?si=c101b54e28874aa3',
                          9820, 'Back Bay Shuffle', 8736, 2, 3, 3, 3, 3, 3);
insert into Songs values (4, 'https://open.spotify.com/track/3KzgdYUlqV6TOG7JCmx2Wg?si=1de371c17b1e42a4',
                          1000, 'Beyond the Sea', 1100, 5, 4, 4, 4, 4, 4);
insert into Songs values (5, 'https://open.spotify.com/track/1cpANF6zMBoFoxkoIjZHjv?si=8d72be3a0338487c',
                          16000, 'Skating in Central Park', 16400, 4, 5, 5, 5, 5, 5);

insert into Playlist values (1, '2021-02-27', 'nap time', 278, 20, 1, 1);
insert into Playlist values (2, '2021-02-27', 'party time', 278, 20, 2, 2);
insert into Playlist values (3, '2021-02-27', 'study time', 278, 20, 3, 3);
insert into Playlist values (4, '2021-02-27', 'dinner time', 278, 20, 4, 4);
insert into Playlist values (5, '2021-02-27', 'travel time', 278, 20, 5, 5);

insert into Friends values (1, 1, 1);
insert into Friends values (2, 2, 2);
insert into Friends values (3, 3, 3);
insert into Friends values (4, 4, 4);
insert into Friends values (5, 5, 5);

INSERT INTO Listens_to VALUES (1, 4000, 1, 2);
INSERT INTO Listens_to VALUES (2, 500, 2, 1);
INSERT INTO Listens_to VALUES (3, 345000, 2, 4);
INSERT INTO Listens_to VALUES (4, 899900, 3, 5);
INSERT INTO Listens_to VALUES (5, 2000000, 5, 3);

INSERT INTO Works_with VALUES (1, 1, 2, 'BigName');
INSERT INTO Works_with VALUES (2, 2, 3, 'SmallName');
INSERT INTO Works_with VALUES (3, 3, 1, 'BigName');
INSERT INTO Works_with VALUES (4, 4, 5, 'DoorPost');
INSERT INTO Works_with VALUES (5, 5, 4, 'WindowFrame');


insert into Listened_songs values (1, 1, 1, 20);
insert into Listened_songs values (2, 2, 2, 66);
insert into Listened_songs values (3, 3, 3, 5);
insert into Listened_songs values (4, 4, 4, 95);
insert into Listened_songs values (5, 5, 5, 209);


insert into Podcast_Listener values (1, 3456, 1, 1);
insert into Podcast_Listener values (2, 89000, 2, 2);
insert into Podcast_Listener values (3, 23022, 3, 3);
insert into Podcast_Listener values (4, 20000, 4, 4);
insert into Podcast_Listener values (5, 876, 5, 5);

insert into Playlist_Maker values (1, 1, 1, 46748596);
insert into Playlist_Maker values (2, 2, 2, 364);
insert into Playlist_Maker values (3, 3, 3, 3456);
insert into Playlist_Maker values (4, 4, 4, 8653);
insert into Playlist_Maker values (5, 5, 5, 84);

insert into SongsInPlaylist values (1, 1, 1);
insert into SongsInPlaylist values (2, 2, 2);
insert into SongsInPlaylist values (3, 3, 3);
insert into SongsInPlaylist values (4, 4, 4);
insert into SongsInPlaylist values (5, 5, 5);

insert into Song_Prod values (1, 1, 1);
insert into Song_Prod values (2, 2, 2);
insert into Song_Prod values (3, 3, 3);
insert into Song_Prod values (4, 4, 4);
insert into Song_Prod values (5, 5, 5);


SHOW DATABASES;