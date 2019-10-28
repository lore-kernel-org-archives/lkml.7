Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E10CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06BA218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572274625;
	bh=gXZHEBtFXxpGRVdIN8wnrb1rJXESg9DHFUNQuioIchE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=k7DIgageSivV+6Z3xp/DCCWYcLkrAVYx3WjCs+2IcHlH71jOrT2wJYIUmc7BQ4kAY
	 j6o7bVZxn/d+oRGu341EBLFgvLXiu24I74rPYiV/C3jWv/9LIAxONgz/h4ISR3ZIKj
	 S9586K1SRc2pGg/88xBmjzNcaqSg/3zKwEjqhpfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390513AbfJ1O5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:57:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40268 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390502AbfJ1O5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pRAnZ2eosKV/53G9bqUjly+zJvMmzCGpbgurzDJUuFc=; b=ji8GRUakC0x3
        My3BXG8nqht1NWURYP4Hl6TLrXwU+YQJQtG1BZ97HpUaz0DgR5UWjv9SY44Yy/KwuFpDAejKo3hHh
        2130boS1xvfTbbKSPf/G1NXAijvKgw2nBNq0W+VUokakasfTmtqnI6lDnbLH6PMpRjyuNcgU3nNcv
        rz4rM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iP6Ri-0008Rf-UG; Mon, 28 Oct 2019 14:56:39 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5632E2740B7F; Mon, 28 Oct 2019 14:56:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        dannym@scratchpost.org, georgii.staroselskii@emlid.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, mripard@kernel.org,
        perex@perex.cz, tglx@linutronix.de, tiwai@suse.com, wens@csie.org,
        yuehaibing@huawei.com
Subject: Applied "ASoC: sunxi: sun4i-codec: remove unneeded semicolon" to the asoc tree
In-Reply-To: <20191025120801.16236-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191028145637.5632E2740B7F@ypsilon.sirena.org.uk>
Date:   Mon, 28 Oct 2019 14:56:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sunxi: sun4i-codec: remove unneeded semicolon

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

From 24d05966b560b88d37d90e64f018af2fed888104 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 25 Oct 2019 20:08:01 +0800
Subject: [PATCH] ASoC: sunxi: sun4i-codec: remove unneeded semicolon

remove unneeded semicolon.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20191025120801.16236-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index ee448d5e07a6..34f3e0be3058 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1442,7 +1442,7 @@ static struct snd_soc_card *sun8i_a23_codec_create_card(struct device *dev)
 	if (!aux_dev.dlc.of_node) {
 		dev_err(dev, "Can't find analog controls for codec.\n");
 		return ERR_PTR(-EINVAL);
-	};
+	}
 
 	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
 	if (!card->dai_link)
@@ -1480,7 +1480,7 @@ static struct snd_soc_card *sun8i_h3_codec_create_card(struct device *dev)
 	if (!aux_dev.dlc.of_node) {
 		dev_err(dev, "Can't find analog controls for codec.\n");
 		return ERR_PTR(-EINVAL);
-	};
+	}
 
 	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
 	if (!card->dai_link)
@@ -1518,7 +1518,7 @@ static struct snd_soc_card *sun8i_v3s_codec_create_card(struct device *dev)
 	if (!aux_dev.dlc.of_node) {
 		dev_err(dev, "Can't find analog controls for codec.\n");
 		return ERR_PTR(-EINVAL);
-	};
+	}
 
 	card->dai_link = sun4i_codec_create_link(dev, &card->num_links);
 	if (!card->dai_link)
-- 
2.20.1

