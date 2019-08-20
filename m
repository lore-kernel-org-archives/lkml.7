Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D56C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2EC22CEC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fHzUBb+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfHTDF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:05:57 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:36364 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfHTDF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:05:56 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x7K35c9U027374;
        Tue, 20 Aug 2019 12:05:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x7K35c9U027374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566270338;
        bh=hUc7u0G1bgMkSpBepaRGYH9x/xXyTceEFgxsY4bgPMs=;
        h=From:To:Cc:Subject:Date:From;
        b=fHzUBb+nkDmt+C7JxdvX8bFiDexuQOPuQBWD5AFdTWjjabqO7V3fgvzzc7ZL/z5gG
         doeFj7NEwvHxCagcEBvWqbVX4qDshpjUUd/Ew9TBJzHO61by6v9uQu/n/PuYdtGB8I
         U4JOC467jgoQwYGsndSZuSj+9bXGVJOg8NzbMtI3DcUO2fCrEtGwQWtYd8DwHNj78G
         3Pgc4zgYhfJB+v/Aj+wOpyk42GAq7F3BEo9a0O+YGtuyNNBe15Oq54aXrnGuSH9mT+
         26JfUwg0g9Yma7c/jEVLWouDSbX6Uk+mpPu41JWZYykdl49khcm3voYo9HpPSLfxgV
         h+zbmB3G3A90Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: add include guard to clk-conf.h
Date:   Tue, 20 Aug 2019 12:05:36 +0900
Message-Id: <20190820030536.1181-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/clk/clk-conf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/clk/clk-conf.h b/include/linux/clk/clk-conf.h
index 85f8cf9d1226..eae9652c70cd 100644
--- a/include/linux/clk/clk-conf.h
+++ b/include/linux/clk/clk-conf.h
@@ -4,6 +4,9 @@
  * Sylwester Nawrocki <s.nawrocki@samsung.com>
  */
 
+#ifndef __CLK_CONF_H
+#define __CLK_CONF_H
+
 #include <linux/types.h>
 
 struct device_node;
@@ -17,3 +20,5 @@ static inline int of_clk_set_defaults(struct device_node *node,
 	return 0;
 }
 #endif
+
+#endif /* __CLK_CONF_H */
-- 
2.17.1

