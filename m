Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A027C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3291A2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421679;
	bh=fDe/LvzwDE9ROI0LUyhW0TYuI0y2n6u5PqL3kgo9f/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OplDKB6xwLoGQokEkraMybHc6ern5JXewQne/Rv57ufhAba6gBxt4JV2Zj+GnNg7s
	 QOHeAZARduvO/TVwrHwzLQdK0i3uSq+yoegQPVLunld3uyb58TXApFhF2WpcGz7MuG
	 dirzja5/vx4C3YUDGOu4wZLmAyKVomZba9fISSJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfKVLVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729457AbfKVKpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:45:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6AC720718;
        Fri, 22 Nov 2019 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419524;
        bh=fDe/LvzwDE9ROI0LUyhW0TYuI0y2n6u5PqL3kgo9f/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsji92ZjUbvPM2EHq46UHqSiM4hATNdQlbfWpRCxp3q8WcI7GGyiGeWqG+OSvexVI
         9jYQEi/g1bCTweLVvl7kWBQzYFb8UhPpsMuGSgjwwaYX0YIY1dzrUvXx8wbWfXjSdC
         kvh9D58PgBhRjvJUR85s8eqkmWd186nnxqVyZEec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chanho Min <chanho.min@lge.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 141/222] arm64: dts: lg: Fix SPI controller node names
Date:   Fri, 22 Nov 2019 11:28:01 +0100
Message-Id: <20191122100913.030520124@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 09bae3b64cb580c95329bd8d16f08f0a5cb81ec9 ]

SPI controller nodes should be named 'spi' rather than 'ssp'. Fixing the
name enables dtc SPI bus checks.

Cc: Chanho Min <chanho.min@lge.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/lg/lg1312.dtsi | 4 ++--
 arch/arm64/boot/dts/lg/lg1313.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index fbafa24cd5335..5e0c5dc973e33 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -167,14 +167,14 @@
 			clock-names = "apb_pclk";
 			status="disabled";
 		};
-		spi0: ssp@fe800000 {
+		spi0: spi@fe800000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe800000 0x1000>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
 		};
-		spi1: ssp@fe900000 {
+		spi1: spi@fe900000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe900000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index e703e1149c757..f3b1ba6f74220 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -167,14 +167,14 @@
 			clock-names = "apb_pclk";
 			status="disabled";
 		};
-		spi0: ssp@fe800000 {
+		spi0: spi@fe800000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe800000 0x1000>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_bus>;
 			clock-names = "apb_pclk";
 		};
-		spi1: ssp@fe900000 {
+		spi1: spi@fe900000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe900000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.20.1



