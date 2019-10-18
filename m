Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456F3CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CF9222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505360AbfJRPnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:43:35 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38795 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505238AbfJRPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:50 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N6bo8-1hyk0j1pkM-0183vP; Fri, 18 Oct 2019 17:42:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 42/46] ARM: pxa: remove unused mach/bitfield.h
Date:   Fri, 18 Oct 2019 17:41:57 +0200
Message-Id: <20191018154201.1276638-42-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MawNLkONnTydx3voDjASMOY1YX3Q2HFVw/Zx1i20aZcAxlZEQN3
 PwIvYpFxW385uKg533nwuZQJHTZVOQotsI4pLrM5FSiS2EsTxEFQu6KUaDZVlxVHBuRKj40
 2g6G4rU4ofriBDld+bP1ghms0VKDjH2yfcN4aS+fxyqPRATnboOYEoVWz+uhM4VHQ3ppZul
 62L7T93fEWV3yRyeJ1HHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dlPhYoGbnPE=:dowJAAvRTybL/BGzSRUYDS
 otpbXyH8f8ZrraQvf4YNp0Y4SQLUuy+oEW6TszPqh/Gh9OtCYCMHRcySuZxAgVNBCazhT+fTc
 UPuvU03Y8pZYxbNCKqvrLQ+rJSc4aGBpW9vHUArv9eVBJ0OcYmKH3Z2wv2qk82sHwrL/oZxzl
 J8VpWJzCEUueo0tfIgtGd7val5Qg5B87BIxk0xnf13XRb/wLtdzJ1OcwfoKORy96OwvMmH99O
 czBV1iKdwQ2SsNcDE5cGZdu0ExatpjlLlpCXcxKblP3NJpG0qbMzzgC3/mGcjXV0gpi+664q9
 JbzFIT6eokQbtfieEVcAu4J4Xr+mJBcrun1WlhdFKrP2CS/CC5tpmlWjUpo64IX0nosxK0zGy
 MJ2fUjjNKvqYJ/UI2AaCSj48juuOIOi8yB4T96rZNdKH2IylrUHatFYLVuLCcq+nVplzBcciE
 Rh1I64NEciPR5ylbCwf9GVD5kuJ/h4bykOJBNRgjRCCQanS+SrjK6B+YsmS5vHg3f/8bBci5I
 8umJjsrwnrJqtsixmUJfECdl5o5KMgrL+8x7yRc+3cv5zFNbXIZ0kwXBuU33W26LxzZFW2uyE
 SbhQHspPaXZ4+mWgsV9tPkFEkOo38If05TLfzmZYlE8MfK3v81wScmDlFnBxQAa4c3qA3xOKm
 2x93cH5hwbxO0vFCG5DKhApChtud7qiSdL4IVIQ/CY/0K3dHfammCmjiEFsOANEXSE+9z9yC5
 MRnpXCA0iChkccbIRJCxjevyfIiHTBaMCAi/1DVgjNQ+g4CA2blahgeeniLyd3unnwFvG20aM
 RvX2ZtPJE9MyF4EIYhGL3KCOtVup4aKKjy+P2I1QlsykGOqdaGEOWXqf+dNtg0OsJWgoVx/l4
 eiMXHgRWL8vILs8HkCWw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sa1111.h header defines some constants using the bitfield
macros, but those are only used on sa1100, not on pxa, and the
users include the bitfield header through mach/hardware.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/hardware/sa1111.h    |   2 -
 arch/arm/mach-pxa/include/mach/bitfield.h | 114 ----------------------
 2 files changed, 116 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/bitfield.h

diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index d134b9a5ff94..dc8850238e2b 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -13,8 +13,6 @@
 #ifndef _ASM_ARCH_SA1111
 #define _ASM_ARCH_SA1111
 
-#include <mach/bitfield.h>
-
 /*
  * Don't ask the (SAC) DMA engines to move less than this amount.
  */
