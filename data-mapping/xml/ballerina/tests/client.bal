import ballerina/http;
import ballerina/io;
import ballerina/test;

xml payload = xml `<m:buyStocks xmlns:m="http://services.samples/xsd">
                        <order><symbol>SUN</symbol><buyerID>indika</buyerID><price>14.56</price><volume>500</volume></order>
                        <order><symbol>MSFT</symbol><buyerID>doe</buyerID><price>23.56</price><volume>8030</volume></order>
                    </m:buyStocks>`;

xml & readonly expectedXml = xml `<m:buyStocks xmlns:m="http://services.samples/xsd">
                            <order><symbol>SUN</symbol><buyerID>indika</buyerID><totalPrice>7280.0</totalPrice></order>
                            <order><symbol>MSFT</symbol><buyerID>doe</buyerID><totalPrice>189186.8</totalPrice></order>
                        </m:buyStocks>`;

@test:Config {}
function testFunction() {
    http:Client httpClinet = checkpanic new ("http://localhost:9090");
    http:Response response = checkpanic httpClinet->post("/xmlmapper", payload);
    test:assertEquals(<xml:Element>checkpanic response.getXmlPayload(), expectedXml, "Response XML payload mismatched");
    io:println(response.getXmlPayload());
}
