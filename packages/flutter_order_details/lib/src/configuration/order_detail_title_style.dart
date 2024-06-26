/// An enum to define the style of the title in the order detail.
enum OrderDetailTitleStyle {
  /// The title displayed as a textlabel above the field.
  text,

  /// The title displayed as a label inside the field.
  /// NOTE: Not all fields support this. Such as, but not limited to:
  /// - Dropdown
  /// - Time Picker
  label,

  /// Does not display any form of title.
  none,
}
