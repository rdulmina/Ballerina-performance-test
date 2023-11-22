import ballerina/http;

configurable string httpClientUrl = ?;

xmlns "http://services.samples/xsd" as m;

isolated service / on new http:Listener(9090) {
    final http:Client clientOne;
    final http:Client clientTwo;

    function init() returns error? {
        self.clientOne = check new (httpClientUrl);
        self.clientTwo = check new (httpClientUrl);
    }

    isolated resource function post cbr(http:Request request) returns http:Response|error {
        xml orders = check request.getXmlPayload();
        if re `SUN`.isFullMatch((((orders/**/<'order>)[1])/<symbol>).data()) {
            return self.clientOne->/cbr.post(request);
        }
        return self.clientTwo->/cbr.post(request);
    }
}
