import _CJavaScriptKit

extension JS
{
    public
    typealias Object = JSObject
}
extension JS.Object
{
    public
    func get(_ name:JS.StringConstant) -> JSValue
    {
        var raw:RawJSValue = .init()
        let bits:UInt32 = swjs_get_prop(self.id, name.reference, &raw.payload1, &raw.payload2)
        raw.kind = unsafeBitCast(bits, to: JavaScriptValueKind.self)
        return raw.jsValue
    }

    public
    func set(_ name:JS.StringConstant, to value:JSValue)
    {
        value.withRawJSValue
        {
            swjs_set_prop(self.id, name.reference, $0.kind, $0.payload1, $0.payload2)
        }
    }
}
