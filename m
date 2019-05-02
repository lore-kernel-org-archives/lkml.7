Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E13DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D96821734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763527;
	bh=z6AMoiqDA6/Pf4JsrLqTuH5ejkuIUZf327jdRh+6PJ4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YbeUxZvmz8DMeuKnyXFlyE6SfZxwd8JFRWmVOWhA7YtJ49sEhf5aPTXrFhEaaCvcd
	 q591SrEKbeAFZl52VoL7s/9cpYYAiLEPnA9E/RFz2Eo34pfHkazQWuArWpbcetHq7U
	 PIaOHC7dmIRZYzagStPzrAsq0k0z75mgntt2Y/lA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfEBCSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:18:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55786 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfEBCSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=r3CyppHMBbbvBau7Gtud8BstrQ70gDTeNXRpDTmvaMk=; b=R4ctCByoicg3
        nB+OqNmdXltXegvsA4azXvfJ2+4EQajUsBHMo+uIGLZt1jrmUb6AvB7Legheyc5675NmEfTs0aApG
        EQuEpltuCZVb9ynZddLGvq5Q7fV4OrftOk/3SvbYiS3U+L4RGGSwaRjtyyi7agYLv9GZeSo+bIUsj
        bCbkk=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1J1-0005sk-PO; Thu, 02 May 2019 02:18:40 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id A4527441D3C; Thu,  2 May 2019 03:18:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     alsa-devel@alsa-project.org,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Applied "ASoC: imx: fix fiq dependencies" to the asoc tree
In-Reply-To:  <20190416131242.1232143-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20190502021836.A4527441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:36 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: imx: fix fiq dependencies

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

From ea751227c813ab833609afecfeedaf0aa26f327e Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 Apr 2019 15:12:23 +0200
Subject: [PATCH] ASoC: imx: fix fiq dependencies

During randconfig builds, I occasionally run into an invalid configuration
of the freescale FIQ sound support:

WARNING: unmet direct dependencies detected for SND_SOC_IMX_PCM_FIQ
  Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_IMX_SOC [=m]
  Selected by [y]:
  - SND_SOC_FSL_SPDIF [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_IMX_SOC [=m]!=n && (MXC_TZIC [=n] || MXC_AVIC [=y])

sound/soc/fsl/imx-ssi.o: In function `imx_ssi_remove':
imx-ssi.c:(.text+0x28): undefined reference to `imx_pcm_fiq_exit'
sound/soc/fsl/imx-ssi.o: In function `imx_ssi_probe':
imx-ssi.c:(.text+0xa64): undefined reference to `imx_pcm_fiq_init'

The Kconfig warning is a result of the symbol being defined inside of
the "if SND_IMX_SOC" block, and is otherwise harmless. The link error
is more tricky and happens with SND_SOC_IMX_SSI=y, which may or may not
imply FIQ support. However, if SND_SOC_FSL_SSI is set to =m at the same
time, that selects SND_SOC_IMX_PCM_FIQ as a loadable module dependency,
which then causes a link failure from imx-ssi.

The solution here is to make SND_SOC_IMX_PCM_FIQ built-in whenever
one of its potential users is built-in.

Fixes: ff40260f79dc ("ASoC: fsl: refine DMA/FIQ dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index d87c842806bd..55ed47c599e2 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -189,16 +189,17 @@ config SND_MPC52xx_SOC_EFIKA
 
 endif # SND_POWERPC_SOC
 
+config SND_SOC_IMX_PCM_FIQ
+	tristate
+	default y if SND_SOC_IMX_SSI=y && (SND_SOC_FSL_SSI=m || SND_SOC_FSL_SPDIF=m) && (MXC_TZIC || MXC_AVIC)
+	select FIQ
+
 if SND_IMX_SOC
 
 config SND_SOC_IMX_SSI
 	tristate
 	select SND_SOC_FSL_UTILS
 
-config SND_SOC_IMX_PCM_FIQ
-	tristate
-	select FIQ
-
 comment "SoC Audio support for Freescale i.MX boards:"
 
 config SND_MXC_SOC_WM1133_EV1
-- 
2.20.1

