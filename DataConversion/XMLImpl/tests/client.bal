import XMLImpl.'service as balService;

import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunction() {
    http:Client httpClinet = checkpanic new ("http://localhost:9090");
    http:Response response = checkpanic httpClinet->post("/XMLToJson", xml `<m:buyStocks xmlns:m="http://services.samples/xsd">
    <order><symbol>N</symbol><buyerID>n</buyerID><price>1.0</price><volume>1</volume></order>
    <order><symbol>SUN</symbol><buyerID>indika</buyerID><price>14.56</price><volume>500</volume></order>
    </m:buyStocks>`);
    map<map<balService:Order[]>> expected = {"buyStocks":{"order":[{"symbol":"N","buyerID":"n","price":1.0,"volume":1},{"symbol":"SUN","buyerID":"indika","price":14.56,"volume":500}]}};
    map<map<balService:Order[]>> actual = checkpanic (checkpanic response.getJsonPayload()).cloneWithType();
    test:assertEquals(actual, expected);
}