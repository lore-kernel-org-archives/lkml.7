Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1518120684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565615408;
	bh=I1ybbE5jD7ha7Fp6YOnzcoHSwjzeXL6DBEOJ0DP55sw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=s19P5IxZmeAv9tkIDQyqHjyu2/+zOo9tAudhAwDDRb/rvOYa1bnv96sx70f5hg8av
	 yIjnhEsnM7YA8b7qtQu+dJuc/iJgt0+kIEVwf8ePPR2PS6xwfG1+RXb/wIjgpUJ1fK
	 EHAAhgx+vGQIjOug8N2h73hcqhlPrIKxrdjHv65A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfHLNKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:10:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40156 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfHLNKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=G+NhmvpynvEkdk6GHQHvKh69Oy4SC2WPQyF4nmoq5Wc=; b=KdB9P4pBQa3j
        VwGjSS0Bhi6Xs/J3wrSyEU5sbYJ7siMRamPSMiflutt0FLjkua/MF9eFOuyHy+uY8sy2OCMD6nebx
        aS38FVV9sUi7yi9FWXRZ0Ltk33x3pjrCIcDOUgMCmcD9wlV/EjDjMsVJwEQF7u06xApWjSNbuvSoe
        XxhDk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxA59-0001MA-LS; Mon, 12 Aug 2019 13:09:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2CA162740CBD; Mon, 12 Aug 2019 14:09:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, mark.rutland@arm.com,
        nicoleotsuka@gmail.com, Nicolin Chen <nicoleotsuka@gmail.com>,
        robh+dt@kernel.org, timur@kernel.org, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_esai: Add compatible string for imx6ull" to the asoc tree
In-Reply-To: <1565346467-5769-1-git-send-email-shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190812130951.2CA162740CBD@ypsilon.sirena.org.uk>
Date:   Mon, 12 Aug 2019 14:09:51 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_esai: Add compatible string for imx6ull

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

From 9c2806c4941641a6c75736f8c4303c89d2013cc4 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Fri, 9 Aug 2019 18:27:46 +0800
Subject: [PATCH] ASoC: fsl_esai: Add compatible string for imx6ull

Add compatible string for imx6ull, from imx6ull platform,
the issue of channel swap after xrun is fixed in hardware.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Link: https://lore.kernel.org/r/1565346467-5769-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 5832144beb9f..a78e4ab478df 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -1049,6 +1049,7 @@ static int fsl_esai_remove(struct platform_device *pdev)
 static const struct of_device_id fsl_esai_dt_ids[] = {
 	{ .compatible = "fsl,imx35-esai", },
 	{ .compatible = "fsl,vf610-esai", },
+	{ .compatible = "fsl,imx6ull-esai", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
-- 
2.20.1

