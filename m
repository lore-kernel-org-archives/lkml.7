Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B4EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0730220693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552491710;
	bh=DjiO1uv5wtfLiCtW3MS3KigNGkKvj7KPiOgEezQR55A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=x+yxh71S6xu07vEZdh0Xk+VZoi+Bf3eqHMI2kQgp7SPuCA6QtcWm5/cMieD4T4wIc
	 f07RXD/Y/jrmffb7uNkaXpCW2Ec+0WFz1PAzbRlpU4zpTaGCc3ENrz4zqJAJ5klwJ9
	 0tDzgIjq/6yHUbQ+4pqSGNUWfquE40wbhH/lhOCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfCMPjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:39:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49536 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfCMPi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sSklwvYpb7CkD8ts0EwPQfsh9N4juLaCReWG14ueJHo=; b=tliUN8Mc3avN
        GEktNK8RvxrdejQRMnowgwNn0NxvzE0PLA+eSgCs9O0AygWO7LUUwRyaZ5pJYKbXVSwSogRlt/yIe
        pkLTXy/CnuHpHCaNiC/Vq5OBDmSG7J6HV3XWO8GstOrvPtmp8F2xHrOnpy2KyGUtGlEQVvJRk1+9y
        R3BFs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h45xk-0003Q7-11; Wed, 13 Mar 2019 15:38:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7AA7C1128B97; Wed, 13 Mar 2019 15:38:35 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: axi-i2s: make both "rx" and "tx" optional" to the asoc tree
In-Reply-To:  <20190307214456.16445-2-luca@lucaceresoli.net>
X-Patchwork-Hint: ignore
Message-Id: <20190313153835.7AA7C1128B97@debutante.sirena.org.uk>
Date:   Wed, 13 Mar 2019 15:38:35 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: axi-i2s: make both "rx" and "tx" optional

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

From fa225400758dfc7ccddebf4d990f991a435f7921 Mon Sep 17 00:00:00 2001
From: Luca Ceresoli <luca@lucaceresoli.net>
Date: Thu, 7 Mar 2019 22:44:56 +0100
Subject: [PATCH] ASoC: axi-i2s: make both "rx" and "tx" optional

Both the capture and playback channels are optional in the axi_i2s IP
block. Document how to tell the driver which channels are
instantiated.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/adi,axi-i2s.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt b/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
index 4248b662deff..229ad1392cdc 100644
--- a/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/adi,axi-i2s.txt
@@ -1,5 +1,8 @@
 ADI AXI-I2S controller
 
+The core can be generated with transmit (playback), only receive
+(capture) or both directions enabled.
+
 Required properties:
  - compatible : Must be "adi,axi-i2s-1.00.a"
  - reg : Must contain I2S core's registers location and length
@@ -9,8 +12,8 @@ Required properties:
  - clock-names : "axi" for the clock to the AXI interface, "ref" for the sample
    rate reference clock.
  - dmas: Pairs of phandle and specifier for the DMA channels that are used by
-   the core. The core expects two dma channels, one for transmit and one for
-   receive.
+   the core. The core expects two dma channels if both transmit and receive are
+   enabled, one channel otherwise.
  - dma-names : "tx" for the transmit channel, "rx" for the receive channel.
 
 For more details on the 'dma', 'dma-names', 'clock' and 'clock-names' properties
-- 
2.20.1

