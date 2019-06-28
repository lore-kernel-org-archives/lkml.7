Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B42C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2928921773
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561740995;
	bh=dNGfyiep6Tvfrc8L2JkBGJvW5leicxYFG4iv70K8Bbk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=M3VYXsJ6w3onD0H7NNDtdEtbXA0KS7Nh9QAiAL3SN+7eYHtlE5JaI4Nir9ls2ibBg
	 O6OV8/V0SmLujgr2jmBFRpo/EBqZr5MxvfanE0pKP5v0zQ106r26nj4wdwjKmKl2Pk
	 fJsKUgbrBrbok9jP5OVrQ1v47Y/G7uCSm7UweeIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfF1Q4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:56:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42410 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfF1Q4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ecIA+WKfp5Dim18TsWkMPLdTo8UyAuEPpYiOnFVbOeE=; b=bgpibUjtu/Wu
        dqFPepZZSSjLL8ajojpvvnFlDJik2XlCFpoq3h4EesaqHWlKbN8/neuLZQ5Iu0gF4jVT/N1bD2zeV
        aZZ0OKrngbxsDJwahuyjET6lwbhNlKeKlZ9ZCceKovxUZdEiKmzfBl5qxlJ3ejE75xniMGGy+MNa7
        inXsg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hguAm-0007Bd-P3; Fri, 28 Jun 2019 16:56:28 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 3FB8B44004C; Fri, 28 Jun 2019 17:56:28 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: defer card registration if codec component is missing" to the asoc tree
In-Reply-To: <20190627121350.21027-2-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Message-Id: <20190628165628.3FB8B44004C@finisterre.sirena.org.uk>
Date:   Fri, 28 Jun 2019 17:56:28 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-core: defer card registration if codec component is missing

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From af18b13fedae4637b439d1265038b30929ca5a4c Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 27 Jun 2019 14:13:49 +0200
Subject: [PATCH] ASoC: soc-core: defer card registration if codec component is
 missing

Like cpus and platforms, defer sound card initialization if the codec
component is missing when initializing the dai_link

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 05cd710273b6..b5f3c09311c3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1071,12 +1071,20 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 				link->name);
 			return -EINVAL;
 		}
+
 		/* Codec DAI name must be specified */
 		if (!codec->dai_name) {
 			dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
 				link->name);
 			return -EINVAL;
 		}
+
+		/*
+		 * Defer card registration if codec component is not added to
+		 * component list.
+		 */
+		if (!soc_find_component(codec))
+			return -EPROBE_DEFER;
 	}
 
 	/*
-- 
2.20.1

