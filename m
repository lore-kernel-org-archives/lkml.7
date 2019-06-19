Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B4CC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604E02084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560946336;
	bh=TMwJ26zRGdF5jTqdj2n57DToxLmfRu6Mk4q6KOGG5fM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nUHpDnGzCFPXA/9v1onBamvRoNMSWePxPp9HPCi5G+DVUtOU1hDs/ICUBbV7mPHdh
	 /N/0oUYXwR4aUES2yMDcW0Vi/Z3+DemKlhBhDHOUHU2QG0D/s1+CvuhImmQDTcffLj
	 RrR3KrBpEnPnUeGxi5BF8zJ9NqTOFeOASLR9+SFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbfFSMMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:12:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47274 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfFSMMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KsVUVPFQSt4YdSE0JrBFYWec/Nl7s39JWoWi0hS5mGo=; b=Gzud2BYECkQY
        UUEpjnMelyyubd5o1uU9C2CHaHEB+AvoqYdaZOlep0ECsp7VtB2vPpvrdeAEfbWAc8N457ugSGxsj
        FY2t6vPNpkgsZGcl63Mao4kvE7OvrGaJ56GU084JEdo9xvDXQ6v15mKIfUYEEwvMP7NVhVOQsRUVB
        Vwb8w=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdZRd-0007Ci-4L; Wed, 19 Jun 2019 12:12:05 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 933A144004F; Wed, 19 Jun 2019 13:12:04 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: qcom: common: Fix NULL pointer in of parser" to the asoc tree
In-Reply-To: <20190618052813.32523-1-bjorn.andersson@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190619121204.933A144004F@finisterre.sirena.org.uk>
Date:   Wed, 19 Jun 2019 13:12:04 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qcom: common: Fix NULL pointer in of parser

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

From 16395ceee11f8f8af764bac76adc20a43ba1a153 Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Mon, 17 Jun 2019 22:28:13 -0700
Subject: [PATCH] ASoC: qcom: common: Fix NULL pointer in of parser

A snd_soc_dai_link_component is allocated and associated with the first
link, so when the code tries to assign the of_node of the second link's
"cpu" member it dereferences a NULL pointer.

Fix this by moving the allocation and assignement of
snd_soc_dai_link_components into the loop, giving us one pair per link.

Fixes: 1e36ea360ab9 ("ASoC: qcom: common: use modern dai_link style")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/common.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index c7a878507220..97488b5cc515 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -42,17 +42,17 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	card->num_links = num_links;
 	link = card->dai_link;
 
-	dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
-	if (!dlc)
-		return -ENOMEM;
+	for_each_child_of_node(dev->of_node, np) {
+		dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
+		if (!dlc)
+			return -ENOMEM;
 
-	link->cpus	= &dlc[0];
-	link->platforms	= &dlc[1];
+		link->cpus	= &dlc[0];
+		link->platforms	= &dlc[1];
 
-	link->num_cpus		= 1;
-	link->num_platforms	= 1;
+		link->num_cpus		= 1;
+		link->num_platforms	= 1;
 
-	for_each_child_of_node(dev->of_node, np) {
 		cpu = of_get_child_by_name(np, "cpu");
 		platform = of_get_child_by_name(np, "platform");
 		codec = of_get_child_by_name(np, "codec");
-- 
2.20.1

