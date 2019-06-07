Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F91C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B492133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559934437;
	bh=rXqnVuyP9nkar3BjR5X2EQypSganjQwIzT4Q7BlIOUg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=DoBBbquFetNzqObhKlid5wb5v0kA8zeBlaLg78359d3fAzccaZFHsUQKOjbrNjvHZ
	 KbiYQtMOPhBzOvEZRLTG70SetuXDlT6/crBOfPG+TWNYooIp2h+POmiY/fMYcryQM/
	 EgUAWCpAjuUU2hkMKpH61s/SL3QMyA5Od4exB1YU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfFGTHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:07:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbfFGTHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+tUmJIy3CbEFchUytsXWp6t66QqGoPGh2GzgBgkAhjQ=; b=OUPOKv1YtcnU
        EC2+fiMt2g5UBpPUCWyCRGPrxZasxwBrhh8k8vGX5S90SiEuYyMH7z0N4C59/WBzlH5CbJRscU76Y
        ppSn3qyhS+LWx4aogD5y+suoFd8OTGKVeRLJUwURuJto5vYGPcU/a/xcTrHrbqpt5QyE/iIwaAfZq
        gtJ1I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hZKCh-0003gB-VK; Fri, 07 Jun 2019 19:07:08 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 50C1E440046; Fri,  7 Jun 2019 20:07:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        devicetree@vger.kernel.org, Hugues Fruchet <hugues.fruchet@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Applied "ASoC: dt-bindings: fix some broken links from txt->yaml conversion" to the asoc tree
In-Reply-To: <effeafed3023d8dc5f2440c8d5637ea31c02a533.1559933665.git.mchehab+samsung@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20190607190707.50C1E440046@finisterre.sirena.org.uk>
Date:   Fri,  7 Jun 2019 20:07:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: fix some broken links from txt->yaml conversion

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 6c0215f5d9f2a1fa5cab2ca320a41d9f19cfa80c Mon Sep 17 00:00:00 2001
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date: Fri, 7 Jun 2019 15:54:33 -0300
Subject: [PATCH] ASoC: dt-bindings: fix some broken links from txt->yaml
 conversion

Some new files got converted to yaml, but references weren't
updated accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/media/st,stm32-dcmi.txt | 2 +-
 Documentation/devicetree/bindings/sound/st,stm32-i2s.txt  | 2 +-
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt  | 2 +-
 MAINTAINERS                                               | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/st,stm32-dcmi.txt b/Documentation/devicetree/bindings/media/st,stm32-dcmi.txt
index 249790a93017..3122ded82eb4 100644
--- a/Documentation/devicetree/bindings/media/st,stm32-dcmi.txt
+++ b/Documentation/devicetree/bindings/media/st,stm32-dcmi.txt
@@ -11,7 +11,7 @@ Required properties:
 - clock-names: must contain "mclk", which is the DCMI peripherial clock
 - pinctrl: the pincontrol settings to configure muxing properly
            for pins that connect to DCMI device.
-           See Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt.
+           See Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml.
 - dmas: phandle to DMA controller node,
         see Documentation/devicetree/bindings/dma/stm32-dma.txt
 - dma-names: must contain "tx", which is the transmit channel from DCMI to DMA
diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt b/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
index 58c341300552..cbf24bcd1b8d 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
@@ -18,7 +18,7 @@ Required properties:
     See Documentation/devicetree/bindings/dma/stm32-dma.txt.
   - dma-names: Identifier for each DMA request line. Must be "tx" and "rx".
   - pinctrl-names: should contain only value "default"
-  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
 
 Optional properties:
   - resets: Reference to a reset controller asserting the reset controller
diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index 3f4467ff0aa2..944743dd9212 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -41,7 +41,7 @@ SAI subnodes required properties:
 	"tx": if sai sub-block is configured as playback DAI
 	"rx": if sai sub-block is configured as capture DAI
   - pinctrl-names: should contain only value "default"
-  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
 
 SAI subnodes Optional properties:
   - st,sync: specify synchronization mode.
diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce575..b3d686fba562 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1288,7 +1288,7 @@ ARM PRIMECELL SSP PL022 SPI DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi_pl022.txt
+F:	Documentation/devicetree/bindings/spi/spi-pl022.yaml
 F:	drivers/spi/spi-pl022.c
 
 ARM PRIMECELL UART PL010 AND PL011 DRIVERS
-- 
2.20.1

