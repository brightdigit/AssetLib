/**
 Type of operation when doing a product with a filter.
 */
enum ProductOperation {
  /**
   Return only the result of the operation including only filtered results.
   */
  case new
  /**
   Return the filtered results appended to the original.
   */
  case append
  /**
   Return the modified array with the filtered results replacing the original items which match the filter...
   */
  case modify
}
