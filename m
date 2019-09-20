Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1EFC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 11:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F60420882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568977783;
	bh=3mbFmZubf4A5yyNag3vIom7MgSpOe8Uqfy3CnbC6iHw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=WJJD6++BIuT7FuhPHHfm8FBlxf9L2RnIUL4Z52U8clICy/m2ejzM9511DYYU1NGkT
	 UZWYiMtzb5Jw6IEYSJNiOIIiSTAhUL6/ktpGe3aNajg6ndUThgyWGXWdVMIPwO2fb0
	 9ZaQhSR3dO2/VwF5T0dCkJT+ONljBNnk+LbunHuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438153AbfITLJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 07:09:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43604 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408667AbfITLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 07:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Z70n2Z6BU9jMkXwWxciRSQmegfY6LqP81y3tgyLEgeI=; b=MqFKteSdEbPX
        6ZbcHZKocF5vKKvqjaxR3DWg0IHlNxZ7L7sP2YNQ/GZjYpyq/7qT1gJaBnsOqwyvbaRWbcDAAAszV
        piJhCIXZJNL1ppEJkmiNgL8b0mOqd26LTxMxBOQVjWWlqY/XFRdrBSQ4JJu3cMmfUf6tEiQKrfrR8
        z5Rvg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iBGn7-0001cL-Gl; Fri, 20 Sep 2019 11:09:33 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 11CB2274293C; Fri, 20 Sep 2019 12:09:33 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     alsa-devel@alsa-project.org,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Applied "ASoC: ti: fix SND_SOC_DM365_VOICE_CODEC dependencies" to the asoc tree
In-Reply-To: <20190920075046.3210393-1-arnd@arndb.de>
X-Patchwork-Hint: ignore
Message-Id: <20190920110933.11CB2274293C@ypsilon.sirena.org.uk>
Date:   Fri, 20 Sep 2019 12:09:33 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ti: fix SND_SOC_DM365_VOICE_CODEC dependencies

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

From 147162f575152db80000fb3de26358264768ee9f Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Sep 2019 09:50:18 +0200
Subject: [PATCH] ASoC: ti: fix SND_SOC_DM365_VOICE_CODEC dependencies

SND_SOC_DM365_VOICE_CODEC is a 'bool' option in a choice statement,
meaning it cannot be set to =m, but it selects two other drivers
that we may want to be loadable modules after all:

WARNING: unmet direct dependencies detected for SND_SOC_CQ0093VC
  Depends on [m]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m]
  Selected by [y]:
  - SND_SOC_DM365_VOICE_CODEC [=y] && <choice>
  Selected by [m]:
  - SND_SOC_ALL_CODECS [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && COMPILE_TEST [=y]

Add an intermediate symbol that sets SND_SOC_CQ0093VC and
MFD_DAVINCI_VOICECODEC to =m if SND_SOC=m.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20190920075046.3210393-1-arnd@arndb.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/Kconfig | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 87a9b9dd4e98..29f61053ab62 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -200,11 +200,18 @@ config SND_SOC_DM365_AIC3X_CODEC
 
 config SND_SOC_DM365_VOICE_CODEC
 	bool "Voice Codec - CQ93VC"
-	select MFD_DAVINCI_VOICECODEC
-	select SND_SOC_CQ0093VC
 	help
 	  Say Y if you want to add support for SoC On-chip voice codec
 endchoice
 
+config SND_SOC_DM365_VOICE_CODEC_MODULE
+	def_tristate y
+	depends on SND_SOC_DM365_VOICE_CODEC && SND_SOC
+	select MFD_DAVINCI_VOICECODEC
+	select SND_SOC_CQ0093VC
+	help
+	  The is an internal symbol needed to ensure that the codec
+	  and MFD driver can be built as loadable modules if necessary.
+
 endmenu
 
-- 
2.20.1

