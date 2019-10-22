Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB6ACA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EFC2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfJVNJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:09:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:51672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727805AbfJVNJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:09:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17528B2DE;
        Tue, 22 Oct 2019 13:09:26 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: include: remove unsued header file asm/sgi/sgi.h
Date:   Tue, 22 Oct 2019 15:09:19 +0200
Message-Id: <20191022130919.18582-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/sgi/sgi.h is unused, time to remove it.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/include/asm/sgi/sgi.h | 48 -----------------------------------------
 1 file changed, 48 deletions(-)
 delete mode 100644 arch/mips/include/asm/sgi/sgi.h

diff --git a/arch/mips/include/asm/sgi/sgi.h b/arch/mips/include/asm/sgi/sgi.h
deleted file mode 100644
index b61557151e3f..000000000000
--- a/arch/mips/include/asm/sgi/sgi.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * sgi.h: Definitions specific to SGI machines.
- *
- * Copyright (C) 1996 David S. Miller (dm@sgi.com)
- */
-#ifndef _ASM_SGI_SGI_H
-#define _ASM_SGI_SGI_H
-
-/* UP=UniProcessor MP=MultiProcessor(capable) */
-enum sgi_mach {
-	ip4,	/* R2k UP */
-	ip5,	/* R2k MP */
-	ip6,	/* R3k UP */
-	ip7,	/* R3k MP */
-	ip9,	/* R3k UP */
-	ip12,	/* R3kA UP, Indigo */
-	ip15,	/* R3kA MP */
-	ip17,	/* R4K UP */
-	ip19,	/* R4K MP */
-	ip20,	/* R4K UP, Indigo */
-	ip21,	/* R8k/TFP MP */
-	ip22,	/* R4x00 UP, Indy, Indigo2 */
-	ip25,	/* R10k MP */
-	ip26,	/* R8k/TFP UP, Indigo2 */
-	ip27,	/* R10k MP, R12k MP, R14k MP, Origin 200/2k, Onyx2 */
-	ip28,	/* R10k UP, Indigo2 Impact R10k */
-	ip30,	/* R10k MP, R12k MP, R14k MP, Octane */
-	ip32,	/* R5k UP, RM5200 UP, RM7k UP, R10k UP, R12k UP, O2 */
-	ip35,   /* R14k MP, R16k MP, Origin 300/3k, Onyx3, Fuel, Tezro */
-};
-
-extern enum sgi_mach sgimach;
-extern void sgi_sysinit(void);
-
-/* Many I/O space registers are byte sized and are contained within
- * one byte per word, specifically the MSB, this macro helps out.
- */
-#ifdef __MIPSEL__
-#define SGI_MSB(regaddr)   (regaddr)
-#else
-#define SGI_MSB(regaddr)   ((regaddr) | 0x3)
-#endif
-
-#endif /* _ASM_SGI_SGI_H */
-- 
2.16.4

