Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1506EC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3B321D7B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930167;
	bh=g0Qil/4GUGn1itKo7hX8mJ7UF9jteANKPI8CLUcQ8FY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=sSVkWmrsn/7+MBYvjR2YID55xAYKHPd63e+xRpJfNWXLfOacbmD7Tfzr6K1C2lvo3
	 LBoRVQZ5v8i5zLTBHBklvrmxN3xWRc8bKsNn4wewB0c1uLhPU8MNjKfm4H4EDn6poM
	 W98pL674AESfEMiQyMVgHLA8tOJ7AR10wkd1UKMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbfJALk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:40:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40400 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732803AbfJALk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WERVSR+BAQJwf3PYWWyXu5R8XD5gifIGU8k5q5E4VGw=; b=ukEO4Ubfs4C5
        e1EtMwu3yNT9/lC1hpLzQoFaXSxdrgrdBa2Pzi2yVPVmti3JfFiBgAESsr49bHkXbEIUqnP9Vr1Bm
        XQ1uPFV8VeDkyRKhKv+GQ5kaxYZ+WjMfvoeb7ReGSUTWi8m9lMwbxPP6SwbRDtSXBbQvkkZK1D/tS
        yIXBU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWN-0004Sz-Tb; Tue, 01 Oct 2019 11:40:47 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6CF3527429C0; Tue,  1 Oct 2019 12:40:47 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: wcd9335: clean up indentation issue" to the asoc tree
In-Reply-To: <20190925111023.7771-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114047.6CF3527429C0@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:47 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wcd9335: clean up indentation issue

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

From 944eedd8c021893d08d02a8eec8e5161327316cd Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 25 Sep 2019 12:10:23 +0100
Subject: [PATCH] ASoC: wcd9335: clean up indentation issue

There is an if statement that is indented one level too deeply,
remove the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190925111023.7771-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index f318403133e9..f11ffa28683b 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -2837,11 +2837,11 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
 				   TX_HPF_CUT_OFF_FREQ_MASK) >> 5;
 		snd_soc_component_update_bits(comp, tx_vol_ctl_reg, 0x10, 0x10);
 		snd_soc_component_update_bits(comp, dec_cfg_reg, 0x08, 0x00);
-			if (hpf_coff_freq != CF_MIN_3DB_150HZ) {
-				snd_soc_component_update_bits(comp, dec_cfg_reg,
-						    TX_HPF_CUT_OFF_FREQ_MASK,
-						    hpf_coff_freq << 5);
-			}
+		if (hpf_coff_freq != CF_MIN_3DB_150HZ) {
+			snd_soc_component_update_bits(comp, dec_cfg_reg,
+						      TX_HPF_CUT_OFF_FREQ_MASK,
+						      hpf_coff_freq << 5);
+		}
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		snd_soc_component_update_bits(comp, tx_vol_ctl_reg, 0x10, 0x00);
-- 
2.20.1

