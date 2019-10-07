Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ECEECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1610821929
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570453411;
	bh=DhhP3yo515UYI9wdDYNBvs2jo/nLxQDqsnMYpWsmD3I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=kP//+WyHR6r1HL7Z7UnV24R3N53vLbxe9/25wPxCJGJXTAs7VZFq14N1RLum2Z2tz
	 WQy90NLpj8mJbU+a6TWPMDsCMzxrtwf0KnreQpSryH/wap/Vf6RYOQD7HfftofROih
	 0v00TB1vOB2Pf5f1SFqsWAjMfGlnDzGrcnJ1pDSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfJGNDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:03:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49470 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfJGND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=FXvSV90ORQdMKdGNJr1bG4jNw0ZoYKo8tYhWNdgsM1E=; b=THWXo8Rq7TGt
        02XMx0KXdK0VMe4ALiMPT583icsjkQOpUdjLZgye3FLvlAhyIRR+hAanzLWoVSwNbh7Awf4lW9/0I
        1aYHWZuYWuJdCvXfu0odTFZZtNlRv0ts3/oHlsXYAPipHHFPgWEktruoRmDyOqRrJjxXWa/gcvUGn
        Jodhs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHSfO-0003Qo-Td; Mon, 07 Oct 2019 13:03:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 8F1AB274124F; Mon,  7 Oct 2019 14:03:09 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        festevam@gmail.com, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Brown <broonie@kernel.org>,
        nicoleotsuka@gmail.com, perex@perex.cz, timur@kernel.org,
        tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_mqs: remove set but not used variable 'bclk'" to the asoc tree
In-Reply-To: <20191006105522.58560-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191007130309.8F1AB274124F@ypsilon.sirena.org.uk>
Date:   Mon,  7 Oct 2019 14:03:09 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_mqs: remove set but not used variable 'bclk'

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

From e9e8fc9ed63e7e0fb30f8612f628924fbd868467 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:55:22 +0800
Subject: [PATCH] ASoC: fsl_mqs: remove set but not used variable 'bclk'

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/fsl/fsl_mqs.c: In function fsl_mqs_hw_params:
sound/soc/fsl/fsl_mqs.c:54:6: warning: variable bclk set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20191006105522.58560-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_mqs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index c1619a553514..7b9cab3a62e7 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -51,10 +51,9 @@ static int fsl_mqs_hw_params(struct snd_pcm_substream *substream,
 	struct fsl_mqs *mqs_priv = snd_soc_component_get_drvdata(component);
 	unsigned long mclk_rate;
 	int div, res;
-	int bclk, lrclk;
+	int lrclk;
 
 	mclk_rate = clk_get_rate(mqs_priv->mclk);
-	bclk = snd_soc_params_to_bclk(params);
 	lrclk = params_rate(params);
 
 	/*
-- 
2.20.1

