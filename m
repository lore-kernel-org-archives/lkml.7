Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73577C76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 11:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494002084D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 11:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="o/4Pg1Be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfGTL7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 07:59:20 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:23497 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfGTL7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 07:59:20 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x6KBx4Gd028252;
        Sat, 20 Jul 2019 20:59:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6KBx4Gd028252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563623945;
        bh=GFDvRP9bqIHxNECOxKtmvkjwLEmjaFRIEJAa+wgV2uw=;
        h=From:To:Cc:Subject:Date:From;
        b=o/4Pg1Be2urdgK4+mEqW1SNA66LavvsYpb1uRoQeNZSs1WY6HrkhYpRSYGgwTyFaj
         b2cQLNWnXbN0ZFNg/x9Nr9Mb2zRH8I80NiQMkSnu/2E/aIkO2VCOfkilfXZ2MDPmvV
         4Nq3gIxhpBUWKPMcSpcIW7GZcVI1bw30FzUtraRBQi+faYeBSWfdUCe7zaAuuj4aHn
         DbaD18nuD5weeZCLNVO+8IkuJDLDSwNwJKwL6iUm0K7HkpuGDq1zXFNBmP76syPN7i
         cqS9SKuk1Arv+TO2mVhFF3KiOIWv0ZUjGyEkU1OAAwKLdKrWv0TO7Hm2AR0E93rS3R
         lzb+iT1bShJsw==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: pinctrl-single: add header include guard
Date:   Sat, 20 Jul 2019 20:58:58 +0900
Message-Id: <20190720115858.7015-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/platform_data/pinctrl-single.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/platform_data/pinctrl-single.h b/include/linux/platform_data/pinctrl-single.h
index 1cf36fdf9510..7473d3c4cabf 100644
--- a/include/linux/platform_data/pinctrl-single.h
+++ b/include/linux/platform_data/pinctrl-single.h
@@ -1,4 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _PINCTRL_SINGLE_H
+#define _PINCTRL_SINGLE_H
+
 /**
  * irq:		optional wake-up interrupt
  * rearm:	optional soc specific rearm function
@@ -11,3 +15,5 @@ struct pcs_pdata {
 	int irq;
 	void (*rearm)(void);
 };
+
+#endif /* _PINCTRL_SINGLE_H */
-- 
2.17.1

