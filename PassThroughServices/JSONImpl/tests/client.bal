import JSONImpl.'service as _;

import ballerina/http;
import ballerina/io;
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
    http:Client httpClinet = checkpanic new ("http://localhost:9090/PassThroughJson");
    http:Response response = checkpanic httpClinet->post("/a/b/c", payload);
    test:assertEquals(response.statusCode, 200);
    io:println(response.getJsonPayload());
}
