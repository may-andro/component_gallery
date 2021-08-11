class ColorNotSupportedError extends Error {
  ColorNotSupportedError(this.message);

  final String? message;

  @override
  String toString() {
    final message = this.message;
    return (message != null) ? 'ColorNotSupportedError: $message' : 'ColorNotSupportedError';
  }
}
