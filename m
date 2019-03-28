Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB78C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444872075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Qe4f+46y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfC1LcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:32:12 -0400
Received: from vps.xff.cz ([195.181.215.36]:46186 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfC1LcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553772728; bh=7ah7yOJmVLvW04TbYgFkcjKKDQ0iVawYIefigyQT1WI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qe4f+46yH6cBD3N8S6k7nLMIRRexQ8wJS6n9040lzJ0phvIjqqF7rkn0e3Z8MSxOU
         VvWrnFdYnYPGsSZvSBNONIhtH9jUSbbjOw+ywivVu6Ha6f7BBybMx5/fJDPFUdVOdK
         L/V/aJoEdONXdUw+JijMKEt0yOQU75WJMZXy2XWc=
From:   megous@megous.com
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: sun8i: a83t: Add missing CPU clock references
Date:   Thu, 28 Mar 2019 12:31:59 +0100
Message-Id: <20190328113159.9668-3-megous@megous.com>
In-Reply-To: <20190328113159.9668-1-megous@megous.com>
References: <20190328113159.9668-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

A83T DTSI has cpu clocks defined only on the first CPU in each cluster.
We can bring down any CPU in the cluster, so we need to define clock
for each CPU, so that the system knows what clock to use if the first
CPU is down.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 7a40b7d77ec0..1b0b025b9250 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -73,6 +73,8 @@
 		};
 
 		cpu@1 {
+			clocks = <&ccu CLK_C0CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -83,6 +85,8 @@
 		};
 
 		cpu@2 {
+			clocks = <&ccu CLK_C0CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -93,6 +97,8 @@
 		};
 
 		cpu@3 {
+			clocks = <&ccu CLK_C0CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -115,6 +121,8 @@
 		};
 
 		cpu@101 {
+			clocks = <&ccu CLK_C1CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
@@ -125,6 +133,8 @@
 		};
 
 		cpu@102 {
+			clocks = <&ccu CLK_C1CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
@@ -135,6 +145,8 @@
 		};
 
 		cpu@103 {
+			clocks = <&ccu CLK_C1CPUX>;
+			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
-- 
2.21.0

