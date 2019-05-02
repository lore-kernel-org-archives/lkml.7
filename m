Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB321C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAFE21734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763536;
	bh=rADM0UJwWaDvZe9bhtKtLMdX9L0WFZWCvDLJIOSn1k0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EBdKK3K9IPk2ahKY1wcLTFT/ZZ9tMQ4H2LZ9lwMGGqpJRWS6zpDs+dlQA1yDPg8R6
	 WKNkeS2P9Uyly118eXCNIyETMOxG/XdhrTg/hURmWwVBN78aAGNanuposrBMpNCMc5
	 306L6HBg1mVe21iVUo3r6kbvqTW+BRRl8KyEpSKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfEBCSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:18:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56086 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfEBCSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0yDQ8mpJU01WNjUag4mEZvrS2eyoOFnSJkZ+fvTaTrg=; b=Ks9gDZ1vx9BH
        GbMROOxW7vHVAStgwwSZZ2FuGChyLsoHMuiazpw8hAWgEfab9jfufpBL8aVECnJEJHx1p/M6fMzOk
        jipUepVcKekmC2DPz6+Wkos2jcpsKwUtCEl0Gg1y0d7FSFHkFPO1YuHpnqdyL+usY4oR/hxp/XhA9
        1jWBw=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1Iz-0005sb-FU; Thu, 02 May 2019 02:18:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 90851441D3B; Thu,  2 May 2019 03:18:34 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
        broonie@kernel.org, codrin.ciubotariu@microchip.com,
        Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ludovic.desroches@microchip.com, Mark Brown <broonie@kernel.org>,
        nicolas.ferre@microchip.com, peda@axentia.se, perex@perex.cz,
        tiwai@suse.com
Subject: Applied "ASoC: atmel: tse850: Make some functions static" to the asoc tree
In-Reply-To:  <20190416144718.25576-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021834.90851441D3B@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:34 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: atmel: tse850: Make some functions static

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

From 6f547c96b45de0d42de91ef56c7d291aa6d3c88f Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 16 Apr 2019 22:47:18 +0800
Subject: [PATCH] ASoC: atmel: tse850: Make some functions static

Fix sparse warnings:

sound/soc/atmel/tse850-pcm5142.c:120:5: warning: symbol 'tse850_get_mix' was not declared. Should it be static?
sound/soc/atmel/tse850-pcm5142.c:132:5: warning: symbol 'tse850_put_mix' was not declared. Should it be static?
sound/soc/atmel/tse850-pcm5142.c:154:5: warning: symbol 'tse850_get_ana' was not declared. Should it be static?
sound/soc/atmel/tse850-pcm5142.c:187:5: warning: symbol 'tse850_put_ana' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/tse850-pcm5142.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index 214adcad5419..ae445184614a 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -117,8 +117,8 @@ static int tse850_put_mux2(struct snd_kcontrol *kctrl,
 	return snd_soc_dapm_put_enum_double(kctrl, ucontrol);
 }
 
-int tse850_get_mix(struct snd_kcontrol *kctrl,
-		   struct snd_ctl_elem_value *ucontrol)
+static int tse850_get_mix(struct snd_kcontrol *kctrl,
+			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
 	struct snd_soc_card *card = dapm->card;
@@ -129,8 +129,8 @@ int tse850_get_mix(struct snd_kcontrol *kctrl,
 	return 0;
 }
 
-int tse850_put_mix(struct snd_kcontrol *kctrl,
-		   struct snd_ctl_elem_value *ucontrol)
+static int tse850_put_mix(struct snd_kcontrol *kctrl,
+			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
 	struct snd_soc_card *card = dapm->card;
@@ -151,8 +151,8 @@ int tse850_put_mix(struct snd_kcontrol *kctrl,
 	return 1;
 }
 
-int tse850_get_ana(struct snd_kcontrol *kctrl,
-		   struct snd_ctl_elem_value *ucontrol)
+static int tse850_get_ana(struct snd_kcontrol *kctrl,
+			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
 	struct snd_soc_card *card = dapm->card;
@@ -184,8 +184,8 @@ int tse850_get_ana(struct snd_kcontrol *kctrl,
 	return 0;
 }
 
-int tse850_put_ana(struct snd_kcontrol *kctrl,
-		   struct snd_ctl_elem_value *ucontrol)
+static int tse850_put_ana(struct snd_kcontrol *kctrl,
+			  struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kctrl);
 	struct snd_soc_card *card = dapm->card;
-- 
2.20.1

