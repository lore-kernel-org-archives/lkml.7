Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9C7C004C9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB23208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763507;
	bh=3w7Sxuhq6uUJtqJi1NGUsChHu2DJW2I1rVxiJz5+OYU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BOYn09qwFS/Xd2hu9othuAmFlWbUytm6CEpAUqVy+OIdwGUO9F7EpCQ2U7Xf64Z7J
	 U8Rtgnljig23B5W+RknUI+OVQLQmKqzIIqhnaRhkCFN+8rdeo75h/iJuuH6LKcrZiT
	 q6qCWR1v6phqDjnSW6pwFYwgW9631x2EkMyR4iBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEBCST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:18:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54858 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfEBCSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qPjR5TzRDbnAqxV3DwfYDMNhhBwZAe2KIxcyy2P9zos=; b=h10UDky+3huF
        btSF4G/2IKX2b6vivJBPW/IGONFd3A3bVh0bZ/vrZHQWUs0DuB+dp7Pg3IovUUy5dbvhXvvqcDFdg
        YvWf+WOdz29/LdR2ZxTvxxY9fovVeYIUzc2vfGqVu3jxivs/sSwjSnfksyMeeyAcaqSzUuLvnCf/S
        HNOiI=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1IT-0005pn-MY; Thu, 02 May 2019 02:18:06 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 767DF441D3F; Thu,  2 May 2019 03:18:02 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     alsa-devel@alsa-project.org, Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: sprd: Fix to use list_for_each_entry_safe() when delete items" to the asoc tree
In-Reply-To: <20190429123713.64280-1-weiyongjun1@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190502021802.767DF441D3F@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:02 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sprd: Fix to use list_for_each_entry_safe() when delete items

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From 81a812c98b6eda7e3101305d57354433e3edc541 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 29 Apr 2019 12:37:13 +0000
Subject: [PATCH] ASoC: sprd: Fix to use list_for_each_entry_safe() when delete
 items

Since we will remove items off the list using list_del() we need
to use a safe version of the list_for_each_entry() macro aptly named
list_for_each_entry_safe().

Fixes: d7bff893e04f ("ASoC: sprd: Add Spreadtrum multi-channel data transfer support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/sprd-mcdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
index e9318d7a4810..7448015a4935 100644
--- a/sound/soc/sprd/sprd-mcdt.c
+++ b/sound/soc/sprd/sprd-mcdt.c
@@ -978,12 +978,12 @@ static int sprd_mcdt_probe(struct platform_device *pdev)
 
 static int sprd_mcdt_remove(struct platform_device *pdev)
 {
-	struct sprd_mcdt_chan *temp;
+	struct sprd_mcdt_chan *chan, *temp;
 
 	mutex_lock(&sprd_mcdt_list_mutex);
 
-	list_for_each_entry(temp, &sprd_mcdt_chan_list, list)
-		list_del(&temp->list);
+	list_for_each_entry_safe(chan, temp, &sprd_mcdt_chan_list, list)
+		list_del(&chan->list);
 
 	mutex_unlock(&sprd_mcdt_list_mutex);
 
-- 
2.20.1

