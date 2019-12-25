Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FD1C2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1748206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 00:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577232564;
	bh=iITJjW9IMwLKIfeNIcVxUUZdqi/toJhzgZR6xj8CnQQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kuEPTqnJdBgy7Xt1NoDO3Me0J7ip2bQyBUulZW2uIlTx5bZo4V7bffWRKtPunsA8P
	 tHPCNebkkfucJiF6EhbWkHF8xV/phrcGUCi6zbRXXpH5zt9a+f6tKg8yiVu7OfX8Rd
	 YKnCVOeRO6t9pDpkOaFgTFUw78hEgOJb3iUWY2Io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLYAJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:09:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33456 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfLYAJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 19:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eAfqy3PDIk+Y7z80iXzd+LpbybnMbajFGSwywhRYyCg=; b=abMiMZyeKxLJ
        bEkcOzrS+xxYik5c+2zinXEZhjMDM2/LZVSiT506D2p2jxavyVxc/44gcl7wTrylAB2bzsgIGkp1T
        QXFKm0uY+Nmrzehe+j5KF6K265jm3v1lLGyBjd7Vs3KOTsmcO1m8JfoYDhJSJnRroJBDXH0H74sRU
        XwJXg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ijuEh-0007MQ-SV; Wed, 25 Dec 2019 00:09:11 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 6416FD01957; Wed, 25 Dec 2019 00:09:11 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, tiwai@suse.com
Subject: Applied "ASoC: soc-core: Set dpcm_playback / dpcm_capture" to the asoc tree
In-Reply-To:  <20191204151333.26625-1-daniel.baluta@nxp.com>
Message-Id:  <applied-20191204151333.26625-1-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Date:   Wed, 25 Dec 2019 00:09:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-core: Set dpcm_playback / dpcm_capture

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

From 218fe9b7ec7f32c10a07539365488d80af7b0084 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 4 Dec 2019 17:13:33 +0200
Subject: [PATCH] ASoC: soc-core: Set dpcm_playback / dpcm_capture

When converting a normal link to a DPCM link we need
to set dpcm_playback / dpcm_capture otherwise playback/capture
streams will not be created resulting in errors like this:

[   36.039111]  sai1-wm8960-hifi: ASoC: no backend playback stream

Fixes: a655de808cbde ("ASoC: core: Allow topology to override machine driver FE DAI link config")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20191204151333.26625-1-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1c84ff1a5bf9..6050c4c62fe8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1871,6 +1871,8 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 
 			/* convert non BE into BE */
 			dai_link->no_pcm = 1;
+			dai_link->dpcm_playback = 1;
+			dai_link->dpcm_capture = 1;
 
 			/* override any BE fixups */
 			dai_link->be_hw_params_fixup =
-- 
2.20.1

