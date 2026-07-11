import Foundation

// The API wraps results in a Collection+JSON envelope:
// {
//   "collection": {
//     "items": [
//       {
//         "data":  [{ "nasa_id": "...", "title": "...", "date_created": "..." }],
//         "links": [{ "href": "...~thumb.jpg", "rel": "preview", "render": "image" }]
//       }
//     ],
//     "metadata": { "total_hits": 12345 }
//   }
// }
// snake_case keys become camelCase via the decoder's convertFromSnakeCase.

struct NASAImageSearchDTO: Decodable {
    let collection: CollectionDTO

    struct CollectionDTO: Decodable {
        let items: [ItemDTO]
        let metadata: MetadataDTO?
    }

    struct MetadataDTO: Decodable {
        let totalHits: Int
    }

    struct ItemDTO: Decodable {
        let data: [ItemDataDTO]
        let links: [ItemLinkDTO]?
    }

    struct ItemDataDTO: Decodable {
        let nasaId: String
        let title: String
        let description: String?
        let dateCreated: String?
        let center: String?
        let keywords: [String]?
        let mediaType: String
        let photographer: String?
    }

    struct ItemLinkDTO: Decodable {
        let href: String
        let rel: String
        let render: String?
        let width: Int?
    }
}