diff --git a/arch/arm/mach-pxa/include/mach/bitfield.h b/arch/arm/mach-pxa/include/mach/bitfield.h
deleted file mode 100644
index fe2ca441bc0a..000000000000
--- a/arch/arm/mach-pxa/include/mach/bitfield.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *	FILE    	bitfield.h
- *
- *	Version 	1.1
- *	Author  	Copyright (c) Marc A. Viredaz, 1998
- *	        	DEC Western Research Laboratory, Palo Alto, CA
- *	Date    	April 1998 (April 1997)
- *	System  	Advanced RISC Machine (ARM)
- *	Language	C or ARM Assembly
- *	Purpose 	Definition of macros to operate on bit fields.
- */
-
-
-
-#ifndef __BITFIELD_H
-#define __BITFIELD_H
-
-#ifndef __ASSEMBLY__
-#define UData(Data)	((unsigned long) (Data))
-#else
-#define UData(Data)	(Data)
-#endif
-
-
-/*
- * MACRO: Fld
- *
- * Purpose
- *    The macro "Fld" encodes a bit field, given its size and its shift value
- *    with respect to bit 0.
- *
- * Note
- *    A more intuitive way to encode bit fields would have been to use their
- *    mask. However, extracting size and shift value information from a bit
- *    field's mask is cumbersome and might break the assembler (255-character
- *    line-size limit).
- *
- * Input
- *    Size      	Size of the bit field, in number of bits.
- *    Shft      	Shift value of the bit field with respect to bit 0.
- *
- * Output
- *    Fld       	Encoded bit field.
- */
-
-#define Fld(Size, Shft)	(((Size) << 16) + (Shft))
-
-
-/*
- * MACROS: FSize, FShft, FMsk, FAlnMsk, F1stBit
- *
- * Purpose
- *    The macros "FSize", "FShft", "FMsk", "FAlnMsk", and "F1stBit" return
- *    the size, shift value, mask, aligned mask, and first bit of a
- *    bit field.
- *
- * Input
- *    Field     	Encoded bit field (using the macro "Fld").
- *
- * Output
- *    FSize     	Size of the bit field, in number of bits.
- *    FShft     	Shift value of the bit field with respect to bit 0.
- *    FMsk      	Mask for the bit field.
- *    FAlnMsk   	Mask for the bit field, aligned on bit 0.
- *    F1stBit   	First bit of the bit field.
- */
-
-#define FSize(Field)	((Field) >> 16)
-#define FShft(Field)	((Field) & 0x0000FFFF)
-#define FMsk(Field)	(((UData (1) << FSize (Field)) - 1) << FShft (Field))
-#define FAlnMsk(Field)	((UData (1) << FSize (Field)) - 1)
-#define F1stBit(Field)	(UData (1) << FShft (Field))
-
-
-/*
- * MACRO: FInsrt
- *
- * Purpose
- *    The macro "FInsrt" inserts a value into a bit field by shifting the
- *    former appropriately.
- *
- * Input
- *    Value     	Bit-field value.
- *    Field     	Encoded bit field (using the macro "Fld").
- *
- * Output
- *    FInsrt    	Bit-field value positioned appropriately.
- */
-
-#define FInsrt(Value, Field) \
-                	(UData (Value) << FShft (Field))
-
-
-/*
- * MACRO: FExtr
- *
- * Purpose
- *    The macro "FExtr" extracts the value of a bit field by masking and
- *    shifting it appropriately.
- *
- * Input
- *    Data      	Data containing the bit-field to be extracted.
- *    Field     	Encoded bit field (using the macro "Fld").
- *
- * Output
- *    FExtr     	Bit-field value.
- */
-
-#define FExtr(Data, Field) \
-                	((UData (Data) >> FShft (Field)) & FAlnMsk (Field))
-
-
-#endif /* __BITFIELD_H */
-- 
2.20.0

