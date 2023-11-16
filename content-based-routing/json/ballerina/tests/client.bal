import ballerina/http;
import ballerina/io;
import ballerina/mime;
import ballerina/test;

json payload = {
    "payload": {
        "symbol": [
            "json",
            "json",
            "json",
            "json",
            "json",
            "json",
            "json",
            "json",
            "json",
            "json",
            "json"
        ]
    }
};

@test:Config {}
function testFunction() {
    http:Client httpClinet = checkpanic new ("http://localhost:9090");
    http:Response response = checkpanic httpClinet->post("/cbr", payload, headers = {accept: mime:APPLICATION_JSON});
    test:assertEquals(response.statusCode, 200);
    io:println(response.getJsonPayload());
}
