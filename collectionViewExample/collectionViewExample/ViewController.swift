//
//  ViewController.swift
//  collectionViewExample
//
//  Created by Fhict on 13/02/16.
//  Copyright © 2016 PowerCircleDesigns. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var view_playlist: UIView!
    @IBOutlet var view_artist: UIView!
    @IBOutlet var view_album: UIView!
    @IBOutlet var PlaylistCollectionView: UICollectionView!
    @IBOutlet var ArtistCollectionView: UICollectionView!
    @IBOutlet var AlbumCollectionView: UICollectionView!
    
    var musicLib = musicLibrary()
    
    var layout: CustomCollectionViewFlow!
    var cview: UICollectionView!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicLib.loadLibrary()
        
        PlaylistCollectionView.indicatorStyle = UIScrollViewIndicatorStyle.White
        AlbumCollectionView.indicatorStyle = UIScrollViewIndicatorStyle.White
        ArtistCollectionView.indicatorStyle = UIScrollViewIndicatorStyle.White
        
        layout = CustomCollectionViewFlow()
        
        cview = ArtistCollectionView
        
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        
        ArtistCollectionView.collectionViewLayout = layout
        ArtistCollectionView.registerNib(nib, forCellWithReuseIdentifier: "item")
        ArtistCollectionView.dataSource = self
        
        PlaylistCollectionView.collectionViewLayout = layout
        PlaylistCollectionView.registerNib(nib, forCellWithReuseIdentifier: "item")
        PlaylistCollectionView.dataSource = self
        
        AlbumCollectionView.collectionViewLayout = layout
        AlbumCollectionView.registerNib(nib, forCellWithReuseIdentifier: "item")
        AlbumCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Check which view is enabled
        if(view_album.hidden == false){
            return musicLib.getAlbumsCount()
        }
        else if(view_artist.hidden == false){
            return musicLib.getArtistsCount()
        }
        else if(view_playlist.hidden == false){
            return musicLib.getPlaylistsCount()
        }
        else {return 0}
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = cview.dequeueReusableCellWithReuseIdentifier("item", forIndexPath: indexPath) as! CollectionViewCell
        if(view_artist.hidden == false)
        {
            let objects = musicLib.getArtists().objectAtIndex(indexPath.item) as! MPMediaItemCollection
            let repObjects = objects.representativeItem
            
            cell.lbl_Name.text = repObjects!.valueForProperty(MPMediaItemPropertyAlbumArtist) as? String
            
            let artwork = repObjects!.valueForProperty(MPMediaItemPropertyArtwork)
            
            let artworkImage = artwork?.imageWithSize(CGSize(width: 230, height: 230))
            
            if(artworkImage != nil){
                cell.img_artwork.image = artworkImage
            }
            else{
                cell.img_artwork.image = UIImage(named: "no_Artwork.png")
            }
        }
        else if(view_album.hidden == false){
            let objects = musicLib.getAlbums().objectAtIndex(indexPath.item) as! MPMediaItemCollection
            let repObjects = objects.representativeItem
            
            cell.lbl_Name.text = repObjects!.valueForProperty(MPMediaItemPropertyAlbumTitle) as? String
            
            let artwork = repObjects!.valueForProperty(MPMediaItemPropertyArtwork)
            
            let artworkImage = artwork?.imageWithSize(CGSize(width: 230, height: 230))
            
            if(artworkImage != nil){
                cell.img_artwork.image = artworkImage
            }
            else{
                cell.img_artwork.image = UIImage(named: "no_Artwork.png")
            }
        }
        else if(view_playlist.hidden == false){
            let objects = musicLib.getPlaylists().objectAtIndex(indexPath.item) as! MPMediaItemCollection
            let repObjects = objects.representativeItem
            
            cell.lbl_Name.text = objects.valueForProperty(MPMediaPlaylistPropertyName) as? String
            
            let artwork = repObjects?.valueForProperty(MPMediaItemPropertyArtwork)
            
            let artworkImage = artwork?.imageWithSize(CGSize(width: 230, height: 230))
            
            if(artworkImage != nil){
                cell.img_artwork.image = artworkImage
            }
            else{
                cell.img_artwork.image = UIImage(named: "no_Artwork.png")
            }
            
        }
        
        return cell
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if(view_album.hidden == false){
            guard let AlbumflowLayout = AlbumCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
                return
            }
            
            layout = CustomCollectionViewFlow()
            AlbumCollectionView.collectionViewLayout = layout
            AlbumflowLayout.invalidateLayout()
        }
        
        if(view_artist.hidden == false){
            guard let ArtistFlowLayout = ArtistCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
                return
            }
            
            layout = CustomCollectionViewFlow()
            ArtistCollectionView.collectionViewLayout = layout
            ArtistFlowLayout.invalidateLayout()
        }
        
        if(view_playlist.hidden == false){
            guard let PlaylistFlowLayout = PlaylistCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
                return
            }
            
            layout = CustomCollectionViewFlow()
            PlaylistCollectionView.collectionViewLayout = layout
            PlaylistFlowLayout.invalidateLayout()
        }
    }

}

