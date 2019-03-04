Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C87CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF20820830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551657975;
	bh=od22gek+suIQ5fCkqJouQIaLcJXWYocWdu4kK1iDgzg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ju1bUL+PwuCux6U+4NKYhjQRE4zzacEWdAA8VsNSn04d9/2Btm5HiBhSdeDQMWtVB
	 52Xu3doG/C5dCC6q85lhILdN8hTfuZytj+juVvB2N5ty2N7mdf2eoGY01o3C8BSC16
	 nQ/lwnbAQcs29ZPX5zV0HVH7k3rJnbkeqBLZ4dYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfCDAGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:14 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53232 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCDAGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=cj3wEHz0xshx3q7x/JspCI/WyNl9JZ7WCEGern7FGXM=; b=PRjJJ3l1RqMK
        W+2tbArcUj5gG/Q8C7iisGcmDncwTbVR3AoiXfqbHYUrOg0mePIGhumBT75UN2LsmXv5KQCKrjyP2
        9Jw9IDhLDv2rtizT8scpbweib5cyzBcbElpa503LtKrGBx9P5QLOC6d/TA7uh4EO4Wql4YN4HO8Cb
        CycAk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b7D-0007Nx-8c; Mon, 04 Mar 2019 00:05:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 566AC440082; Mon,  4 Mar 2019 00:05:54 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, olivier.moysan@st.com,
        arnaud.pouliquen@st.com, benjamin.gaignard@st.com,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: sai: fix set_sync service" to the asoc tree
In-Reply-To:  <1551359965-25228-6-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190304000554.566AC440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:05:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: fix set_sync service

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

From d4180b4c02e7b04b8479f6237b2bd98b4c5fd19c Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 28 Feb 2019 14:19:25 +0100
Subject: [PATCH] ASoC: stm32: sai: fix set_sync service

Add error check on set_sync function return.
Add of_node_put() as of_get_parent() takes a reference
which has to be released.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai.c     | 8 +++++---
 sound/soc/stm/stm32_sai_sub.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 14c9591aae42..d68d62f12df5 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -105,6 +105,7 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	if (!pdev) {
 		dev_err(&sai_client->pdev->dev,
 			"Device not found for node %pOFn\n", np_provider);
+		of_node_put(np_provider);
 		return -ENODEV;
 	}
 
@@ -113,19 +114,20 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 		dev_err(&sai_client->pdev->dev,
 			"SAI sync provider data not found\n");
 		ret = -EINVAL;
-		goto out_put_dev;
+		goto error;
 	}
 
 	/* Configure sync client */
 	ret = stm32_sai_sync_conf_client(sai_client, synci);
 	if (ret < 0)
-		goto out_put_dev;
+		goto error;
 
 	/* Configure sync provider */
 	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
 
-out_put_dev:
+error:
 	put_device(&pdev->dev);
+	of_node_put(np_provider);
 	return ret;
 }
 
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index cb658463ccd1..55d802f51c15 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1106,7 +1106,7 @@ static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
 static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
-	int cr1 = 0, cr1_mask;
+	int cr1 = 0, cr1_mask, ret;
 
 	sai->cpu_dai = cpu_dai;
 
@@ -1136,8 +1136,10 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	/* Configure synchronization */
 	if (sai->sync == SAI_SYNC_EXTERNAL) {
 		/* Configure synchro client and provider */
-		sai->pdata->set_sync(sai->pdata, sai->np_sync_provider,
-				     sai->synco, sai->synci);
+		ret = sai->pdata->set_sync(sai->pdata, sai->np_sync_provider,
+					   sai->synco, sai->synci);
+		if (ret)
+			return ret;
 	}
 
 	cr1_mask |= SAI_XCR1_SYNCEN_MASK;
-- 
2.20.1

