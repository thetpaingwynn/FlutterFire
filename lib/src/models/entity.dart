abstract class Entity {
  String id;
  String type;
  String createdBy;
  DateTime createdDate;
  String updatedBy;
  DateTime updatedDate;

  Entity({
    this.id,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  }) {
    this.type = _getType();
    if (this.createdDate == null) this.createdDate = DateTime.now().toUtc();
  }

  String _getType() {
    String runtimeType = this.runtimeType.toString();
    return runtimeType[0].toLowerCase() + runtimeType.substring(1);
  }
}
