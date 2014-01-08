// 1xx: Information
$http_messages[100] = "Continue"		// The server has received the request headers, and the client should proceed to send the request body
$http_messages[101] = "Switching Protocols"		// The requester has asked the server to switch protocols
$http_messages[103] = "Checkpoint"		// Used in the resumable requests proposal to resume aborted PUT or POST requests

// 2xx: Successful
$http_messages[200] = "OK"		// The request is OK (this is the standard response for successful HTTP requests)
$http_messages[201] = "Created"		// The request has been fulfilled, and a new resource is created 
$http_messages[202] = "Accepted"		// The request has been accepted for processing, but the processing has not been completed
$http_messages[203] = "Non-Authoritative Information"		// The request has been successfully processed, but is returning information that may be from another source
$http_messages[204] = "No Content"		// The request has been successfully processed, but is not returning any content
$http_messages[205] = "Reset Content"		// The request has been successfully processed, but is not returning any content, and requires that the requester reset the document view
$http_messages[206] = "Partial Content"		// The server is delivering only part of the resource due to a range header sent by the client

// 3xx: Redirection
$http_messages[300] = "Multiple Choices"		// A link list. The user can select a link and go to that location. Maximum five addresses  
$http_messages[301] = "Moved Permanently"		// The requested page has moved to a new URL 
$http_messages[302] = "Found"		// The requested page has moved temporarily to a new URL 
$http_messages[303] = "See Other"		// The requested page can be found under a different URL
$http_messages[304] = "Not Modified"		// Indicates the requested page has not been modified since last requested
$http_messages[306] = "Switch Proxy"		// No longer used
$http_messages[307] = "Temporary Redirect"		// The requested page has moved temporarily to a new URL
$http_messages[308] = "Resume Incomplete"		// Used in the resumable requests proposal to resume aborted PUT or POST requests

// 4xx: Client Error
$http_messages[400] = "Bad Request"		// The request cannot be fulfilled due to bad syntax
$http_messages[401] = "Unauthorized"		// The request was a legal request, but the server is refusing to respond to it. For use when authentication is possible but has failed or not yet been provided
$http_messages[402] = "Payment Required"		// Reserved for future use
$http_messages[403] = "Forbidden"		// The request was a legal request, but the server is refusing to respond to it
$http_messages[404] = "Not Found"		// The requested page could not be found but may be available again in the future
$http_messages[405] = "Method Not Allowed"		// A request was made of a page using a request method not supported by that page
$http_messages[406] = "Not Acceptable"		// The server can only generate a response that is not accepted by the client
$http_messages[407] = "Proxy Authentication Required"		// The client must first authenticate itself with the proxy
$http_messages[408] = "Request Timeout"		// The server timed out waiting for the request
$http_messages[409] = "Conflict"		// The request could not be completed because of a conflict in the request
$http_messages[410] = "Gone"		// The requested page is no longer available
$http_messages[411] = "Length Required"		// The"Content-Length" is not defined. The server will not accept the request without it 
$http_messages[412] = "Precondition Failed"		// The precondition given in the request evaluated to false by the server
$http_messages[413] = "Request Entity Too Large"		// The server will not accept the request, because the request entity is too large
$http_messages[414] = "Request-URI Too Long"		// The server will not accept the request, because the URL is too long. Occurs when you convert a POST request to a GET request with a long query information 
$http_messages[415] = "Unsupported Media Type"		// The server will not accept the request, because the media type is not supported 
$http_messages[416] = "Requested Range Not Satisfiable"		// The client has asked for a portion of the file, but the server cannot supply that portion
$http_messages[417] = "Expectation Failed"		// The server cannot meet the requirements of the Expect request-header field

// 5xx: Server Error
$http_messages[500] = "Internal Server Error"		// A generic error message, given when no more specific message is suitable
$http_messages[501] = "Not Implemented"		// The server either does not recognize the request method, or it lacks the ability to fulfill the request
$http_messages[502] = "Bad Gateway"		// The server was acting as a gateway or proxy and received an invalid response from the upstream server
$http_messages[503] = "Service Unavailable"		// The server is currently unavailable (overloaded or down)
$http_messages[504] = "Gateway Timeout"		// The server was acting as a gateway or proxy and did not receive a timely response from the upstream server
$http_messages[505] = "HTTP Version Not Supported"		// The server does not support the HTTP protocol version used in the request
$http_messages[511] = "Network Authentication Required"		// The client needs to authenticate to gain network access
