import ballerina/http;
import ballerina/io;
import ballerina/test;

json payload = {
    "buyStocks": {
        "order": [
            {
                "symbol": "SUN",
                "buyerID": "indika",
                "price": 14.56,
                "volume": 500
            },
            {
                "symbol": "MSFT",
                "buyerID": "doe",
                "price": 23.56,
                "volume": 8030
            }
        ]
    }
};

json expectedJson = {
    "buyStocks": {
        "order": [
            {
                "symbol": "SUN",
                "buyerID": "indika",
                "totalPrice": 7280.0
            },
            {
                "symbol": "MSFT",
                "buyerID": "doe",
                "totalPrice": 189186.8
            }
        ]
    }
};

@test:Config {}
function testFunction() {
    http:Client httpClinet = checkpanic new ("http://localhost:9090");
    http:Response response = checkpanic httpClinet->post("/jsonmapper", payload);
    test:assertEquals(response.getTextPayload(), expectedJson.toJsonString(), "Response JSON payload mismatched");
    io:println(response.getJsonPayload());
}
