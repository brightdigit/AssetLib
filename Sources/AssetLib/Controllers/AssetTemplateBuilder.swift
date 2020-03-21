/**
 Builds a `AssetSpecificationDocument` based on the `Template`.
 */
protocol AssetTemplateBuilder {
  /**
   The template type accepted by the builder.
   */
  associatedtype Template

  /**
   Creates `AssetSpecificationDocumentProtocol` based on the `Template`.

    - Parameter template: The `emplate`.
    - Returns: The `AssetSpecificationDocumentProtocol`
   */
  func document(fromTemplate template: Template) -> AssetSpecificationDocumentProtocol
}
