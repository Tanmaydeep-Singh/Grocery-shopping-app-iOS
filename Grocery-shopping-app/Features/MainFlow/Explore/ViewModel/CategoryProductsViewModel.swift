//
//  CategoryProductsViewModel.swift
//  Nectar
//
//  Created by rentamac on 2/11/26.
//
import Foundation

func getFilterProducts(_ categories: Set<String>,_ brands: Set<String>) async throws -> [Product] {
    let products = try await ProductService().fetchAllProducts()
    let categoryFiltered = categories.isEmpty
    ? products
    : products.filter { product in
        categories.contains(product.category.rawValue)
    }
    return categoryFiltered
}
