Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB27C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B3021906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930063;
	bh=cMjijrUVCSfMlVYSJ7SXFyQuD4UI6lIOTggP2kq1Mdg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JRr0qaslCe4dWch702RRqfMnXCvRaqykSHuabvkmY/MTOnFKzDEv8r+fbieeNTu58
	 ueR35gfz+QXs/p9F267dmpwhGlpGqZ61Ncdj4wH2hd0I1on/OOX4yDeErQxgpNez1z
	 y0B9XUAzwbYDuaK0dZX047mgSKDYcvNUIKKj0jV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbfJALlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:41:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40646 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbfJALlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tYidPqV9evGITvFKkefYkx+MVPV/Xz9CUR8kqXFz+Ew=; b=h2gfqiL6AL84
        v6pwTjwDOv2ZAoIuZcIr5WwnVFaft1ll5i3RA+foapZDUGA+mjAxOsw0uEF+imR5a1vdpRVCipmGO
        44SROcKViRDJOcju0+nsHcUyYWin4kYqXBHMFP0P7G1iLSGBHgJlWfdDQPKsJlg9A4o5h0dvp+REV
        Ypmn4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWN-0004Ss-NL; Tue, 01 Oct 2019 11:40:47 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2F9722742A30; Tue,  1 Oct 2019 12:40:47 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: stm32: sai: clean up indentation issue" to the asoc tree
In-Reply-To: <20190925112621.9312-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114047.2F9722742A30@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:47 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: clean up indentation issue

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

From 423013f824ab0590c229a107f21c54ac6596c4e1 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 25 Sep 2019 12:26:21 +0100
Subject: [PATCH] ASoC: stm32: sai: clean up indentation issue

There is a statement that is indented one level too deeply,
remove the extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190925112621.9312-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index ef4273361d0d..e20267504b16 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -100,7 +100,7 @@ static int stm32_sai_sync_conf_provider(struct stm32_sai_data *sai, int synco)
 		dev_err(&sai->pdev->dev, "%pOFn%s already set as sync provider\n",
 			sai->pdev->dev.of_node,
 			prev_synco == STM_SAI_SYNC_OUT_A ? "A" : "B");
-			stm32_sai_pclk_disable(&sai->pdev->dev);
+		stm32_sai_pclk_disable(&sai->pdev->dev);
 		return -EINVAL;
 	}
 
-- 
2.20.1

