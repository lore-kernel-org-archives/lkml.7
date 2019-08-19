Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BF9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5425D22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566238863;
	bh=DR8UW12UvXBzHziBJM5O1282RrrigPgwf72SVgezW2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SwfVwajuIP8VSEzlmNqqZZL+5/bpzK6OXPai67Q0eADptHzP86fp5YfxG99XL+l4R
	 H1c8oLiF0uofJobOjzEVRB4cxFNTFQ9sWU54fB4gGvSpve0o0h36XsjsReL5VOuexx
	 BoaPvKwPUilBy8kVg5HLFCu5P0OIHQpukHFffuSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfHSSVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbfHSSVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:21:01 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0810522D37;
        Mon, 19 Aug 2019 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566238859;
        bh=DR8UW12UvXBzHziBJM5O1282RrrigPgwf72SVgezW2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APxCLNujF1cl6IRg77iOPwcEBrRWDhA1AlGn5HPcT3nR3TMDi51KAWiQEypXizr16
         XdqAHyKpxi03Pam8iZFvhdce//zlCmT7sDya9ybQMQZjZTQ8M0wimh6LILrMlJH2ZF
         U/9gHB5F3/b7kSs1AtoMsAdg3hJZlb/NEDGrPuqo=
From:   Maxime Ripard <mripard@kernel.org>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 6/6] ARM: dts: sunxi: Add missing watchdog clocks
Date:   Mon, 19 Aug 2019 20:20:39 +0200
Message-Id: <20190819182039.24892-6-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819182039.24892-1-mripard@kernel.org>
References: <20190819182039.24892-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The watchdog has a clock on all our SoCs, but it wasn't always listed.
Add it to the devicetree where it's missing.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

---

Changes from v1:
  - New patch
---
 arch/arm/boot/dts/sun4i-a10.dtsi              | 1 +
 arch/arm/boot/dts/sun5i.dtsi                  | 1 +
 arch/arm/boot/dts/sun6i-a31.dtsi              | 1 +
 arch/arm/boot/dts/sun7i-a20.dtsi              | 1 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi          | 1 +
 arch/arm/boot/dts/sun8i-r40.dtsi              | 1 +
 arch/arm/boot/dts/sun8i-v3s.dtsi              | 1 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 2 ++
 10 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index eed9fcb46185..ce823c44e98a 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -816,6 +816,7 @@
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 			interrupts = <24>;
+			clocks = <&osc24M>;
 		};
 
 		rtc: rtc@1c20d00 {
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 29a825f7afd1..cfb1efc8828c 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -601,6 +601,7 @@
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 			interrupts = <24>;
+			clocks = <&osc24M>;
 		};
 
 		ir0: ir@1c21800 {
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index b32d2d7cad4e..72282fd6c2d0 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -745,6 +745,7 @@
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
 		};
 
 		spdif: spdif@1c21000 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index aeb682e757f2..02fad11c125e 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1116,6 +1116,7 @@
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
 		};
 
 		rtc: rtc@1c20d00 {
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 954489b4ec66..52eed0ae3607 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -452,6 +452,7 @@
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
 		};
 
 		pwm: pwm@1c21400 {
diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index f1be554b5894..bde068111b85 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -405,6 +405,7 @@
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
 			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
 		};
 
 		uart0: serial@1c28000 {
diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index ddbcc28dc541..23ba56df38f7 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -339,6 +339,7 @@
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
 		};
 
 		lradc: lradc@1c22800 {
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 224e105a994a..eba190b3f9de 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -574,6 +574,7 @@
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
 		};
 
 		spdif: spdif@1c21000 {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index ddb6f11e89df..69128a6dfc46 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1169,6 +1169,7 @@
 				     "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index e8bed58e7246..78e5b9e97c52 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -225,6 +225,7 @@
 				     "allwinner,sun6i-a31-wdt";
 			reg = <0x030090a0 0x20>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
 			/* Broken on some H6 boards */
 			status = "disabled";
 		};
@@ -648,6 +649,7 @@
 				     "allwinner,sun6i-a31-wdt";
 			reg = <0x07020400 0x20>;
 			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
 		};
 
 		r_intc: interrupt-controller@7021000 {
-- 
2.21.0

