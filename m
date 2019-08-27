Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64376C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3900C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566935911;
	bh=wqseN3azT/p2+/jiYFGxIzW5Jthg4eE16FhgLSr1q8k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=jfIAuMrBKLIB/8Wlvm47SoSMHFnJuBGL5JDm/uN1RH73dPrtzCYlJt+XP/cZwqzx7
	 2pdHbWi2PO8VQ2bkgHnAgrPZLV0u695dZTwQqayR1kkz6P0PQi9NCQIWgEaLuibx6Y
	 L1fJkWTsb5FRPUPIkiY+y+WhCy9Ci2LfCiw/LYas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfH0T6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:58:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48588 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfH0T63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SMpBfeT+YDhqJweugt2P+5XqpdoS58HJr3ntKvBbvys=; b=rdUvuQADUu8y
        YOUw8UIHoHFn8G2ft08JGELR9nsT16JBO8VGYyLpIUStf/q0X/H21ClcULYngx2hGb+8jVoGC+RFn
        YzC1KXA+TSxiH/nsO03vywzrxuMpm8PSdtBN5MqgdlK4GASE0/MZMDch0UJzjd55bY/Mjz0rvcqWd
        cWm0E=;
Received: from 188.28.18.107.threembb.co.uk ([188.28.18.107] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i2hbc-0001Cs-1g; Tue, 27 Aug 2019 19:58:16 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A25CFD02CE9; Tue, 27 Aug 2019 20:58:14 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        daniel.baluta@nxp.com, festevam@gmail.com,
        Hulk Robot <hulkci@huawei.com>, kernel@pengutronix.de,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tiwai@suse.com, yuehaibing@huawei.com
Subject: Applied "ASoC: SOF: imx8: Make some functions static" to the asoc tree
In-Reply-To: <20190823125939.30012-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190827195814.A25CFD02CE9@fitzroy.sirena.org.uk>
Date:   Tue, 27 Aug 2019 20:58:14 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: imx8: Make some functions static

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

From b9a4805a4ac1200326ee0c78df0ae3faceabad49 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 23 Aug 2019 20:59:39 +0800
Subject: [PATCH] ASoC: SOF: imx8: Make some functions static

Fix sparse warnings:

sound/soc/sof/imx/imx8.c:104:6: warning: symbol 'imx8_dsp_handle_reply' was not declared. Should it be static?
sound/soc/sof/imx/imx8.c:115:6: warning: symbol 'imx8_dsp_handle_request' was not declared. Should it be static?
sound/soc/sof/imx/imx8.c:336:5: warning: symbol 'imx8_get_bar_index' was not declared. Should it be static?
sound/soc/sof/imx/imx8.c:341:6: warning: symbol 'imx8_ipc_msg_data' was not declared. Should it be static?
sound/soc/sof/imx/imx8.c:348:5: warning: symbol 'imx8_ipc_pcm_params' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20190823125939.30012-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/imx/imx8.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index e502f584207f..640472491037 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -101,7 +101,7 @@ static int imx8_get_window_offset(struct snd_sof_dev *sdev, u32 id)
 	return MBOX_OFFSET;
 }
 
-void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
+static void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
 {
 	struct imx8_priv *priv = imx_dsp_get_data(ipc);
 	unsigned long flags;
@@ -112,7 +112,7 @@ void imx8_dsp_handle_reply(struct imx_dsp_ipc *ipc)
 	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
 }
 
-void imx8_dsp_handle_request(struct imx_dsp_ipc *ipc)
+static void imx8_dsp_handle_request(struct imx_dsp_ipc *ipc)
 {
 	struct imx8_priv *priv = imx_dsp_get_data(ipc);
 
@@ -333,21 +333,21 @@ static int imx8_remove(struct snd_sof_dev *sdev)
 }
 
 /* on i.MX8 there is 1 to 1 match between type and BAR idx */
-int imx8_get_bar_index(struct snd_sof_dev *sdev, u32 type)
+static int imx8_get_bar_index(struct snd_sof_dev *sdev, u32 type)
 {
 	return type;
 }
 
-void imx8_ipc_msg_data(struct snd_sof_dev *sdev,
-		       struct snd_pcm_substream *substream,
-		       void *p, size_t sz)
+static void imx8_ipc_msg_data(struct snd_sof_dev *sdev,
+			      struct snd_pcm_substream *substream,
+			      void *p, size_t sz)
 {
 	sof_mailbox_read(sdev, sdev->dsp_box.offset, p, sz);
 }
 
-int imx8_ipc_pcm_params(struct snd_sof_dev *sdev,
-			struct snd_pcm_substream *substream,
-			const struct sof_ipc_pcm_params_reply *reply)
+static int imx8_ipc_pcm_params(struct snd_sof_dev *sdev,
+			       struct snd_pcm_substream *substream,
+			       const struct sof_ipc_pcm_params_reply *reply)
 {
 	return 0;
 }
-- 
2.20.1

