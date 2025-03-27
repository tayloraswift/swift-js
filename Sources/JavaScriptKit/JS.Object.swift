import _CJavaScriptKit

extension JS
{
    public
    typealias Object = JSObject
}
extension JS.Object
{
    /// Access the `name` member dynamically through JavaScript and Swift runtime bridge
    /// library.
    /// -   Parameter name:
    ///     The name of this object's member to access.
    /// -   Returns:
    ///     The value of the `name` member of this object.
    public subscript(_ name:JS.StringConstant) -> JSValue
    {
        get
        {
            self.get(name)
        }
        set(value)
        {
            self.set(name, to: value)
        }
    }

    private
    func get(_ name:JS.StringConstant) -> JSValue
    {
        var raw:RawJSValue = .init()
        let bits:UInt32 = swjs_get_prop(self.id, name.reference, &raw.payload1, &raw.payload2)
        raw.kind = unsafeBitCast(bits, to: JavaScriptValueKind.self)
        return raw.jsValue
    }

    private
    func set(_ name:JS.StringConstant, to value:JSValue)
    {
        value.withRawJSValue
        {
            swjs_set_prop(self.id, name.reference, $0.kind, $0.payload1, $0.payload2)
        }
    }
}
