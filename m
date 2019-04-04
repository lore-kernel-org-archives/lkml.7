Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E328CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A867D2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554386327;
	bh=mEolpseLQs60IdvEKmc17mIeeINwW6eXeyz2O02TK7c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=De669my0dOzeOWmaEUqIuFGuRko6vpx6/gVYSPmy8CS6J4AqTm9wYF/I7QrtdGw+7
	 K1fxgQGxgR4t4yyAz4QjqXJVUneAN5QWLcyt2epQKVotBK8E/m1o8poVRsr0tu3h+k
	 G1McWvCh2S0kpDo0NPHPh/nyUSYwJpEGTRdvPLCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfDDN6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:58:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60304 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfDDN6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QsJ9tbJgHlfrnbH2jajxD2VXpW7aEfmlsf1f6onkZI0=; b=LGgMsXYXHHpP
        7NbSIRmDZ9X0qRvXa5bd6Z2X6HcPjTidQk2kb7vp8fO7QeFSbP+vRmVtfheDM0QAH5mzXCbcJXmZk
        JGDW7DQjuqzd/YrfC2BZwi9M/0Y2o1hwpyR2F5TeS4yQQGRpn3cQCuavIJIqy8BSfFo9zqHDH1MPb
        E4VnE=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hC2t6-0006dw-9u; Thu, 04 Apr 2019 13:58:40 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5B0C0441D3C; Thu,  4 Apr 2019 20:58:37 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: max98357a: add missing supported rates" to the asoc tree
In-Reply-To:  <20190404115015.32208-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404135837.5B0C0441D3C@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 20:58:37 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98357a: add missing supported rates

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

From fdf34366d3242d5eeffa1b4d9a3497ebf30a4ecb Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 4 Apr 2019 13:50:15 +0200
Subject: [PATCH] ASoC: max98357a: add missing supported rates

According the publicly available datasheet (and some test) the max98357a
also supports 32, 44.1 and 88.2 kHz sample rate.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98357a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index d469576b5a7b..d037a3e4d323 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -97,7 +97,10 @@ static struct snd_soc_dai_driver max98357a_dai_driver = {
 					SNDRV_PCM_FMTBIT_S32,
 		.rates		= SNDRV_PCM_RATE_8000 |
 					SNDRV_PCM_RATE_16000 |
+					SNDRV_PCM_RATE_32000 |
+					SNDRV_PCM_RATE_44100 |
 					SNDRV_PCM_RATE_48000 |
+					SNDRV_PCM_RATE_88200 |
 					SNDRV_PCM_RATE_96000,
 		.rate_min	= 8000,
 		.rate_max	= 96000,
-- 
2.20.1

