Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F58C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626AF2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553530332;
	bh=guaJe1WSyuBLUepkTNXhV1v7/amRWCzvk5TEIKqXw+8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=QAqd+WxuVSyyoimKDAzP2FagDUwxUKy5uXQwrGgNYkoqcPXHRKNkSuToYuca8Pcxe
	 +0hGmcf1zMqmwGmeNpW4inzuQInDGD4Cvhp2wuoDhvQAmZfdyj8X8TNBOfMbmXbnyC
	 ovyjrw6crNxq38qQmhS0toczYYLEI2R9M0Va3X+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfCYQML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:12:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54958 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=neBUgRha04DoVyeD1cBHZmtECLOLmAOFTOQTyjL0MUU=; b=wpGb9WZfx5Qc
        4LbuQITaUgeYQbboFJClih875h58JYI+bis2tMI3RlvEqzXaXRwQi64C/QqcazT/wYMQsFovpYcBu
        4Ys2M2l7xUDIwcmczVn3bQfTg0k13ycYdbHJEYXfTOFUiMzi4CbKQWmyuHymS7xkMasoN/TaQkORq
        +Fwp8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8SCU-0002g5-FJ; Mon, 25 Mar 2019 16:11:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0ABA511288F1; Mon, 25 Mar 2019 16:11:45 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org,
        pankaj.laxminarayan.bharadiya@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: dapm: Initialize private_value in snd_soc_dapm_new_dai" to the asoc tree
In-Reply-To:  <1553271819-24576-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190325161145.0ABA511288F1@debutante.sirena.org.uk>
Date:   Mon, 25 Mar 2019 16:11:45 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dapm: Initialize private_value in snd_soc_dapm_new_dai

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

From 8633d44002ba5c98f44bacc1397190adba832fd6 Mon Sep 17 00:00:00 2001
From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Date: Fri, 22 Mar 2019 21:53:39 +0530
Subject: [PATCH] ASoC: dapm: Initialize private_value in snd_soc_dapm_new_dai

In case of single config, private_value is left uninitialized.

The private_value does need to be initialized or in
snd_soc_dapm_new_control_unlocked() call failure case, it leads to a
bogus free in snd_soc_dapm_free_kcontrol()

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1ec06ef6d161..74a6f5705f66 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4038,7 +4038,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 	struct snd_soc_dapm_widget template;
 	struct snd_soc_dapm_widget *w;
 	const char **w_param_text;
-	unsigned long private_value;
+	unsigned long private_value = 0;
 	char *link_name;
 	int ret;
 
-- 
2.20.1

