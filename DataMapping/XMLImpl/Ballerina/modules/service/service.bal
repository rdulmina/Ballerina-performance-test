import ballerina/http;

// import ballerina/io;

configurable string httpClientUrl = ?;

//  Source XML
// <m:buyStocks xmlns:m="http://services.samples/xsd">
//     <order><symbol>SUN</symbol><buyerID>indika</buyerID><price>14.56</price><volume>500</volume></order>
//     <order><symbol>MSFT</symbol><buyerID>doe</buyerID><price>23.56</price><volume>8030</volume></order>
// </m:buyStocks>
//
// Target XML
// <m:buyStocks xmlns:m="http://services.samples/xsd">
//     <order><symbol>SUN</symbol><buyerID>indika</buyerID><totalPrice>7280.0</totalPrice></order>
//     <order><symbol>MSFT</symbol><buyerID>doe</buyerID><totalPrice>189186.8</totalPrice></order>
// </m:buyStocks>

xmlns "http://services.samples/xsd" as m;

isolated service /XMLDataMapping on new http:Listener(9090) {
    final http:Client httpClient;

    function init() returns error? {
        self.httpClient = check new (httpClientUrl);
    }
    isolated resource function post .(xml payload) returns xml|error {
        xml<xml:Element> target = from xml:Element 'order in payload/<'order>
            select xml `<order>
            <symbol>${('order/<symbol>).data()}</symbol>
            <buyerID>${('order/<byerID>).data()}</buyerID>
            <totalPrice>${check float:fromString(('order/<price>).data()) * check int:fromString(('order/<volume>).data())}</totalPrice>
        </order>`;
        return xml `<m:buyStocks>${target}</m:buyStocks>`;

        // return check self.httpClient->/;
    }
}
