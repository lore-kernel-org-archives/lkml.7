Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C4EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903562087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="NJXaO7Ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfC0AZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:25:11 -0400
Received: from vps.xff.cz ([195.181.215.36]:53646 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731159AbfC0AZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553646307; bh=BvNeqUs9hKJFrBRXRuyMj6CRS9tzzF8nDPi9WShJ2lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NJXaO7MlGQHwaOjnRpYa6/AnhteoX1UKIA5KsJuYFtzfXbxWl4u6VgejAiTt8sgqT
         4mh12gJ6rwIJIjLv3DhCKgqpEGQIuTU4/ocxr6fbhCqKjJTi1nyQtwnK6Lgpt6WCR2
         mV1/Nnc/FAIFAv/jmZ/w68GGFgIZUfFtpTdY10kE=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        mark.rutland@arm.com
Cc:     Ziping Chen <techping.chan@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 3/4] ARM: dts: sunxi: Add R_LRADC support for A83T
Date:   Wed, 27 Mar 2019 01:25:00 +0100
Message-Id: <20190327002501.4630-4-megous@megous.com>
In-Reply-To: <20190327002501.4630-1-megous@megous.com>
References: <20190327002501.4630-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ziping Chen <techping.chan@gmail.com>

Allwinner A83T SoC has a low res adc like the one in Allwinner A10 SoC.
Now the driver has been modified to support it.

Add support for it.

Signed-off-by: Ziping Chen <techping.chan@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index fcb7ef5ce2df..de1b77e49f06 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -1024,6 +1024,13 @@
 			status = "disabled";
 		};
 
+		r_lradc: lradc@1f03c00 {
+			compatible = "allwinner,sun8i-a83t-r-lradc";
+			reg = <0x01f03c00 0x100>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-a83t-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-- 
2.21.0

