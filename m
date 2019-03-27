Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DE1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F522075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="aLYCmoev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732821AbfC0A1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:27:39 -0400
Received: from vps.xff.cz ([195.181.215.36]:53792 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732429AbfC0A1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553645935; bh=/nOga8bOYXjgFoiwANB3x24IlAmM6uUBGPD5umeU/zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLYCmoev6V5jEI/5KnXTFqW/BqHzLiFf14MwjFdAhSsbwl9urNkN7Ym+m6JZlkiJ1
         L8cfVAS4erhtjT1XDXrTKXxukWmsKQYRZD60wLHwCPKakAStZVBi5Dl1mDHIulj/Mx
         s3397J5enIC0BGfZdMz/x8P7EfU/KCzEo5h+NVY8=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 3/7] ARM: dts: sun8i: a83t: Add nodes for UART2-UART4
Date:   Wed, 27 Mar 2019 01:18:39 +0100
Message-Id: <20190327001843.2420-4-megous@megous.com>
In-Reply-To: <20190327001843.2420-1-megous@megous.com>
References: <20190327001843.2420-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

A83T has 5 UART interfaces, but only the first two have their nodes
defined in sun8i-a83t.dtsi. Add nodes for the missing interfaces.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index fcb7ef5ce2df..e5c39eef1c29 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -873,6 +873,39 @@
 			status = "disabled";
 		};
 
+		uart2: serial@1c28800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28800 0x400>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
+			status = "disabled";
+		};
+
+		uart3: serial@1c28c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28c00 0x400>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART3>;
+			resets = <&ccu RST_BUS_UART3>;
+			status = "disabled";
+		};
+
+		uart4: serial@1c29000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c29000 0x400>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART4>;
+			resets = <&ccu RST_BUS_UART4>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@1c2ac00 {
 			compatible = "allwinner,sun8i-a83t-i2c",
 				     "allwinner,sun6i-a31-i2c";
-- 
2.21.0

