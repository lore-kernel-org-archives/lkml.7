Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A6ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253F820673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571054737;
	bh=8oW9qJxoK84X3xLzy03pEXxCnHExkW1LeynhW8MlUjc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GoNd0QZTxnLhtT4MAD9dx/kRYaQ5FvqFCoW0Ie9vVF4MHt+knxl3PY0cKkFMB9ZtD
	 s64jtrjeNNCcYENwukbTsA7td1eHXXV9SoJDkbodSJVUgzta5b+NnsH5mMp9LjVeny
	 jAO7/Vfw1oNZUxV0/CZbvr/rkCpWcUU3CojupCho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfJNMFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:05:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35078 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbfJNMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=T57gFAQ2HL0OrNojxYT6RFsspIHb42s2lXo+OYKN3oU=; b=qn+OlOED4Bqj
        8Fv1zdAGKWWZJCAl7bXukw7iCCsS86IVOk6Mc697BCVuVlyI5GBGOmiMeEE9XE0ZIsA0ucaybSXqm
        nKaikyzKNfIiccC5JDwiL+VAehIFfeFonC2FpRJ8UOp9yVraGm0018xuq4i3Xl6EfsREU4OKoipca
        iOpJQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iJz5u-0007WM-UW; Mon, 14 Oct 2019 12:04:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D43862741EED; Mon, 14 Oct 2019 13:04:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        festevam@gmail.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com,
        Nicolin Chen <nicoleotsuka@gmail.com>, perex@perex.cz,
        timur@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_mqs: Move static keyword to the front of declarations" to the asoc tree
In-Reply-To: <20191011143538.15300-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191014120457.D43862741EED@ypsilon.sirena.org.uk>
Date:   Mon, 14 Oct 2019 13:04:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_mqs: Move static keyword to the front of declarations

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

From dd79841ca66ff509660880237dc286d7f116a766 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 11 Oct 2019 22:35:38 +0800
Subject: [PATCH] ASoC: fsl_mqs: Move static keyword to the front of
 declarations

gcc warn about this:

sound/soc/fsl/fsl_mqs.c:146:1: warning:
 static is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/20191011143538.15300-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_mqs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index f7fc44e8fb27..0c813a45bba7 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -143,7 +143,7 @@ static void fsl_mqs_shutdown(struct snd_pcm_substream *substream,
 				   MQS_EN_MASK, 0);
 }
 
-const static struct snd_soc_component_driver soc_codec_fsl_mqs = {
+static const struct snd_soc_component_driver soc_codec_fsl_mqs = {
 	.idle_bias_on = 1,
 	.non_legacy_dai_naming	= 1,
 };
-- 
2.20.1

