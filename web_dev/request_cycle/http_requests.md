### Common HTTP Codes

**100 - Continue**
100 means that the request can be continued - this confirms that the server is ready and able to process a request, and that what has been received so far seems ok.

**101 - Switching Protocols**

This acknowledges a request to change protocols - for example, if the client requests a change to a newer version of HTTP, and the server agrees, it will send this response.

**1xx - Informational**

other codes from 101-199 are informational.  It looks like these aren't really necessary - I'm guessing that they are mostly for debugging type purposes?

**200 - OK**

This code means *success!* - whatever the request was, it has been completed succesfully, and whatever was requests was sent back out - for example, an image has been loaded, or an upload has been recevied (and perhaps a receipt sent back)

** 201 - Created**

This is also a success message - and indicates that something that was supposed to be created has been - it should come along with information about where to find the newly created whatever.

**202 - Accepted**

The request has been accepted, but processing is not yet complete.  This might happen if the request has a whole batch of things to process and will take a while - once the 202 message is received, the client no longer needs to stay actively connected.

**203 - Non-Authoritative Information**

This seems like a substitute for code 200 - it means that things seems successful, but indicates that the return came from a copy of the server, rather than the definitive thing.  This message might be useful in making sure that things are happening with correct synchronicity - for example, high speed arbitrage might care very much whether they have received a their data from the server, or from a copy?

**204 - No Content**

This means that the request was fulfilled successfully, but there is nothing to send back.

**205 - Reset Content**

This means that the request was completed, and that the view should be reset - for example, After the user enters a password, we might want to clear out the password field.

**206 - Partial Content**

This means that part of the request was fulfilled.  This might happen when a request is asking for a range of content - an example might be watching and buffering a streaming video?

**300's - Various kinds of redirects**

All the 300 codes are various types of redirection, such as 'this file has moved, update your link' or 'this file has moved, but not permanently, here it is and don't update' or 'for now, these requests are being handled by this other thing...' etc.

**400 - Bad Request**

This request has bad syntax and cannot be understood

**401 - Unauthorized**

The request is for something which requires user authentication.  This will happen if the request is sent with no credentials, or with incorrect credentials.

**403 Forbidden**

The request was understood but is refused.  Authorization credentials don't matter to this one, but the server should explain why the request is forbidden (otherwise use 404)

**404 Not Found** 

The server did not find anything matching the request - even though the request itself seems propely formed.  Going to a deleted webpage, for example, might cause this to happen.

**405+ More Errors**

All the different 400 codes are errors of one kind or another, generally having to do with the specifics of the request (its size, its methods, etc) not fitting the parameters of the servers URI.

**500 Server Error**

The server encountered an internal error and could not complete the request

**501 Not Implemented**

The server cannot fulfill the reqet because it is not capable of supporting whatever was requested

**502, 502, 504**

These are gateway errors having to do with the connection of the server upstream

**505 HTTP version not supported**

The server either cannot or *will* not support the protocol version used in the request.
