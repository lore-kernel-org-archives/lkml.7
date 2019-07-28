Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D5C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DDC2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yhi1MR4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfG1PsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:48:00 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:63407 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1Pr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:47:59 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x6SFlYKw013667;
        Mon, 29 Jul 2019 00:47:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x6SFlYKw013667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564328854;
        bh=uQYldCyUhsL2ffOk1ckUqqzFkEWVp4rPzap8vzYi+vQ=;
        h=From:To:Cc:Subject:Date:From;
        b=yhi1MR4csP31TdvIMm31aVc8DRgL8LXLDDnOJH/3qJP/Q5clk8ef6nkKKyBEZKoPp
         lsni9j0wFlEcZCmaXu/G/jd8xRnrjepnjmlKfvMRp4/SCwVXZcEdK9ozHmzuDMyve7
         /fa00BjorZRNfdGYKU3AuRDsUcap/KwTA5b9/vSOOVUPkQsN1/L1sTO6eW2IV2hvGB
         /PMNE9AP0oLacvu0homcuFBrSzLpU8XfjScV4XkapbqeDHidAzraadGgPaNzfaO9Dj
         eb9YqOt6iRAdZgMeqkQEzPNKxUwUAo0v3E2Ur4fyepITiQWEASRzERJDhJ969YbRQg
         gwvNRIkbvGWJg==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] linux/coff.h: add include guard
Date:   Mon, 29 Jul 2019 00:47:28 +0900
Message-Id: <20190728154728.11126-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Looks like this file is unused at least in the kernel tree,
but I am not it is OK to delete it.

I am just adding the include guard for the header compile-testing.



 include/uapi/linux/coff.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/coff.h b/include/uapi/linux/coff.h
index e4a79f80b9a0..ab5c7e847eed 100644
--- a/include/uapi/linux/coff.h
+++ b/include/uapi/linux/coff.h
@@ -11,6 +11,9 @@
    more information about COFF, then O'Reilly has a very excellent book.
 */
 
+#ifndef _UAPI_LINUX_COFF_H
+#define _UAPI_LINUX_COFF_H
+
 #define  E_SYMNMLEN  8   /* Number of characters in a symbol name         */
 #define  E_FILNMLEN 14   /* Number of characters in a file name           */
 #define  E_DIMNUM    4   /* Number of array dimensions in auxiliary entry */
@@ -350,3 +353,5 @@ struct COFF_reloc {
 
 /* For new sections we haven't heard of before */
 #define COFF_DEF_SECTION_ALIGNMENT       4
+
+#endif /* _UAPI_LINUX_COFF_H */
-- 
2.17.1

