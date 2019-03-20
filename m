Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AFC21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103016;
	bh=lu4BO6BChEGl9OgIbbkpKbJYPBnnhqImiw60WhuPzC0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=q0v7SPKDH5odSuDSJYChaH98nv1CVCA7q85CAN31KEQZghPyCO2XSEEhy+VfmMbi/
	 hEdOSG+fOXs6mtqreCl4tcttA+GKEblSDEzLsjfx3ho22p9GiQr7U6NlQz6hfEFVSK
	 7ECZYyV2b2n/C2NLIX6hFrk5lWh2FvoKbtIEC64k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfCTRaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44728 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfCTRaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GUhug6tar2fgq0vizwwk7pmeDsiD9N75GoOINpoOHGg=; b=n7VqrODesh+i
        UQyyVHlVFyhvZubDRkA1v64d6rkl7OqhrkIhC5xxuzFwoxg/oa3dQemsR/3crpZ1QPafCMQiIOLsX
        jqU4tsXJisKhH/hA5jjx/13nCoeuOE6H1dLE4DWuQ9tRwXkgcdcBqxCuchmnyAmzkunjekU2hZCCM
        2UV2Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f2W-00019z-98; Wed, 20 Mar 2019 17:30:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BD6281126E4C; Wed, 20 Mar 2019 17:30:07 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Applied "dt-bindings: snps,dw-apb-ssi: Add optional clock bindings documentation" to the spi tree
In-Reply-To:  <1553010727-23157-3-git-send-email-gareth.williams.jx@renesas.com>
X-Patchwork-Hint: ignore
Message-Id: <20190320173007.BD6281126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:30:07 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: snps,dw-apb-ssi: Add optional clock bindings documentation

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

From 2f324ac7cf8c50aa079cf30445b99a1b98ea2728 Mon Sep 17 00:00:00 2001
From: Gareth Williams <gareth.williams.jx@renesas.com>
Date: Tue, 19 Mar 2019 15:52:06 +0000
Subject: [PATCH] dt-bindings: snps,dw-apb-ssi: Add optional clock bindings
 documentation

Add documentation to the Synopsys SPI dt-bindings to support an
optional interface clock that may be used for register access.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index bcd8f960afb9..f54c8c36395e 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -8,9 +8,15 @@ Required properties:
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
-- clocks : phandle for the core clock used to generate the external SPI clock.
+- clocks : phandles for the clocks, see the description of clock-names below.
+   The phandle for the "ssi_clk" is required. The phandle for the "pclk" clock
+   is optional. If a single clock is specified but no clock-name, it is the
+   "ssi_clk" clock. If both clocks are listed, the "ssi_clk" must be first.
 
 Optional properties:
+- clock-names : Contains the names of the clocks:
+    "ssi_clk", for the core clock used to generate the external SPI clock.
+    "pclk", the interface clock, required for register access.
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
-- 
2.20.1

