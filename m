Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B5C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB10206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564572618;
	bh=YkVb1GAtKmaGeHxMNXEjyO/GFCnp31r2TMuT24xpYMY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=rwixoW14giJzUy3B7gCbQmW+dehP7t/4eO9hDL9uCqsGXeroahD0Wdmsn0HlTy5Q+
	 n6omyNhr04ysWOGS8dw5oVf9VIwawKkB+8Vehur9fzmnZktAB2IAvpmcfU12f2wCat
	 Hu5HWr4GCNxeQKEHjMLJIm5mZ8uOjtBO2incK5mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfGaLaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:30:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35268 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387667AbfGaLaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eSeBCzNpKMCOFoL5FPkI5ImNoBEwwAZgfAmRy9oJTNY=; b=Eyu1a2+I0iZ8
        M/Px0Z8w63HNmsjKCwsxc7YzBUqdl/vh0hrvb9MUOBC6fSj328PFbmsdawyVBlTx1mGdM2CC3QnGZ
        pLnQ1vXJmA7C8Z3oJ2tfexly3pXPdSyhE+COszNJMCFEbh0+2+S3pWaEha4TSU5I31jSB79UGdrmJ
        cTRm4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsmnb-0001ks-5Z; Wed, 31 Jul 2019 11:29:39 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3BF792742CC3; Wed, 31 Jul 2019 12:29:38 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Andra Danciu <andradanciu1997@gmail.com>
Cc:     alsa-devel@alsa-project.org, anders.roxell@linaro.org,
        broonie@kernel.org, ckeepax@opensource.cirrus.com,
        Daniel Baluta <daniel.baluta@nxp.com>, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, jbrunet@baylibre.com,
        kmarinushkin@birdec.tech, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, m.felsch@pengutronix.de, nh6z@nh6z.net,
        paul@crapouillou.net, perex@perex.cz, piotrs@opensource.cirrus.com,
        rf@opensource.wolfsonmicro.com, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org, tiwai@suse.com, vkoul@kernel.org
Subject: Applied "dt-bindings: sound: Add bindings for UDA1334 codec" to the asoc tree
In-Reply-To: <20190731111930.20230-2-andradanciu1997@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190731112938.3BF792742CC3@ypsilon.sirena.org.uk>
Date:   Wed, 31 Jul 2019 12:29:38 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: sound: Add bindings for UDA1334 codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From d6de65fde51644f6ed6b1c0c05fef6a2da5ff768 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Wed, 31 Jul 2019 14:19:29 +0300
Subject: [PATCH] dt-bindings: sound: Add bindings for UDA1334 codec

The UDA1334 is an NXP audio codec, supports the I2S-bus data format
and has basic features such as de-emphasis (at 44.1 kHz sampling
rate) and mute. Product information can be found at:
https://www.nxp.com/pages/low-power-audio-dac-with-pll:UDA1334

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Link: https://lore.kernel.org/r/20190731111930.20230-2-andradanciu1997@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/uda1334.txt       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/uda1334.txt

diff --git a/Documentation/devicetree/bindings/sound/uda1334.txt b/Documentation/devicetree/bindings/sound/uda1334.txt
new file mode 100644
index 000000000000..f64071b25e8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/uda1334.txt
@@ -0,0 +1,17 @@
+UDA1334 audio CODEC
+
+This device uses simple GPIO pins for controlling codec settings.
+
+Required properties:
+
+  - compatible : "nxp,uda1334"
+  - nxp,mute-gpios: a GPIO spec for the MUTE pin.
+  - nxp,deemph-gpios: a GPIO spec for the De-emphasis pin
+
+Example:
+
+uda1334: audio-codec {
+	compatible = "nxp,uda1334";
+	nxp,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+	nxp,deemph-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
+};
-- 
2.20.1

