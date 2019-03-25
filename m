Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F468C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E104A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553516586;
	bh=CAT8Gaomjufrt69SNfQzDJpcrsHWefk7fECKHc7y9YM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Uzd/7N1RjJmTKt3RMVUEQWPZKLHjorarWO8PmEc2QGBY7ddbfDiT7jC0wzATyy0fQ
	 VXBEcau3+Tyk4lIFuRYSx7zdQ0g3wfJIoSQm55Ajl2HXDhJjNOpgtM6rQwTbYtHbFl
	 L90Qwimbbw0+Tc/fqsBYaoYLSlrebjp6I4snezH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfCYMXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:23:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37238 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731230AbfCYMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aDv3vJ/u6TgAOaCV69UIlb4vElK0HKkB3cyFI+RgyfI=; b=NQmjgwLIwBXA
        gwjOUf8ai/OEcRFK8M7Prw2/YGTXDuXt2zBB2avyJ8rtGxlvIuGsnwIYGyJH5qcWT5R+mj9u10inb
        6yq+zZCGPGa1RClUbxk/r+AB3s+I1yEbWJBvFrV23yer3djd9dbAP1PhNMJM652VutKtIwjTBo2Ty
        9tNZc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8Oc8-00023l-15; Mon, 25 Mar 2019 12:22:04 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8E77111288F1; Mon, 25 Mar 2019 12:22:02 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org,
        pankaj.laxminarayan.bharadiya@intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_free_kcontrol" to the asoc tree
In-Reply-To:  <1553257809-9294-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190325122202.8E77111288F1@debutante.sirena.org.uk>
Date:   Mon, 25 Mar 2019 12:22:02 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_free_kcontrol

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

From cacea3a90e211f0c111975535508d446a4a928d2 Mon Sep 17 00:00:00 2001
From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Date: Fri, 22 Mar 2019 18:00:09 +0530
Subject: [PATCH] ASoC: dapm: Fix NULL pointer dereference in
 snd_soc_dapm_free_kcontrol

w_text_param can be NULL and it is being dereferenced without checking.
Add the missing sanity check to prevent  NULL pointer dereference.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1ec06ef6d161..67b032ca1601 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3957,6 +3957,10 @@ snd_soc_dapm_free_kcontrol(struct snd_soc_card *card,
 	int count;
 
 	devm_kfree(card->dev, (void *)*private_value);
+
+	if (!w_param_text)
+		return;
+
 	for (count = 0 ; count < num_params; count++)
 		devm_kfree(card->dev, (void *)w_param_text[count]);
 	devm_kfree(card->dev, w_param_text);
-- 
2.20.1

