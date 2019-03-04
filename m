Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA7E20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551657985;
	bh=ItIufZR0w8qT+OC72+UC0PXCiWRR8LMa8A1bRZT0Hsk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fPK6lfSGC/dVo0Bz6+flzWj54TxdMeu0I/4q8Aa6y4/C+bBBpOd9k0gvNEO1aVrJK
	 A38lrPMyEtrdl820Su63qvauw+vTT/dZwTmj6vdcqDVjpm1MyomFH4TGf5KR5dWD8F
	 BUs9pPN/uD0YrD560PQIxf/ZoEjQGOYlr9ouJx08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCDAGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:06:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53502 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCDAGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jL9zR7pVpIlkQnB7M/wqdQlZcR9XoqbIBRwErowufzI=; b=gdLufBTq27bi
        DbbghfRHI6F4T30wbv8gdA2jMJXj2MGu/SFHFAr6YGGy1qbaIlOxJP85hVvWu+7KUpMF0F+CqlK0E
        PikeZVCsFnThht3NbONHYcdhEJwPPYgoBaOalV8qi5DYPDw7TfJ3jMNmmf/srcTgO3jNF+zNg5Lgs
        n0eGY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0b7P-0007OP-2y; Mon, 04 Mar 2019 00:06:07 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7B327440082; Mon,  4 Mar 2019 00:06:06 +0000 (GMT)
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
Subject: Applied "ASoC: stm32: sai: fix iec958 controls indexation" to the asoc tree
In-Reply-To:  <1551359965-25228-2-git-send-email-olivier.moysan@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190304000606.7B327440082@finisterre.ee.mobilebroadband>
Date:   Mon,  4 Mar 2019 00:06:06 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: fix iec958 controls indexation

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

From 5f8a1000c3e630c3ac06f1d664eeaa755bce8823 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 28 Feb 2019 14:19:21 +0100
Subject: [PATCH] ASoC: stm32: sai: fix iec958 controls indexation

Allow indexation of sai iec958 controls according
to device id.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index f9297228c41c..506360b7bc01 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -100,7 +100,7 @@
  * @slot_mask: rx or tx active slots mask. set at init or at runtime
  * @data_size: PCM data width. corresponds to PCM substream width.
  * @spdif_frm_cnt: S/PDIF playback frame counter
- * @snd_aes_iec958: iec958 data
+ * @iec958: iec958 data
  * @ctrl_lock: control lock
  */
 struct stm32_sai_sub_data {
@@ -1068,11 +1068,12 @@ static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
+	struct snd_kcontrol_new knew = iec958_ctls;
 
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
 		dev_dbg(&sai->pdev->dev, "%s: register iec controls", __func__);
-		return snd_ctl_add(rtd->pcm->card,
-				   snd_ctl_new1(&iec958_ctls, sai));
+		knew.device = rtd->pcm->device;
+		return snd_ctl_add(rtd->pcm->card, snd_ctl_new1(&knew, sai));
 	}
 
 	return 0;
-- 
2.20.1

