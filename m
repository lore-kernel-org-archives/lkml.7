Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB4FFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EC921D82
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213354;
	bh=ZcfI9Io9gL+K+leh9xNl/+x3gDLhi0YCH+sL9MOr5HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AKIv5hQaf65Lccl3BLwNRX7bG0rGIuF/7rYhVA6HB3rTzsZX197jCHtLCRc1y8WvU
	 JvID0yRNXhZSRXdpP9GuPHM3bE0DJpUH7HQ1Ieacb4N/46pI9ccwIc9Gtt8ZA4UwTi
	 wkm496em3d6J95/AMqIr8rLAbnnJAUmVcA284dOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390035AbfKHLmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389945AbfKHLmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:42:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46E6F21D6C;
        Fri,  8 Nov 2019 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213344;
        bh=ZcfI9Io9gL+K+leh9xNl/+x3gDLhi0YCH+sL9MOr5HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqe/slqFj3cpUc/f4ycWtoPu9zSXOAFwrg4zOelWrsUytw7i+9LLVyKKC9hYXnFh6
         rwiIileUgjIbLhV0eZfiaCrdFDWR/ond62warRAMubNNI+rTCWupgV0pVU4qrt1F4Y
         PGwd4a820U6aGumvp6pA7k1Et6hheVgKdcyITtw4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 180/205] ARM: dts: bcm: Fix SPI bus warnings
Date:   Fri,  8 Nov 2019 06:37:27 -0500
Message-Id: <20191108113752.12502-180-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit ab0b47d2eff413d60b0a1fc0c1f87f87f0d7f375 ]

dtc has new checks for SPI buses. Fix the warnings in node names.

arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dtb: Warning (spi_bus_bridge): /axi@18000000/qspi@27200: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958525er.dtb: Warning (spi_bus_bridge): /axi/qspi@27200: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958525xmc.dtb: Warning (spi_bus_bridge): /axi/qspi@27200: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958622hr.dtb: Warning (spi_bus_bridge): /axi/qspi@27200: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958625hr.dtb: Warning (spi_bus_bridge): /axi/qspi@27200: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm988312hr.dtb: Warning (spi_bus_bridge): /axi/qspi@27200: node name for SPI buses should be 'spi'

Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm-hr2.dtsi | 2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index 3084a7c957339..e4d49731287f6 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -216,7 +216,7 @@
 			reg = <0x33000 0x14>;
 		};
 
-		qspi: qspi@27200 {
+		qspi: spi@27200 {
 			compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
 			reg = <0x027200 0x184>,
 			      <0x027000 0x124>,
diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 09ba850463228..2b219addeb449 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -273,7 +273,7 @@
 			brcm,nand-has-wp;
 		};
 
-		qspi: qspi@27200 {
+		qspi: spi@27200 {
 			compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
 			reg = <0x027200 0x184>,
 			      <0x027000 0x124>,
-- 
2.20.1

