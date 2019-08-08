Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2CBC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFC421743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MTDhtmMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404461AbfHHRbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:31:20 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:25037 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404419AbfHHRbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:31:16 -0400
Received: from grover.flets-west.jp (softbank126125143222.bbtec.net [126.125.143.222]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x78HUVVE014684;
        Fri, 9 Aug 2019 02:30:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x78HUVVE014684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565285433;
        bh=t3fsOOJG3DpN9ajEKSIklFwpAIHkAiyneGUffpd+6vU=;
        h=From:To:Cc:Subject:Date:From;
        b=MTDhtmMku36n7Xrx053DIT6AbYdQypVskwm0mozWesriPFm0Q9Q2H1WXCungXveTK
         hJ+omcc/FyIk6ZIEtT/TMqKhU9ysTsLAUhBUcsHo/d3S3Xlf4gg3FO3xOegt/vLYHo
         SmnBksH+jj6iW43Fm0X8/qck9WDkNAXcLhTMlvg/3AdIUuRoOU8M1khX5j2SAIe6QD
         qG08x2p1OFfM5MC8h0/gX7WIhP365p18FqM9qXXeaUx2X9FOx6DXxZl2AE9le03ZQG
         lCzX9yJFVy6TiTZTSgjkL4FXzB60DEUGk8R91S7s0GMjY+bj19yXq1GOOHgjq9ulpb
         hOCoeJDmc2xUA==
X-Nifty-SrcIP: [126.125.143.222]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nds32: remove unneeded clean-files for DTB
Date:   Fri,  9 Aug 2019 02:30:28 +0900
Message-Id: <20190808173028.1930-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patterns are cleaned-up by the top-level Makefile

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/nds32/boot/dts/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/nds32/boot/dts/Makefile b/arch/nds32/boot/dts/Makefile
index fff8ade7a84f..f84bd529b6fd 100644
--- a/arch/nds32/boot/dts/Makefile
+++ b/arch/nds32/boot/dts/Makefile
@@ -5,5 +5,3 @@ else
 BUILTIN_DTB :=
 endif
 obj-$(CONFIG_OF) += $(BUILTIN_DTB)
-
-clean-files := *.dtb *.dtb.S
-- 
2.17.1

