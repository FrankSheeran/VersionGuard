// VersionGuard -- demo library hellolib.h
//
// This is used in the demo in the VersionGuard documentation.
//
// For details and legal information please see the accompanying
// VersionGuard document and LICENSE file.

#include <cstdlib>
#include <iostream>

#include <hellolib.h>

void HelloLib::greet( bool bFlag ) {
    if ( bFlag )
        abort();
    
    std::cout << "Hello World!" << std::endl;
}
