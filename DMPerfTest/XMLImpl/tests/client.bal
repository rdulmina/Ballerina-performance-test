import XMLImpl.'service as balService;

import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunction() {
    http:Client httpClinet = checkpanic new ("http://localhost:9090");
    http:Response response = checkpanic httpClinet->post("/DMPerfTest", xml `<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
    <soapenv:Header><routing xmlns="http://someuri">xadmin;server1;community#1.0##</routing></soapenv:Header>
    <soapenv:Body><m:buyStocks xmlns:m="http://services.samples/xsd">
    <order><symbol>N</symbol><buyerID>n</buyerID><price>1.0</price><volume>1</volume></order>
    <order><symbol>SUN</symbol><buyerID>indika</buyerID><price>14.56</price><volume>500</volume></order>
    </m:buyStocks></soapenv:Body></soapenv:Envelope>`);
    map<balService:Order[]> expected = {'order: [{"symbol":"N", "buyerID":"n", "price":1.0, "volume":1}, {"symbol":"SUN", "buyerID":"indika", "price":14.56, "volume":500}]};
    map<balService:Order[]> actual = checkpanic (checkpanic response.getJsonPayload()).cloneWithType();
    test:assertEquals(actual, expected);
}