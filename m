Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14532C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D813022CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PZQOyz0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfHTCwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:52:08 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:62242 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfHTCwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:52:08 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x7K2p1bO009142;
        Tue, 20 Aug 2019 11:51:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x7K2p1bO009142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566269461;
        bh=dXr0OgerpGLpvO15fBQbFtGCHaWopa8Rn3l0Gbo/i5U=;
        h=From:To:Cc:Subject:Date:From;
        b=PZQOyz0KV8kIUbenMN0QGsc5QzpgcSbzrYQJgi3rvJgAI1X5WtebmLdUmFcBW4HTA
         /nVtTWOQwjEnn9BNuqvNRJ0Zs62UeJuyje7jUK1h6G9yWygiKfcHACxepb88ICSKgl
         7yyDbjjTpsf18Q6wBRt8rCrXmOO5mHTmac8vVvLUNb5vaO8vCKCS3CROVIPa2X6+gq
         oLmrY2iI4t1J17OhC86imoM/pmIw1deaN7WuoFHK7otZn7227+rDuhPoAX3xYffXUa
         Kpo6iQWWdNrqhZOQDMPVj+QpE+oLFQoVNpg8IQAZnMPq6MIwNCwm3u4Wtuqwd0A6vW
         uA9hCosFTCo/w==
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
Subject: [PATCH] mtd: rawnand: sharpsl: add include guard to linux/mtd/sharpsl.h
Date:   Tue, 20 Aug 2019 11:50:57 +0900
Message-Id: <20190820025057.16164-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/mtd/sharpsl.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
index 01306ebe266d..d2c3cf29e0d1 100644
--- a/include/linux/mtd/sharpsl.h
+++ b/include/linux/mtd/sharpsl.h
@@ -5,6 +5,9 @@
  * Copyright (C) 2008 Dmitry Baryshkov
  */
 
+#ifndef _MTD_SHARPSL_H
+#define _MTD_SHARPSL_H
+
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
@@ -16,3 +19,5 @@ struct sharpsl_nand_platform_data {
 	unsigned int		nr_partitions;
 	const char *const	*part_parsers;
 };
+
+#endif /* _MTD_SHARPSL_H */
-- 
2.17.1

