import ballerina/http;
import ballerina/io;
import ballerina/mime;
import ballerina/test;

json payload = {
    "buyStocks": {
        "order":
    [
            {"symbol": "N", "buyerID": "n", "price": 1.0, "volume": 1},
            {"symbol": "SUN", "buyerID": "indika", "price": 14.56, "volume": 500},
            {"symbol": "MSFT", "buyerID": "doe", "price": 23.56, "volume": 8030}
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
