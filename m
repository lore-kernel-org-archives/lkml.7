Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7716AC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4369720843
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NcyB7YTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF0HJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:09:26 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:42802 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0HJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:09:26 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x5R77uGW006669;
        Thu, 27 Jun 2019 16:07:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x5R77uGW006669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561619277;
        bh=Me6XZe6RMVm7ORc75tTq5ObpD2opR8ehVOvWvOAsKDQ=;
        h=From:To:Cc:Subject:Date:From;
        b=NcyB7YToht5y8f6ew+RnmCn5gizrkwen96RjPfFCTQOqi4+ATTfKHCl23WW1O2uPo
         IXanyXgvCXDOYXxJ9Rm6dBCnbk4m9SmyX5KY2DnxXHOJv0SOlJCeLa9GVdSa398Svo
         0zHiLzxZHyw34702W52kp0ljjDP/6XP0wi6DBRNHZoXrBKoL5H6hz2t87CI0b6uQN3
         +6l7Gb58nplN9j1DSwvny0f0vpsL8owYXbWtmogi6CupiuLmriqIuznVjw5HtJSjk7
         QsZnkufaeC2dhSk6Hza29AD56DGnwIFNBsfBfaZrQ/e161cgnv6JgV3cqpapjN+u1q
         Qv2lqj7N0A+jA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: abi: do not use C++ style comments in uapi header
Date:   Thu, 27 Jun 2019 16:07:45 +0900
Message-Id: <20190627070745.9561-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel tolerates C++ style comments these days. Actually, the
SPDX License tags for .c files start with //.

On the other hand, uapi headers are written in more strict C, where
the C++ comment style is forbidden.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/mtd/mtd-abi.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index aff5b5e59845..47ffe3208c27 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -113,11 +113,11 @@ struct mtd_write_req {
 #define MTD_CAP_NVRAM		(MTD_WRITEABLE | MTD_BIT_WRITEABLE | MTD_NO_ERASE)
 
 /* Obsolete ECC byte placement modes (used with obsolete MEMGETOOBSEL) */
-#define MTD_NANDECC_OFF		0	// Switch off ECC (Not recommended)
-#define MTD_NANDECC_PLACE	1	// Use the given placement in the structure (YAFFS1 legacy mode)
-#define MTD_NANDECC_AUTOPLACE	2	// Use the default placement scheme
-#define MTD_NANDECC_PLACEONLY	3	// Use the given placement in the structure (Do not store ecc result on read)
-#define MTD_NANDECC_AUTOPL_USR 	4	// Use the given autoplacement scheme rather than using the default
+#define MTD_NANDECC_OFF		0	/* Switch off ECC (Not recommended) */
+#define MTD_NANDECC_PLACE	1	/* Use the given placement in the structure (YAFFS1 legacy mode) */
+#define MTD_NANDECC_AUTOPLACE	2	/* Use the default placement scheme */
+#define MTD_NANDECC_PLACEONLY	3	/* Use the given placement in the structure (Do not store ecc result on read) */
+#define MTD_NANDECC_AUTOPL_USR 	4	/* Use the given autoplacement scheme rather than using the default */
 
 /* OTP mode selection */
 #define MTD_OTP_OFF		0
-- 
2.17.1

