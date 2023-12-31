import ballerina/http;
import ballerina/io;
import ballerina/mime;
import ballerina/test;

xml payload = xml `<m:buyStocks xmlns:m="http://services.samples/xsd">
    <order><symbol>N</symbol><buyerID>n</buyerID><price>1.0</price><volume>1</volume></order>
    <order><symbol>SUN</symbol><buyerID>indika</buyerID><price>14.56</price><volume>500</volume></order>
    </m:buyStocks>`;

@test:Config {}
function testFunction() {
    http:Client httpClinet = checkpanic new ("http://localhost:9090");
    http:Response response = checkpanic httpClinet->/cbr.post(payload, headers = {accept: mime:APPLICATION_XML});
    test:assertEquals(response.statusCode, 200);
    io:println(response.getXmlPayload());
}
