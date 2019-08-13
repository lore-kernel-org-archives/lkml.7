Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB69C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16BB21721
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565700479;
	bh=ilqdbBkmC8mviANEBAHJR8WnhkGo3fc+YhnzggL1Lh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X69a7PIai7E0TXQjUesiPxcQJcpPtMn2KVV7DrZVBqRq5Ou4wJ8bVZ50H8FPpD4YI
	 ArswFEhZjfRInEQukGxo/TI0me2/RFUSSNNrYwrVGLrjz18F59sdC0YTBCeUoaBJzv
	 58eSbKTG9zasPxdIDLbibg5HOf9OP+m3t5f8PV+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfHMMr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbfHMMr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:47:56 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A517216F4;
        Tue, 13 Aug 2019 12:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565700475;
        bh=ilqdbBkmC8mviANEBAHJR8WnhkGo3fc+YhnzggL1Lh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nf6SxuXehUmubL2ek/KGJ6mdvZN4mizTKzEoe2qYpYt1t0VPRC4TlejEuoEH4RR/X
         RdEwInJ8jnhdOmVqxq5PHi3fZ11d8GWg9u1aWLkPmIMtlKLIBV9fIA6FOILjcvlhzQ
         AGhUrEkbTvQWiCN9uMVjWFJI391fBuZXwfMVo7SM=
From:   Maxime Ripard <mripard@kernel.org>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4/5] ARM: dts: sun8i: a83t: Remove the watchdog clock
Date:   Tue, 13 Aug 2019 14:47:43 +0200
Message-Id: <20190813124744.32614-4-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813124744.32614-1-mripard@kernel.org>
References: <20190813124744.32614-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The watchdog binding doesn't define a clock, and it indeed looks like
there's no explicit clock feeding it.

Let's remove it from our DT.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 523be6611c50..15f8c80f69a5 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -817,7 +817,6 @@
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&osc24M>;
 		};
 
 		spdif: spdif@1c21000 {
-- 
2.21.0

