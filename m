Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B70AC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42FF27414
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gQFdb6/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfFCQvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:51:47 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:57787 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfFCQvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:51:47 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x53GoTBY008328;
        Tue, 4 Jun 2019 01:50:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x53GoTBY008328
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559580630;
        bh=Uf6Bqw9USDMuxj3PzqazDovjCc2/XohbsDH/Cgwz43Y=;
        h=From:To:Cc:Subject:Date:From;
        b=gQFdb6/Vt3HdMh6R5JJW4MWNJEjRvuP4wPeGxL1iEJMfhT0bHqVTadtRZgzNiVrwv
         rZIWW1rhoDVsNqdEqizQga9AgRGhc4o7HTDt2xEYydpm9F0gyBQThB97tHLZxOi2ul
         aPDY+l2djP0mhEeLmeuTvraYWEIOPP3Gh77WOsZkJ5UXGDn6YsJTDrvweaSlpDYDdI
         3ciE+96nXaQ0OhLUJm3SEbLyZFsQ3xvSzXb9/36pxwWZEGiMSm1B65ReZLFy4cpQY9
         ZXeUo+PbTBUtIyA6Kx5Frb+GQA5I4w05ToFYh+OuN1RvMg0TDIUirEKcBEN14lnVzR
         A2QSe/jaiimWg==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: do not use C++ style comments in uapi header
Date:   Tue,  4 Jun 2019 01:50:27 +0900
Message-Id: <20190603165027.11831-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel tolerates C++ style comments these days. Actually, the
SPDX License Identifier for .c files uses C++ comment style.

On the other hand, uapi headers are strict, where the C++ comment
style is banned.

Looks like these lines are temporarily commented out, so I did not
use the block comment style.

Having said that, they have been commented out since the pre-git era.
(so, at least 14 years). 'Maybe later' may not happen. Alternative fix
might be to delete these lines entirely.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/linux/jffs2.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/jffs2.h b/include/uapi/linux/jffs2.h
index a18b719f49d4..5dee6d930d5b 100644
--- a/include/uapi/linux/jffs2.h
+++ b/include/uapi/linux/jffs2.h
@@ -77,10 +77,10 @@
 
 #define JFFS2_ACL_VERSION		0x0001
 
-// Maybe later...
-//#define JFFS2_NODETYPE_CHECKPOINT (JFFS2_FEATURE_RWCOMPAT_DELETE | JFFS2_NODE_ACCURATE | 3)
-//#define JFFS2_NODETYPE_OPTIONS (JFFS2_FEATURE_RWCOMPAT_COPY | JFFS2_NODE_ACCURATE | 4)
-
+/* Maybe later...
+#define JFFS2_NODETYPE_CHECKPOINT (JFFS2_FEATURE_RWCOMPAT_DELETE | JFFS2_NODE_ACCURATE | 3)
+#define JFFS2_NODETYPE_OPTIONS (JFFS2_FEATURE_RWCOMPAT_COPY | JFFS2_NODE_ACCURATE | 4)
+*/
 
 #define JFFS2_INO_FLAG_PREREAD	  1	/* Do read_inode() for this one at
 					   mount time, don't wait for it to
-- 
2.17.1

