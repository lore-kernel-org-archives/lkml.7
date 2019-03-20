Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8321C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B237C21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103023;
	bh=cqQE2LMR2JSqNyxvv/+eGcBK+bmELLmTL+c5uVIrykI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dp63soVrEgsp/ZH2DyjhC//0XFKn4WusWwCjlIzLIiAoarnoXtiBegMhQiTrqCulD
	 PqSTIcuS1CuV+mDK0ZQuShPNvkOYpAVG7VheBpsb2DduQZ9L9yLnK9S4BppQHsaPYm
	 vhBQY/ByzEz9ZVqqy3WlJ/bBO4LRq19Ga2XWxFVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfCTRaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44798 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfCTRaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Fw8BejN92l3e+MSfUsXv22k7WvDn2OdFATA8waEjBs8=; b=fPBQurGg8Xy6
        t7V1yW//jW/XH9CG9R7wk3zFRvrs5mRcnF5uEReYdMsyVRzo/cqgjnPLTZEXxrO9wQjlr0Vp+4K0q
        ZQrBzvmLk0a6Qzcg7wBuLxfWRYiEfYKUlEQHuyQW7Jrzr8rfJFxNaBvoRsx2O73QUceDec/iOwEMU
        kehjo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f2Y-0001A7-O5; Wed, 20 Mar 2019 17:30:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E92E61126E4C; Wed, 20 Mar 2019 17:30:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-spi@vger.kernel.org
Subject: Applied "dt-bindings: snps,dw-apb-ssi: Add mandatory clock bindings documentation" to the spi tree
In-Reply-To:  <1553010727-23157-2-git-send-email-gareth.williams.jx@renesas.com>
X-Patchwork-Hint: ignore
Message-Id: <20190320173009.E92E61126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:30:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: snps,dw-apb-ssi: Add mandatory clock bindings documentation

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 57a9f6e7eefa697349ff4823f178fd56abe27345 Mon Sep 17 00:00:00 2001
From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 19 Mar 2019 15:52:05 +0000
Subject: [PATCH] dt-bindings: snps,dw-apb-ssi: Add mandatory clock bindings
 documentation

The Synopsys SSI driver uses a mandatory clock that is not documented,
so detail it in the device tree bindings. Also correct the spelling of
"pins" in the "Optional Properties" section for the driver.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 2864bc6b659c..bcd8f960afb9 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -8,9 +8,10 @@ Required properties:
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
+- clocks : phandle for the core clock used to generate the external SPI clock.
 
 Optional properties:
-- cs-gpios : Specifies the gpio pis to be used for chipselects.
+- cs-gpios : Specifies the gpio pins to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
   device.  Supported values are 2 or 4 (the default).
@@ -25,6 +26,7 @@ Example:
 		interrupts = <0 154 4>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&spi_m_clk>;
 		num-cs = <2>;
 		cs-gpios = <&gpio0 13 0>,
 			   <&gpio0 14 0>;
-- 
2.20.1

