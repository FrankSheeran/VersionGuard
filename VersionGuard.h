/*********************************************************************************************
 *
 * VersionGuard -- sample VersionGuard.h
 *
 * This generates a symbol reference to a symbol which will only be
 * defined in the version of the static or shared library
 * corresponding to this header.
 *
 * WARNING: the distribution number in the file is automatically
 * updated by gmake.  The command in gmake searches for the "Edited
 * by" comment text and will check and update if necessary the token
 * before it.
 *
 * For details and legal information please see the accompanying
 * VersionGuard document and LICENSE file.
 *
 ********************************************************************************************/

#pragma once

namespace HelloLib {

extern int ivgdemo_1_0_1 /*Edited by Make*/;

class VersionGuard {
public:
    inline VersionGuard(){
        ivgdemo_1_0_1 /*Edited by Make*/ ++;
    }
};

} // namespace
