import ballerina/http;
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
    http:Response response = checkpanic httpClinet->post("/jsontoxml", payload);
    string expected = string `<payload><symbol>json</symbol><symbol>json</symbol><symbol>json</symbol><symbol>son</symbol><symbol>json</symbol><symbol>json</symbol><symbol>json</symbol><symbol>json</symbol><symbol>json</symbol><symbol>json</symbol><symbol>json</symbol></payload>`;
    string actual = (checkpanic response.getXmlPayload()).toString();
    test:assertEquals(actual, expected);
}
