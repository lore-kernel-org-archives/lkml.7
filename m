Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A46C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A24214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574270292;
	bh=Bbd8UMMg17AlESakh3vvE5yjDkRzqTzoujt9qIOWDm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=HqBLOL8eeodimbTK/c0ww+63VZOPup2q+GtMyCG0Amwy0BTEj/GEKg7zmPawYvTLf
	 pS9qOr4uXIKs8NYmer7ROctBBJ5Mb28a4mfjdoHp19Lj5itIi+6bZ0IZRmXws1PeQP
	 9f+2YhBDlPhwcWfKOdK5d3L8gewHg1aCVldSb0zE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfKTRSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:18:10 -0500
Received: from foss.arm.com ([217.140.110.172]:43308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730176AbfKTRSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:18:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C2AD1063;
        Wed, 20 Nov 2019 09:18:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF07A3F703;
        Wed, 20 Nov 2019 09:18:08 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:18:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, kuninori.morimoto.gx@renesas.com,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        robh+dt@kernel.org
Subject: Applied "ASoC: dt-bindings: pcm3168a: Update the optional RST gpio for clarity" to the asoc tree
In-Reply-To: <20191120131753.6831-2-peter.ujfalusi@ti.com>
Message-Id: <applied-20191120131753.6831-2-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: pcm3168a: Update the optional RST gpio for clarity

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 103e5d734ae28fc1ccd80d1df9d33f44536d74a4 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 20 Nov 2019 15:17:52 +0200
Subject: [PATCH] ASoC: dt-bindings: pcm3168a: Update the optional RST gpio for
 clarity

Use the standard name for the gpion in DT: reset-gpios

Document that the RST line is low active and update the example
accordingly.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191120131753.6831-2-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/ti,pcm3168a.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt b/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
index f30aebc7603a..a02ecaab5183 100644
--- a/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
+++ b/Documentation/devicetree/bindings/sound/ti,pcm3168a.txt
@@ -27,9 +27,10 @@ For required properties on SPI/I2C, consult SPI/I2C device tree documentation
 
 Optional properties:
 
-  - rst-gpios : Optional RST gpio line for the codec
-		RST = low: device power-down
-		RST = high: device is enabled
+  - reset-gpios : Optional reset gpio line connected to RST pin of the codec.
+		  The RST line is low active:
+		  RST = low: device power-down
+		  RST = high: device is enabled
 
 Examples:
 
@@ -40,7 +41,7 @@ i2c0: i2c0@0 {
 	pcm3168a: audio-codec@44 {
 		compatible = "ti,pcm3168a";
 		reg = <0x44>;
-		rst-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
 		clocks = <&clk_core CLK_AUDIO>;
 		clock-names = "scki";
 		VDD1-supply = <&supply3v3>;
-- 
2.20.1

