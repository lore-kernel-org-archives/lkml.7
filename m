Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47025C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9E9218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103067;
	bh=liQIPmUoSUd9NnlZV4ogSFNT1lfpHSkmPPzGmyIpeO8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=iUL2mAKekm9cm2SvCEOXkjyCscsKvjKrtBQNtOa8pnm5KcVZuLxfKv71JpxupMVoT
	 PWQTWl7Utf6Q3JbhW49lsG9iXhI+wUqpYtTAy/6Zb5+aJP8nGSbEdKoAZkd4c1osSf
	 ZGfRREyruPFicEwtMsoB9D+ADlUqKRtokzsGAiOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCTR3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:29:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43716 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfCTR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dlxxOt4pex3YgMLqU3bM7fwl3sUMUTWs+eC3ff6/+H8=; b=aiBhRWZtrLYm
        kRUzCbRASjFtJb6RgMMj35/tP7/2Mwr6oBBVmvzpf+SwWGGpjwioCT1KSMs0W1QmV6+4KlIFtp+cN
        6tklgzd6g+0bRfJEC3I1fkhCp1Il8uHQ+1vLJheFWI99pHBVzk5mzyGfW0ng+rRoGCkAy4Jn5C1+9
        a6cfE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6f1m-000182-7d; Wed, 20 Mar 2019 17:29:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 6C3991126E4C; Wed, 20 Mar 2019 17:29:21 +0000 (GMT)
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
Subject: Applied "ASoC: stm32: dfsdm: fix debugfs warnings on entry creation" to the asoc tree
In-Reply-To:  <1551711165-28684-3-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190320172921.6C3991126E4C@debutante.sirena.org.uk>
Date:   Wed, 20 Mar 2019 17:29:21 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: dfsdm: fix debugfs warnings on entry creation

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

From c47255b61129857b74b0d86eaf59335348be05e0 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 4 Mar 2019 15:52:44 +0100
Subject: [PATCH] ASoC: stm32: dfsdm: fix debugfs warnings on entry creation

Register platform component with a prefix, to avoid warnings
on debugfs entries creation, due to component name
redundancy.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_adfsdm.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index d77f0421e4f0..78bed9734713 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -305,6 +305,7 @@ MODULE_DEVICE_TABLE(of, stm32_adfsdm_of_match);
 static int stm32_adfsdm_probe(struct platform_device *pdev)
 {
 	struct stm32_adfsdm_priv *priv;
+	struct snd_soc_component *component;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -332,9 +333,15 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->iio_cb))
 		return PTR_ERR(priv->iio_cb);
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &stm32_adfsdm_soc_platform,
-					      NULL, 0);
+	component = devm_kzalloc(&pdev->dev, sizeof(*component), GFP_KERNEL);
+	if (!component)
+		return -ENOMEM;
+#ifdef CONFIG_DEBUG_FS
+	component->debugfs_prefix = "pcm";
+#endif
+
+	ret = snd_soc_add_component(&pdev->dev, component,
+				    &stm32_adfsdm_soc_platform, NULL, 0);
 	if (ret < 0)
 		dev_err(&pdev->dev, "%s: Failed to register PCM platform\n",
 			__func__);
@@ -342,12 +349,20 @@ static int stm32_adfsdm_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int stm32_adfsdm_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_component(&pdev->dev);
+
+	return 0;
+}
+
 static struct platform_driver stm32_adfsdm_driver = {
 	.driver = {
 		   .name = STM32_ADFSDM_DRV_NAME,
 		   .of_match_table = stm32_adfsdm_of_match,
 		   },
 	.probe = stm32_adfsdm_probe,
+	.remove = stm32_adfsdm_remove,
 };
 
 module_platform_driver(stm32_adfsdm_driver);
-- 
2.20.1

