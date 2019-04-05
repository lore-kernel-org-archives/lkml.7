Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BCC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBC0217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554434809;
	bh=UKmX7+zpQ5C5WooDVl6znbnfw4bAVWWZLyz3bDfZjwc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GuJHvE2Pg50KQXWYAlUTg8jxteHHVTMKwU44S8N9w/quYzOLFb76yZfvZ3Akl53qG
	 B/WykeZUi90hawIn0IKZn6U3zssrgayex2fSOZseirtWZLZN7aphHYSGdGs4XAkNSu
	 DBdn5Bi2bO9IXgn4do9t88p27/W3OCMtYiCrVY64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfDED0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:26:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33506 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfDED0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/Q2DDK8V5X4OvWBOyM4GdwxsAjuUpxsLcazsU1ol3ng=; b=lRThc5wiC8wi
        i8k3e7gp8mSySC7Pjhp00p3Ep+xzVqyr34tFNBEn3yIHQQfDtDFQ8juotXVzn8Hu28Afr8p980EXa
        H1A0y0bFkMETDCWik9MGpDZEL1+NOrME/Aj2Vmlym7nVmoIyGBt/7NS1RbdzWWIjpTatqe1UZAYBi
        Ue/EQ=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCFUg-0005fN-EC; Fri, 05 Apr 2019 03:26:18 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 25092441D3B; Fri,  5 Apr 2019 10:26:10 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        apatard@mandriva.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: cs42l51: change mic bias DAPM" to the asoc tree
In-Reply-To:  <1554297817-14154-6-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405032610.25092441D3B@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 10:26:10 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42l51: change mic bias DAPM

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

From 4110e9a1868332e305f64d5c5b32368597caeb8f Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 3 Apr 2019 15:23:35 +0200
Subject: [PATCH] ASoC: cs42l51: change mic bias DAPM

Use SND_SOC_DAPM_SUPPLY for mic bias DAPM
instead of deprecated SND_SOC_DAPM_MICBIAS.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 58ece037d944..991e4ebd7a04 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -210,7 +210,8 @@ static const struct snd_kcontrol_new cs42l51_adcr_mux_controls =
 	SOC_DAPM_ENUM("Route", cs42l51_adcr_mux_enum);
 
 static const struct snd_soc_dapm_widget cs42l51_dapm_widgets[] = {
-	SND_SOC_DAPM_MICBIAS("Mic Bias", CS42L51_MIC_POWER_CTL, 1, 1),
+	SND_SOC_DAPM_SUPPLY("Mic Bias", CS42L51_MIC_POWER_CTL, 1, 1, NULL,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_PGA_E("Left PGA", CS42L51_POWER_CTL1, 3, 1, NULL, 0,
 		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
 	SND_SOC_DAPM_PGA_E("Right PGA", CS42L51_POWER_CTL1, 4, 1, NULL, 0,
-- 
2.20.1

