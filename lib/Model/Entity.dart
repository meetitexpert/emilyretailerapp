class Entity {

    String? status;
    String? message;

    Entity({this.status, this.message});

    Entity.fromJson(Map<String, dynamic> json) {
        status = json['status'];
        message = json['message'];
    }

}