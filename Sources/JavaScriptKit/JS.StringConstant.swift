import _CJavaScriptKit

extension JS
{
    public
    final class StringConstant
    {
        @usableFromInline
        let reference:JavaScriptObjectRef

        @inlinable
        init(reference:JavaScriptObjectRef)
        {
            self.reference = reference
        }

        @inlinable
        deinit
        {
            swjs_release(self.reference)
        }
    }
}
extension JS.StringConstant
{
    @inlinable public convenience
    init(encoding string:consuming String)
    {
        let reference:JavaScriptObjectRef = string.withUTF8
        {
            swjs_decode_string($0.baseAddress!, Int32.init($0.count))
        }
        self.init(reference: reference)
    }
}
extension JS.StringConstant:ExpressibleByStringLiteral
{
    @inlinable public convenience
    init(stringLiteral:String) { self.init(encoding: stringLiteral) }
}
