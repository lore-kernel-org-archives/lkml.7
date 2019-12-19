Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83AEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6AA227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="uD+xPxmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLSNME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:12:04 -0500
Received: from mail2.skidata.com ([91.230.2.91]:1919 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfLSNMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:12:03 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Dec 2019 08:12:01 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1576761121; x=1608297121;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hpGpnei3YuU55LYgQE+yfJBdpW21E9D9/s47zz+iJAM=;
  b=uD+xPxmkyM49ckkXbRED6mBuSjpOsyzupwQMU7QEEDmeQMEbn/y24zuX
   K8fxbRX5tV4oP+m6E6WixManbpimg8eqOI2+3ck1N6S/i8DJ6nHreMjLY
   ixUJ5OdjyizkrXFx4xVzXzONK/KNemrgdIsQwSkTRn23wolidtxb97EW6
   caC6B1iDvgRxUVXeCXqtglzepFlmLmdJsIKgPmNOZU7oPh2mUEvEZMl32
   mfsq34Qdd/pdlyCv2wEWKf0D43oaLa4xpd3btIiK3QqTMw9ARn9TvTnXc
   0CfTk6mkDiO4X3rfSUtr/UubO7T0CgMjGGNglqlu4ozOU7DUOe21I0nQh
   Q==;
IronPort-SDR: w+2/yQT+N2QjYg6FunUrwibsU+/63Ewts5//AkTANTRgrePIaX7w1+ciRBr6sB+f4PoGJ05Vl9
 3SM0m9zvcBPGbi61NnQlfWT2Sh9G63bYjYJxj6LRtRvsYp62XBNraYEBMq0166UnFUo11hUKtG
 Ph2oiHAZHTYAmQd1sYX/NNdmRaB/irJJV08+WrAgRqWdMKGnsp66J3tT2PGKPfBZLS2KSyholb
 UlJ9L2pkREVG1n+lKnoDQXJLqPZxeyw0+0hB7ZD3AHDEo3e+jqNzG/fWJcuP4RCxDbu1JCZcNY
 Y5Q=
X-IronPort-AV: E=Sophos;i="5.69,332,1571695200"; 
   d="scan'208";a="2466933"
From:   Richard Leitner <richard.leitner@skidata.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 1/2] ARM: dts: tegra20: add labels to i2c nodes
Date:   Thu, 19 Dec 2019 14:04:30 +0100
Message-ID: <20191219130431.30458-1-richard.leitner@skidata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex4srv.skidata.net (192.168.111.82) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add numbered labels to the i2c nodes of the Tegra20 SoC so we just need
to alias it from derived boards.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9c58e7fcf5c0..e02f75757a7e 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -464,7 +464,7 @@
 		clocks = <&tegra_car TEGRA20_CLK_RTC>;
 	};
 
-	i2c@7000c000 {
+	i2c1: i2c@7000c000 {
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -494,7 +494,7 @@
 		status = "disabled";
 	};
 
-	i2c@7000c400 {
+	i2c2: i2c@7000c400 {
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000c400 0x100>;
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -510,7 +510,7 @@
 		status = "disabled";
 	};
 
-	i2c@7000c500 {
+	i2c3: i2c@7000c500 {
 		compatible = "nvidia,tegra20-i2c";
 		reg = <0x7000c500 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.21.0

