import ballerina/http;

isolated service / on new http:Listener(9090) {
    isolated resource function post jsontoxml(http:Request request) returns xml|error? {
        json payload = check request.getJsonPayload();
        json[] orders = check payload.buyStocks.'order.ensureType();
        xml f = from json 'order in orders
            select xml
            `<order><symbol>${(check 'order.symbol).toString()}</symbol><buyerID>${(check 'order.buyerID).toString()}</buyerID><price>${(check 'order.price).toString()}</price><volume>${(check 'order.volume).toString()}</volume></order>`;
        return xml `<buyStocks>${f}</buyStocks>`;
    }
}
