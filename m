Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9061CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C772147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554386320;
	bh=Z8G3lPmYeQDOmYE7Sl9L0GB4EOM/LxnEmySxhWKBHus=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ucjGrPLDlpGwjYuBzQD9dVzBeqsnQ152kAc72CVSzSbVZYslDSp3VUqwWIMS/Wzy7
	 aaZ39rZ1jK++AxR+cmkuvGQZzOmyzErcV+vAx+urPseeb53MaiPbdMx1E/oFtrq73w
	 acCn41tT0d6js9OaukmbmN2WNitEMJniYsDfkkDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfDDN6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:58:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60098 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfDDN6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=v+Xa6dbmJr7fu6i2szrVrzRxJBaSR2eZR3VTI8mWacs=; b=QnmhC/CZiLvQ
        LPnA5ztNwVqTaJf84QlBwff7uWn8qsr+WnDJZ1v2sIioQTQGgqdtcaFiUG5YQPbxohfF6B7LA+ung
        RWNI5SEFkdDU2dU7JpnW8vD9cZuh6lNQ+3k9Vp48CKgQbuTllqbWSFLe0v/Lu5LiCwFTs6rX0xTmR
        t1gUk=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hC2sn-0006cu-Fo; Thu, 04 Apr 2019 13:58:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E959C441D3B; Thu,  4 Apr 2019 20:58:17 +0700 (+07)
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
Subject: Applied "ASoC: cs42l51: add adc volume control" to the asoc tree
In-Reply-To:  <1554297817-14154-8-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404135817.E959C441D3B@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 20:58:17 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs42l51: add adc volume control

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

From e04232c38190ec4485c62ceff94cf2b1c0caba20 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 3 Apr 2019 15:23:37 +0200
Subject: [PATCH] ASoC: cs42l51: add adc volume control

Add ADC boost volume control for CS42L51 codec.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l51.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index b8f43858876a..58ece037d944 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -123,6 +123,7 @@ static const DECLARE_TLV_DB_SCALE(tone_tlv, -1050, 150, 0);
 static const DECLARE_TLV_DB_SCALE(aout_tlv, -10200, 50, 0);
 
 static const DECLARE_TLV_DB_SCALE(boost_tlv, 1600, 1600, 0);
+static const DECLARE_TLV_DB_SCALE(adc_boost_tlv, 2000, 2000, 0);
 static const char *chan_mix[] = {
 	"L R",
 	"L+R",
@@ -151,6 +152,8 @@ static const struct snd_kcontrol_new cs42l51_snd_controls[] = {
 	SOC_SINGLE("Zero Cross Switch", CS42L51_DAC_CTL, 0, 0, 0),
 	SOC_DOUBLE_TLV("Mic Boost Volume",
 			CS42L51_MIC_CTL, 0, 1, 1, 0, boost_tlv),
+	SOC_DOUBLE_TLV("ADC Boost Volume",
+		       CS42L51_MIC_CTL, 5, 6, 1, 0, adc_boost_tlv),
 	SOC_SINGLE_TLV("Bass Volume", CS42L51_TONE_CTL, 0, 0xf, 1, tone_tlv),
 	SOC_SINGLE_TLV("Treble Volume", CS42L51_TONE_CTL, 4, 0xf, 1, tone_tlv),
 	SOC_ENUM_EXT("PCM channel mixer",
-- 
2.20.1

