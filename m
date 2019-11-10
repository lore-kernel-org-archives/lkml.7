Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817ECC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEA221783
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355654;
	bh=XPxPE1qZQJ1Y0fI2f8ZMRJh22vddh15YP8MIS/si918=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JDI2VxXKacAmoZs9FRL74ycby09BByNo08+4fLWszAwvOq5XQ8Ws3Ii3GsLMgx7p1
	 qKPExngPmMq8uL//4RftZrB1noyJgN/s77kUqPSJNBSV91LZcbEm2tawi1aZXTTQJ6
	 eED4tcAw41jUBKjI2GXVqtuhSYlzqDPBnW4HAHy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfKJDOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbfKJCmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:42:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E575A21655;
        Sun, 10 Nov 2019 02:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353752;
        bh=XPxPE1qZQJ1Y0fI2f8ZMRJh22vddh15YP8MIS/si918=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSygapK6xtyA6IGVckfFoAnOgNMXaUqo3b+/elGSmuURKQu/XttJj34e5KVWeSFpC
         /+Gr+/OVkD1RhD3raWf+vekf3yPg7Mgv3YkvszdzCQ2Ike0zONPhAJQse/7L4lg4e8
         sPvAz40BWsphG1/n7xG7i6lxFlXSuYJnMzrXUhb8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 068/191] ARM: dts: ste: Fix SPI controller node names
Date:   Sat,  9 Nov 2019 21:38:10 -0500
Message-Id: <20191110024013.29782-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 2f967f9e9fa076affb711da1a8389b5d33814fc6 ]

SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
name enables dtc SPI bus checks.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi     | 4 ++--
 arch/arm/boot/dts/ste-hrefprev60.dtsi | 2 +-
 arch/arm/boot/dts/ste-snowball.dts    | 2 +-
 arch/arm/boot/dts/ste-u300.dts        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 3dc0028e108b3..986767735e249 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -878,7 +878,7 @@
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
-		ssp@80002000 {
+		spi@80002000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80002000 0x1000>;
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -892,7 +892,7 @@
 			power-domains = <&pm_domains DOMAIN_VAPE>;
 		};
 
-		ssp@80003000 {
+		spi@80003000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x80003000 0x1000>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index 3f14b4df69b4e..94eeb7f1c9478 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -57,7 +57,7 @@
 			};
 		};
 
-		ssp@80002000 {
+		spi@80002000 {
 			/*
 			 * On the first generation boards, this SSP/SPI port was connected
 			 * to the AB8500.
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index b0b94d0530985..603890461ae0f 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -376,7 +376,7 @@
 			pinctrl-1 = <&i2c3_sleep_mode>;
 		};
 
-		ssp@80002000 {
+		spi@80002000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&ssp0_snowball_mode>;
 		};
diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 62ecb6a2fa39e..1bd1aba3322f1 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -442,7 +442,7 @@
 			dma-names = "rx";
 		};
 
-		spi: ssp@c0006000 {
+		spi: spi@c0006000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0xc0006000 0x1000>;
 			interrupt-parent = <&vica>;
-- 
2.20.1

