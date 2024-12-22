import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    var images: [Result] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        fetchData()
        let nib = UINib(nibName: "CustomeImageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ImageCell")
    }
    
    // Function to fetch image data directly using URLSession
    func fetchData() {
        let urlString = "https://api.unsplash.com/search/photos?page=1&query=cat&client_id=zXjQoI-aLWOJz4RkKne7xVr7oiBUqSujzHlk2WhD7oU&per_page=30" // Replace with your API URL
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Failed to fetch images: \(error)")
                return
            }
            
            guard let data = data else {
                print("No Data Found")
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Response: \(jsonString)")
            }
            
            do {
                let welcome = try JSONDecoder().decode(UnsplashStruct.self, from: data)
                self?.images = welcome.results
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! CustomeImageCollectionViewCell
        let imageUrl = (images[indexPath.item].urls.thumb)!
        cell.configure(with: imageUrl)
        return cell
    }
}
