/*********************************************************************************************
 *
 * VersionGuard -- sample VersionGuard.cpp
 *
 * This provides a global symbol that satisifies a symbol reference
 * generated in application object files by VersionGuard.h.
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

#include <hellolib/VersionGuard.h>

// If you're getting errors from the linker that this or a similar
// variable doesn't exist, you have compiled with headers from version
// X of this library, and are trying to link the resulting object
// files to version Y of this library.

int HelloLib::ivgdemo_1_0_1 /*Edited by Make*/ = 0;
