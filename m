Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAECCC606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AD32086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfGHMuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:50:11 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfGHMuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:50:10 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MiJEc-1iOjn82v7G-00fPdg; Mon, 08 Jul 2019 14:49:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] mtd: remove c++ comments from uapi header
Date:   Mon,  8 Jul 2019 14:49:39 +0200
Message-Id: <20190708124946.3679242-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+uOHU+4UEMIQVvG6sZZ0WG9SxeOsI22+BEimc3g+pGD2B7re0/y
 LDaqKR2IuOWj4qaciN49K2yV/BwkXGGzw2fEcb4B/VJkusXCDXCI0o4Jvf8COGeLWjtcpkX
 rN0ddo2ar0utLTm5EkXhvD+bzBHGHRFuyBdmQCs7Fo9TG4ECUyA0ISNsOhufuk51zaOR4CA
 iiIG0TvMEo/22HxZEoBcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w6QPbdb0Tmo=:BkMCVwQoKFaKbeBRhtHXJH
 AcbU8Nh+P4l4ZqIrqnKTXrus6PNlSMQWfPUjpuSPAjQRLKz45Ph02n3v8yokNTgW8FZBKtSQK
 iPLHpZPKNnB9TgBF3hBuEc3GSYV52N831Zg4Wpc/BaUXSdNdZGBHnvoivcFwDpt3KrxCIK1Hp
 z2WYG1lbYj0G/AaUBBOkE8Nw3LqSrhaIf12rY8iDfzcW+83GpaCgix6RX/rjkFOIYC8cTZEUI
 m1bJ2SChv53q0tnKLzRSLsokXfO3Ik6ZaniUkdMXe5A8s4S9xM+bEuFo4ZLdkoakc4hX8WSKH
 b9r06yCbMlUv+dFvxVhwm8tegCUslJhz004VrMbeuxtjh3+yfbth1Uc65mFv1n82mKuIqBZSA
 1diHk3ZJDZuqxSK9pPlPTBf92iyj7jycyrYX9UhmoH6mbkhBAU3ldpGQNV+YV7yHgzDCdFtAg
 cPQlXfC5qkqwB72n7ndLj884P2Le/dkeD8K1qoXHQXiNanxGCbn2kW8Kkk/gNeZZeuFRby7uB
 Ww8z95kzX2JJpJ6HmIT6w3TJADjQt19tWwP1g8PrsJCYX/IyXqq5dJEWWkRDODeQFtThQkVy1
 aJnnXiB4emR+DctDntBUNj1lkWJ5hMjpaqyGbcRSTgnkBJjJ2IlUWxRr4gYBDutJFAuH1GZ9j
 LJlrLat+jQLCbZpLgj0qJwRN63GqMFRkM/TdwkLe5f/+rnolWa+v/1vTWAgq4+68GrXAXY5Bs
 MbkiuvX3I1IB926e16ysoVBPezIKSJrE0BOuQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking the uapi headers now produces a warning with clang:

./usr/include/mtd/mtd-abi.h:116:28: error: // comments are not allowed in this language [-Werror,-Wcomment]

Change these into standard C comments here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.20.0

