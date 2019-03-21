Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB987C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890F921874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553180847;
	bh=XC4MaI5XHVme0h7Tr5iF9iPcU2MAzajEK9EYwSCrQ90=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UQhdJTHv8UICUZKP/iGr6Q6uJkSl+TeAztpUnj5u3jbRBLTTAe0tmWK8SmzzYhiep
	 q5+kNX4c0N6m1vdn33K+inNFvdzY6mKkTFCaB42B7kinuqVmBs7MIqwcItmkHCiUoS
	 jE6vVjbQ8y8wHBMP7xRpu7nyyf0Qpjhr3kRgK2hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfCUPH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:07:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47970 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfCUPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vQF6hEQLcYziz5fIkNc2Q4zninnMdbmM2iztXCEGHm8=; b=TPU//27OqgQw
        vgMBvbO9cDQMOn5FWsOftDSEhSlvqpifaNrkFWKFTr87wr9xi0vYTj7qoRJuJ50SK82Qli+alyeKS
        GF0lYTEYDSaWzcDDxM2mg/r8+BFvzOl82EGRLi/9jQt7xHxPMVCWj4Gp3gwDhj34EljyMDXvJpoVk
        Z5Loc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6zHi-0005ca-De; Thu, 21 Mar 2019 15:07:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C97CB11288EC; Thu, 21 Mar 2019 15:07:09 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: da7219: Update DAI clock binding info to cover WCLK/BCLK" to the asoc tree
In-Reply-To:  <a2e2ae888b3c2fbcaab3e4791ce98f877e3d38ff.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
X-Patchwork-Hint: ignore
Message-Id: <20190321150709.C97CB11288EC@debutante.sirena.org.uk>
Date:   Thu, 21 Mar 2019 15:07:09 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: da7219: Update DAI clock binding info to cover WCLK/BCLK

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

From 41d176d3ec147f499614adc773080f244d47e3cd Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 19 Mar 2019 17:49:30 +0000
Subject: [PATCH] ASoC: da7219: Update DAI clock binding info to cover
 WCLK/BCLK

With the need to expose WCLK and BCLK as separate clocks, the
'clock-cells' and 'clock-output-names' descriptions need to be
updated as now the codec is providing 2 clocks. The example is
also updated accordingly.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/da7219.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
index e9d0baeb94e2..add1caf26ac2 100644
--- a/Documentation/devicetree/bindings/sound/da7219.txt
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -23,8 +23,8 @@ Optional properties:
   interrupt is to be used to wake system, otherwise "irq" should be used.
 - wakeup-source: Flag to indicate this device can wake system (suspend/resume).
 
-- #clock-cells :  Should be set to '<0>', only one clock source provided;
-- clock-output-names : Name given for DAI clocks output;
+- #clock-cells :  Should be set to '<1>', two clock sources provided;
+- clock-output-names : Names given for DAI clock outputs (WCLK & BCLK);
 
 - clocks : phandle and clock specifier for codec MCLK.
 - clock-names : Clock name string for 'clocks' attribute, should be "mclk".
@@ -84,8 +84,8 @@ Example:
 		VDDMIC-supply = <&reg_audio>;
 		VDDIO-supply = <&reg_audio>;
 
-		#clock-cells = <0>;
-		clock-output-names = "dai-clks";
+		#clock-cells = <1>;
+		clock-output-names = "dai-wclk", "dai-bclk";
 
 		clocks = <&clks 201>;
 		clock-names = "mclk";
-- 
2.20.1

