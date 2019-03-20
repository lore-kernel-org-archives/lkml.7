Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF44C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE27021841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553102980;
	bh=wTy5EpbiGZz487Cojr+F9cuzYGbnKPOUu9c7WA1dcn4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GXaOHnEJSX+PNLBR8qhHArRee6r8+lL3jvNmBoEkFYGgw524WaRM+1vr6/HIbAWpF
	 VQTq8TJeo67I7y/KkgJ1LLKre6meyYxzwr7JTsn1TEvFs8Qoa0sx4Gd/AnVmfPDxly
	 7NDxfH1rstpC0cj+NZjntlC8RVMKH2fnONcqvMHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCTR3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:29:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43624 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfCTR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nDzRGumfDbLVrf5ScV6Slqf2nMzmo4SkNg7oEB93QcU=; b=hQftAoIMniaJ
        04yJwObi7hGnJuVVZ5q0xaM+R65NeE2g26np7/FfC3YSKH3Z72EfFVeT+d2WF5K+zEhu2N7OTHiil
        i7/2N6w7i5gWQa9QAvPLhKLrROwFUyD/HHQ1/1HWOxVzUj3w9RviPV3yn1Q2c8EWEWF36lQ9nMUIl
        3Mlao=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f1w-00018f-O8; Wed, 20 Mar 2019 17:29:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 492211126E4C; Wed, 20 Mar 2019 17:29:32 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: jz4740: Depend on MIPS instead of MACH_JZ4740" to the asoc tree
In-Reply-To:  <20190319140014.26796-1-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Message-Id: <20190320172932.492211126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:29:32 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: jz4740: Depend on MIPS instead of MACH_JZ4740

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

From 0f91d24f2c78e24303594395db58a0e983606a8c Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Tue, 19 Mar 2019 15:00:14 +0100
Subject: [PATCH] ASoC: jz4740: Depend on MIPS instead of MACH_JZ4740

Depending on MACH_JZ4740 prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/jz4740/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index 1a354a6b6e87..b3f9c41b4319 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -1,6 +1,6 @@
 config SND_JZ4740_SOC
 	tristate "SoC Audio for Ingenic JZ4740 SoC"
-	depends on MACH_JZ4740 || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
-- 
2.20.1

