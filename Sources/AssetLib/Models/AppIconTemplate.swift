public struct AppIconTemplate: Codable {
  let devices: Set<AppIconDevice>
  let specifyGamut: Bool
  let prerendered: Bool
}
