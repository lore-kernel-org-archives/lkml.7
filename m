Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C86C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A8820717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220335;
	bh=8/UL2SzB5dfTGCOYMEwzw+35N9x4hjGA99v69n3xvQU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wUxNB6oGDBY2S/AXOsLXDi9tINcR3/7eUvhNA5VW3SKW+6J3X3LaWGu10O6QtIgGJ
	 nmCMYe9yA8I6cczFTrG0kTT1J3YSAZqLNlfq7GcWqES/30E+nSy1dm8BDghoRShyMH
	 7qHmad2phIiZWWYoXe0THCVdhGNJQu+kiqsTqG9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbfDYTZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:25:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49382 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfDYTYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yfFCeq4yV0ETcpTbhXvGa9QGBb+TApD4rEysij+3cPs=; b=Q+S5QopSWbc2
        ksWeHKD1ljA2vXTRFw44Gih73Cxj3m1HB82hr0CHlOwGCG30cA/o9yUFU/L3LqnZk82URtjC6rSXG
        wY1biuXPwPR8kne4VvR+v92kXZ2WfB868/5/Pj/BeybIGFyQbLaHwbRVqPm1OoZ84Z786ZQ5z6Whu
        Qv1KA=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJjz2-0004Yt-CU; Thu, 25 Apr 2019 19:24:36 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5730D441D3B; Thu, 25 Apr 2019 20:24:35 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Alexandre@sirena.org.uk, alsa-devel@alsa-project.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: stm32: i2s: return the get_irq error" to the asoc tree
In-Reply-To: <1556119724-9873-1-git-send-email-fabien.dessenne@st.com>
X-Patchwork-Hint: ignore
Message-Id: <20190425192435.5730D441D3B@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:24:35 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: i2s: return the get_irq error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

From 0bbf4084e0cfbbbff8673f3b9867778d5d4b1d6f Mon Sep 17 00:00:00 2001
From: Fabien Dessenne <fabien.dessenne@st.com>
Date: Wed, 24 Apr 2019 17:28:44 +0200
Subject: [PATCH] ASoC: stm32: i2s: return the get_irq error

During probe, return the "get_irq" error value instead of -ENOENT. This
allows the driver to be deferred probed if needed.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 8968458eec62..e707d28cb203 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -845,8 +845,9 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	/* Get irqs */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
-		return -ENOENT;
+		if (irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+		return irq;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, IRQF_ONESHOT,
-- 
2.20.1

