Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C15C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B1A21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553180813;
	bh=qSRDGnLuxAPD25/0y+xaXCYWNbF2FPjOaa0aW3VTPaY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EMZTBnWEHb3VppRwHo+dmNk5iNlprQE5LOyDgGqOGSv2QGvZC4XE/YXjy2VIpvdZS
	 eY5IwnL7A/oMtuApHx+yd0yFB5AFe2Te3PK7iXuwJdxsgcviRTpGxnYXmoRXD+DiZj
	 MZHgJ+dPESAv2YgVZDBkFY4CNpnroV65BpGwWdjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfCUPGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:06:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46940 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfCUPGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lMejGMHO09WdudP4feu/DRcShUbli23XqeoF/IsZeKM=; b=TPrL5G5WLVjt
        ck0gfGi1hN2o2fyOdQeahHLdvvNZb6bJa8yL1KeafBMlm6CElCuC0W+LD9uCve4gMCQyOHyAvLjBl
        HJHrkB8eZQ+nU6dyoEnkYmkiu5LdYAHkGfhWMJcmJSGTBQu7LkptfESsTWye5TU1g6Yo0kFShfSoN
        vhCsQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6zHI-0005b5-3T; Thu, 21 Mar 2019 15:06:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 92D1B11288EC; Thu, 21 Mar 2019 15:06:43 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        alexandre.belloni@bootlin.com, Nicolas.Ferre@microchip.com,
        robh+dt@kernel.org, Ludovic.Desroches@microchip.com,
        broonie@kernel.org, Codrin.Ciubotariu@microchip.com,
        Cristian.Birsan@microchip.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: mchp-i2s-mcc: dt-bindings: add DT bindings for I2S Multi-Channel Controller" to the asoc tree
In-Reply-To:  <20190305112610.9641-1-codrin.ciubotariu@microchip.com>
X-Patchwork-Hint: ignore
Message-Id: <20190321150643.92D1B11288EC@debutante.sirena.org.uk>
Date:   Thu, 21 Mar 2019 15:06:43 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mchp-i2s-mcc: dt-bindings: add DT bindings for I2S Multi-Channel Controller

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 4c798984c0dcd7649a6ff8a3d64361ba896efe61 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Tue, 5 Mar 2019 11:26:42 +0000
Subject: [PATCH] ASoC: mchp-i2s-mcc: dt-bindings: add DT bindings for I2S
 Multi-Channel Controller

This patch adds DT bindings for the new Microchip I2S Multi-Channel
controller embedded inside sam9x60 SoCs.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/mchp-i2s-mcc.txt           | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt

diff --git a/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
new file mode 100644
index 000000000000..91ec83a6faed
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mchp-i2s-mcc.txt
@@ -0,0 +1,43 @@
+* Microchip I2S Multi-Channel Controller
+
+Required properties:
+- compatible:     Should be "microchip,sam9x60-i2smcc".
+- reg:            Should be the physical base address of the controller and the
+                  length of memory mapped region.
+- interrupts:     Should contain the interrupt for the controller.
+- dmas:           Should be one per channel name listed in the dma-names property,
+                  as described in atmel-dma.txt and dma.txt files.
+- dma-names:      Identifier string for each DMA request line in the dmas property.
+		  Two dmas have to be defined, "tx" and "rx".
+- clocks:         Must contain an entry for each entry in clock-names.
+                  Please refer to clock-bindings.txt.
+- clock-names:    Should be one of each entry matching the clocks phandles list:
+                  - "pclk" (peripheral clock) Required.
+                  - "gclk" (generated clock) Optional (1).
+
+Optional properties:
+- pinctrl-0:      Should specify pin control groups used for this controller.
+- princtrl-names: Should contain only one value - "default".
+
+
+(1) : Only the peripheral clock is required. The generated clock is optional
+      and should be set mostly when Master Mode is required.
+
+Example:
+
+	i2s@f001c000 {
+		compatible = "microchip,sam9x60-i2smcc";
+		reg = <0xf001c000 0x100>;
+		interrupts = <34 IRQ_TYPE_LEVEL_HIGH 7>;
+		dmas = <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(36))>,
+		       <&dma0
+			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+			 AT91_XDMAC_DT_PERID(37))>;
+		dma-names = "tx", "rx";
+		clocks = <&i2s_clk>, <&i2s_gclk>;
+		clock-names = "pclk", "gclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2s_default>;
+	};
-- 
2.20.1

