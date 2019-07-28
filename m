Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED59C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42E22077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vi4jU9Th"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfG1PdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:33:18 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:27119 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1PdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:33:18 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x6SFWd9d012823;
        Mon, 29 Jul 2019 00:32:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x6SFWd9d012823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564327960;
        bh=lco2zjYmjTJqgvnjGdaA/ghHBLIAeeXpv7O1t3+DWAY=;
        h=From:To:Cc:Subject:Date:From;
        b=vi4jU9ThyytEKltzI0Y0y0G2tQzjv2RZKUoXH8rmMh5/6reHrdLcMzRHdlTW0jvfy
         pKWANoi7MJxnPY5OzKM9DT4tcM1gash0yLtx4exMqr4epEcM/wsjcpbEcVl8/R42sV
         SXHdoCCxMGYQc3kLGkhpGOqtzQWAppaZbz48ZtpsmD/R+P213TQbhhk0srKJyHnGll
         VjR4DllpKNYvzASX0tvqPLQ0DMishjIjfxX0ZUJk5zyYHP0zyVCUU3vkEEp4YkFV6h
         qpsy9kQNnLLYykc10jyhGAxfnMLbA/Bw7q4bELvINC9B64I1COcg8Xv8ryDpPXPPvM
         Exm3tlDf0YG0w==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: timeriomem - add include guard to timeriomem-rng.h
Date:   Mon, 29 Jul 2019 00:32:36 +0900
Message-Id: <20190728153236.9937-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/timeriomem-rng.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/timeriomem-rng.h b/include/linux/timeriomem-rng.h
index fd4a6e6ec831..672df7fbf6c1 100644
--- a/include/linux/timeriomem-rng.h
+++ b/include/linux/timeriomem-rng.h
@@ -5,6 +5,9 @@
  * Copyright (c) 2009 Alexander Clouter <alex@digriz.org.uk>
  */
 
+#ifndef _LINUX_TIMERIOMEM_RNG_H
+#define _LINUX_TIMERIOMEM_RNG_H
+
 struct timeriomem_rng_data {
 	void __iomem		*address;
 
@@ -14,3 +17,5 @@ struct timeriomem_rng_data {
 	/* bits of entropy per 1024 bits read */
 	unsigned int		quality;
 };
+
+#endif /* _LINUX_TIMERIOMEM_RNG_H */
-- 
2.17.1

