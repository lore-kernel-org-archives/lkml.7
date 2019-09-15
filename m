Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0860CC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 09:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DC220692
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568539903;
	bh=ZD60JmGurmPZteZvfiPfDthGkRvmyZU83/L0qNSDtLk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=K66EyRld3la+mJHHhtKtuKNMHpXKSCpQLkcviELJDblozWEIqYUiOyoTcXbkbmIR5
	 2/Uodlo92Vr0LDuoCRFbmu99W1yABChfvGjiymn5JsoNtPcOF8CbdAZDhiIlvXBim5
	 wuCVdCQQvMaF2ENbxzIBi4gAilEpZrU8DxsUFDNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfIOJbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 05:31:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35010 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfIOJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 05:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=nyo3F8+Gmt+Uhz9HQiAjvCjoWq5h5bVV0pcNn8IbSDs=; b=BtRFFzqZYniD
        NiWHe8lOEdzpXwEggZQzBfkSVqz1Y+nhGRgQ2GbeOCBN0YC2FCSGxkE/1HK/UcQupwZ5itg83/jCQ
        4HwUW5o8kp/26mo7bFytgjfpZXtQzfhwJwKj4docb6tqgeBCm9CDxnuenchFUGuOxClOdMqoMde9p
        8/5I8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9QsV-00079Y-Vg; Sun, 15 Sep 2019 09:31:32 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 600B62740A09; Sun, 15 Sep 2019 10:31:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Saiyam Doshi <saiyamdoshi.in@gmail.com>
Cc:     alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        plai@codeaurora.org, tiwai@suse.com
Subject: Applied "ASoC: sdm845: remove unneeded semicolon" to the asoc tree
In-Reply-To: <20190914031133.GA28447@SD>
X-Patchwork-Hint: ignore
Message-Id: <20190915093131.600B62740A09@ypsilon.sirena.org.uk>
Date:   Sun, 15 Sep 2019 10:31:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sdm845: remove unneeded semicolon

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

From fca11622d600228bec405456f41590155b3a3eca Mon Sep 17 00:00:00 2001
From: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Date: Sat, 14 Sep 2019 08:41:33 +0530
Subject: [PATCH] ASoC: sdm845: remove unneeded semicolon

Remove excess semicolon after closing parenthesis.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Link: https://lore.kernel.org/r/20190914031133.GA28447@SD
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 882f52ed8231..28f3cef696e6 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -319,7 +319,7 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
 				0, SNDRV_PCM_STREAM_PLAYBACK);
-		};
+		}
 		break;
 
 	case SECONDARY_MI2S_TX:
-- 
2.20.1

