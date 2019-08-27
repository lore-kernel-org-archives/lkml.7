Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC324C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A200E20674
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566935880;
	bh=yO6ZRlrySEZjAOJUV9eLVLtDVsKtxDSqYX1cB4UQxwA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=M5U80mA2hKLYicQK2phyllNNzy5Uy/vIG6T3mqV7h/QXtCXsa0ye1tX0qiFwIo2U/
	 3YlcDQXFvy5kfD2sILkEexTYQvec6yiDFybYNj9lRDEIduWeP29AbbQ5aNtriLV1Dv
	 D0nJKOtc9zcqZpKl2erndzaygMMzaG0FciBiD6R4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfH0T57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:57:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47506 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfH0T55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=em6MZelX7acWSuGq0e95g/RTon/1iv0z54PUZyQG7gM=; b=EKigAvoh+h8Z
        K4H+BeUHg1q920TGOHo3dO1q3vT8KYG0F1Ew0XpOReYNp9xqtggBxbuThRYSRP/qbegTrhW2CP/PN
        pBZrAszLOfQvsbaiNWhsyOvWa0fHKmxTSm4UupRkW5vVjbBbtnkOVHaTFh4Z2jATLryig4OMqIUlu
        d8L3o=;
Received: from 188.28.18.107.threembb.co.uk ([188.28.18.107] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i2hb9-0001BX-It; Tue, 27 Aug 2019 19:57:48 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A0690D02CED; Tue, 27 Aug 2019 20:57:44 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     alsa-devel@alsa-project.org, Daniel Drake <drake@endlessm.com>,
        David Yang <yangxiaohua@everest-semi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8316: fix headphone mixer volume table" to the asoc tree
In-Reply-To: <20190826153900.25969-1-katsuhiro@katsuster.net>
X-Patchwork-Hint: ignore
Message-Id: <20190827195744.A0690D02CED@fitzroy.sirena.org.uk>
Date:   Tue, 27 Aug 2019 20:57:44 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: es8316: fix headphone mixer volume table

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

From f972d02fee2496024cfd6f59021c9d89d54922a6 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Tue, 27 Aug 2019 00:38:59 +0900
Subject: [PATCH] ASoC: es8316: fix headphone mixer volume table

This patch fix setting table of Headphone mixer volume.
Current code uses 4 ... 7 values but these values are prohibited.

Correct settings are the following:
  0000 -12dB
  0001 -10.5dB
  0010 -9dB
  0011 -7.5dB
  0100 -6dB
  1000 -4.5dB
  1001 -3dB
  1010 -1.5dB
  1011 0dB

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Reviewed-by: Daniel Drake <drake@endlessm.com>
Link: https://lore.kernel.org/r/20190826153900.25969-1-katsuhiro@katsuster.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8316.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 6db002cc2058..96d04896193f 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -51,7 +51,10 @@ static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(adc_vol_tlv, -9600, 50, 1);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_max_gain_tlv, -650, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_min_gain_tlv, -1200, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(alc_target_tlv, -1650, 150, 0);
-static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(hpmixer_gain_tlv, -1200, 150, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(hpmixer_gain_tlv,
+	0, 4, TLV_DB_SCALE_ITEM(-1200, 150, 0),
+	8, 11, TLV_DB_SCALE_ITEM(-450, 150, 0),
+);
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(adc_pga_gain_tlv,
 	0, 0, TLV_DB_SCALE_ITEM(-350, 0, 0),
@@ -89,7 +92,7 @@ static const struct snd_kcontrol_new es8316_snd_controls[] = {
 	SOC_DOUBLE_TLV("Headphone Playback Volume", ES8316_CPHP_ICAL_VOL,
 		       4, 0, 3, 1, hpout_vol_tlv),
 	SOC_DOUBLE_TLV("Headphone Mixer Volume", ES8316_HPMIX_VOL,
-		       0, 4, 7, 0, hpmixer_gain_tlv),
+		       0, 4, 11, 0, hpmixer_gain_tlv),
 
 	SOC_ENUM("Playback Polarity", dacpol),
 	SOC_DOUBLE_R_TLV("DAC Playback Volume", ES8316_DAC_VOLL,
-- 
2.20.1

