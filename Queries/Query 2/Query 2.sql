# Display which customer most recently used the streaming service

SELECT 
    users_has_playlist.Users_idUsers,
    song_name,
    artist_name,
    MAX(song_played) AS Recent_Played
FROM
    users_has_playlist
        JOIN
    playlist_has_song
        JOIN
    song
        JOIN
    song_has_artist
        JOIN
    artist
WHERE
    playlist_has_song.Song_idSong = idSong
        AND idSong = song_has_artist.Song_idSong
        AND Artist_idArtist = idArtist
        AND users_has_playlist.Playlist_idPlaylist = playlist_has_song.Playlist_idPlaylist
GROUP BY Users_idUsers
ORDER BY song_played DESC