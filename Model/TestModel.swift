import Foundation

// MARK: - Welcome
public struct Welcome: Codable {
    public let english, phatAm: String?
    public let listEnglish: [ListEnglish]?
    public let listExOfEnglish, listSeeAlso, listBrowse: [String]?
    public let listImg: [ListImg]?
    
    enum CodingKeys: String, CodingKey {
        case english
        case phatAm = "phat_am"
        case listEnglish = "list_english"
        case listExOfEnglish = "list_ex_of_english"
        case listSeeAlso = "list_see_also"
        case listBrowse = "list_browse"
        case listImg = "list_img"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.english = try? container.decodeIfPresent(String.self, forKey: .english) ?? ""
        self.phatAm = try? container.decodeIfPresent(String.self, forKey: .phatAm) ?? ""
        self.listEnglish = try? container.decodeIfPresent([ListEnglish].self, forKey: .listEnglish) ?? []
        self.listExOfEnglish = try? container.decodeIfPresent([String].self, forKey: .listExOfEnglish) ?? []
        self.listSeeAlso = try? container.decodeIfPresent([String].self, forKey: .listSeeAlso) ?? []
        self.listBrowse = try? container.decodeIfPresent([String].self, forKey: .listBrowse) ?? []
        self.listImg = try? container.decodeIfPresent([ListImg].self, forKey: .listImg) ?? []
    }
}

// MARK: - ListEnglish
public struct ListEnglish: Codable {
    public let typeWord: String?
    public let listDefinition: [ListDefinition]?
    
    enum CodingKeys: String, CodingKey {
        case typeWord = "type_word"
        case listDefinition = "list_definition"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.typeWord = try? container.decodeIfPresent(String.self, forKey: .typeWord) ?? ""
        self.listDefinition = try? container.decodeIfPresent([ListDefinition].self, forKey: .listDefinition) ?? []
    }
}

// MARK: - ListDefinition
public struct ListDefinition: Codable {
    public let meanEnglish, definition: String?
    public let worldNew: [String]?
    public let listExOfDefinition: [ListExOfDefinition]?
    
    enum CodingKeys: String, CodingKey {
        case meanEnglish = "mean_english"
        case definition
        case worldNew = "world_new"
        case listExOfDefinition = "list_ex_of_definition"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
     self.meanEnglish = try? container.decodeIfPresent(String.self, forKey: .meanEnglish) ?? ""
        self.definition = try? container.decodeIfPresent(String.self, forKey: .definition) ?? ""
        self.worldNew = try? container.decodeIfPresent([String].self, forKey: .worldNew) ?? []
        self.listExOfDefinition = try? container.decodeIfPresent([ListExOfDefinition].self, forKey: .listExOfDefinition) ?? []
    }
}

// MARK: - ListExOfDefinition
public struct ListExOfDefinition: Codable {
    public let exOfDefinition: String?
    public let worldNew: [String]?
    
    enum CodingKeys: String, CodingKey {
        case exOfDefinition = "ex_of_definition"
        case worldNew = "world_new"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.exOfDefinition = try? container.decodeIfPresent(String.self, forKey: .exOfDefinition) ?? ""
        self.worldNew = try? container.decodeIfPresent([String].self, forKey: .worldNew) ?? []
    }
}

// MARK: - ListImg
public struct ListImg: Codable {
    public let linkThumb: String?
    public let linkImg: String?
    public let idImage: String?
    
    enum CodingKeys: String, CodingKey {
        case linkThumb = "link_thumb"
        case linkImg = "link_img"
        case idImage = "id_image"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.linkThumb = try? container.decodeIfPresent(String.self, forKey: .linkThumb) ?? ""
        self.linkImg = try? container.decodeIfPresent(String.self, forKey: .linkImg) ?? ""
        self.idImage = try? container.decodeIfPresent(String.self, forKey: .idImage) ?? ""
    }
}
