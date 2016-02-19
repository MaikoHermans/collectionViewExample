//
//  ViewController.swift
//  collectionViewExample
//
//  Created by Fhict on 13/02/16.
//  Copyright © 2016 PowerCircleDesigns. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, RBCollectionViewInfoFolderLayoutDelegate {

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
        
        let lay: RBCollectionViewInfoFolderLayout = ArtistCollectionView.collectionViewLayout as! RBCollectionViewInfoFolderLayout
        lay.cellSize = CGSizeMake(80, 80)
        lay.interItemSpacingY = 10
        lay.interItemSpacingX = 0
        
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        
        cview.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: RBCollectionViewInfoFolderHeaderKind, withReuseIdentifier: "header")
        cview.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: RBCollectionViewInfoFolderFooterKind, withReuseIdentifier: "footer")
        cview.registerClass(collectionViewFolder.self, forSupplementaryViewOfKind: RBCollectionViewInfoFolderFolderKind, withReuseIdentifier: "folder")
        cview.registerClass(RBCollectionViewInfoFolderDimple.self, forSupplementaryViewOfKind: RBCollectionViewInfoFolderDimpleKind, withReuseIdentifier: "dimple")
        
        
        ArtistCollectionView.collectionViewLayout = lay
        ArtistCollectionView.registerNib(nib, forCellWithReuseIdentifier: "item")
        ArtistCollectionView.dataSource = self
        ArtistCollectionView.delegate = self
        
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
            return 20
            //return musicLib.getArtistsCount()
        }
        else if(view_playlist.hidden == false){
            return musicLib.getPlaylistsCount()
        }
        else {return 0}
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reuseView: UICollectionReusableView!
        
        if(kind == RBCollectionViewInfoFolderHeaderKind){
            reuseView = cview.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath)
        }
        
        if(kind == RBCollectionViewInfoFolderFooterKind){
            reuseView = cview.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footer", forIndexPath: indexPath)
        }
        
        if(kind == RBCollectionViewInfoFolderFolderKind){
            let colViewFolder: collectionViewFolder = cview.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "folder", forIndexPath: indexPath) as! collectionViewFolder
            
            colViewFolder.backgroundColor = UIColor.redColor()
            
            reuseView = colViewFolder
        }
        
        if(kind == RBCollectionViewInfoFolderDimpleKind){
            let dimple: RBCollectionViewInfoFolderDimple = cview.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "dimple", forIndexPath: indexPath) as! RBCollectionViewInfoFolderDimple
            
            dimple.color = UIColor.blueColor()
            
            reuseView = dimple
        }
        
        return reuseView
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let lay: RBCollectionViewInfoFolderLayout = cview.collectionViewLayout as! RBCollectionViewInfoFolderLayout
        lay.toggleFolderViewForIndexPath(indexPath)
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

    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: RBCollectionViewInfoFolderLayout!, heightForFolderAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 200
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: RBCollectionViewInfoFolderLayout!, sizeForFooterInSection section: Int) -> CGSize {
        return CGSizeMake(0, 0)
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: RBCollectionViewInfoFolderLayout!, sizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(0, 0)
    }
}

