Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA040C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FC72075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="xvzY3e07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCSOFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:05:45 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56104 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfCSOFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553004342; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=w0S1Z5JBMZBQar4VEA8wxc7irJ+4Myw7wAVQu7j0DDM=;
        b=xvzY3e07Okt9pdeNT4MYAh5xH8fBopBc7hLEvmL3YVnvP4HwZAf57pCeHCLKz71I4KwPBl
        fXUKURrdHvdDY4MX9xHaVwGN4tA2zIZ5x/p2d8YuIU4RoFfzCReYPCmf7UkwaO2H/w7iaL
        7AhLUAMz5nB4xLL2FYqaF78L4SFrQZg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] dt-bindings: clock: jz4725b-cgu: Add UDC PHY clock
Date:   Tue, 19 Mar 2019 15:05:35 +0100
Message-Id: <20190319140536.27945-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro for the UDC PHY clock of the JZ4725B.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 include/dt-bindings/clock/jz4725b-cgu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/jz4725b-cgu.h b/include/dt-bindings/clock/jz4725b-cgu.h
index 460bbeff6ab8..31f1ab0fe42c 100644
--- a/include/dt-bindings/clock/jz4725b-cgu.h
+++ b/include/dt-bindings/clock/jz4725b-cgu.h
@@ -31,5 +31,6 @@
 #define JZ4725B_CLK_TCU		22
 #define JZ4725B_CLK_EXT512	23
 #define JZ4725B_CLK_RTC		24
+#define JZ4725B_CLK_UDC_PHY	25
 
 #endif /* __DT_BINDINGS_CLOCK_JZ4725B_CGU_H__ */
-- 
2.11.0

