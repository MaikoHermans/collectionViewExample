//
//  musicLibrary.swift
//  collectionViewExample
//
//  Created by Fhict on 13/02/16.
//  Copyright © 2016 PowerCircleDesigns. All rights reserved.
//

import Foundation
import MediaPlayer

class musicLibrary{
    var songsQuery: MPMediaQuery!
    var songs: NSArray!
    
    var albumQuery: MPMediaQuery!
    var albums: NSArray!
    
    var artistQuery: MPMediaQuery!
    var artists: NSArray!
    
    var playlistQuery: MPMediaQuery!
    var playlists: NSArray!
    
    func loadLibrary(){
        loadSongs()
        loadAlbums()
        loadArtists()
        loadPlaylists()
    }
    
    func loadSongs(){
        songsQuery = MPMediaQuery.songsQuery()
        songs = songsQuery.items!
    }
    
    func getSongs() -> NSArray
    {
        return songs
    }
    
    func getSongsCount() -> Int
    {
        return songs.count
    }
    
    func loadAlbums(){
        albumQuery = MPMediaQuery.albumsQuery()
        albums = albumQuery.collections
    }
    
    func getAlbums() -> NSArray{
        return albums
    }
    
    func getAlbumsCount() -> Int
    {
        return albums.count
    }
    
    func loadArtists(){
        artistQuery = MPMediaQuery.artistsQuery()
        artistQuery.groupingType = MPMediaGrouping.AlbumArtist
        artists = artistQuery.collections
    }
    
    func getArtists() -> NSArray
    {
        return artists
    }
    
    func getArtistsCount() -> Int
    {
        return artists.count
    }
    
    func loadPlaylists(){
        playlistQuery = MPMediaQuery.playlistsQuery()
        playlists = playlistQuery.collections
    }
    
    func getPlaylists() -> NSArray{
        return playlists
    }
    
    func getPlaylistsCount() -> Int
    {
        return playlists.count
    }
}