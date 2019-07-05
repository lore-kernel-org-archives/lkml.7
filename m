Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88888C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 17:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6131220989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562347209;
	bh=EDp88yAFDNzcAA6bLc9AFR8eLogkbXSVaWjVvlCxNLk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Jtc4vJOCdCevsS2U7n8U0TfEKc/5MMsPd4jpJHFBL/tBDUE11gG6DppqhRM64A7+/
	 QVEYBYjEVes+tI4MKJlU8JQc4ZSNIfalZq7Jdw2wri4eq2StG1ZXaI01QPTXgD38td
	 bqcmyTVBb8AvOLo+QSx/8zLHtnWaCJbZDfIhDCHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfGERUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 13:20:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56370 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfGERUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 13:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ePFcoJ5m87EvMr2n+NPJawIqXaDiVgO7emTiCfYxa/c=; b=w5y81v1T0+ac
        1+ok1MB6hi0HaqCQBoU8h2Re9kCl/UXILOhp+D7a+371YTeKfoeEJYYTUuuej3O8vSmZUtn7cJW+O
        UpzJMk/gC9fH4J+I5X+xHd67jGerlq8mL3Byoq/sJwqmf98l0ACGA7PU4xbj5xOy4dXppQmoml5k7
        IhFzQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hjRsE-0004ZO-Uw; Fri, 05 Jul 2019 17:19:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 730AE2742A10; Fri,  5 Jul 2019 18:19:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: SOF: debug: fix possible memory leak in sof_dfsentry_write()" to the asoc tree
In-Reply-To: <20190705081637.157169-1-weiyongjun1@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190705171950.730AE2742A10@ypsilon.sirena.org.uk>
Date:   Fri,  5 Jul 2019 18:19:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: debug: fix possible memory leak in sof_dfsentry_write()

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

From b90bab3b1b1b6c56dd6f9d5c960932239f36f6d3 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Fri, 5 Jul 2019 08:16:37 +0000
Subject: [PATCH] ASoC: SOF: debug: fix possible memory leak in
 sof_dfsentry_write()

'string' is malloced in sof_dfsentry_write() and should be freed
before leaving from the error handling cases, otherwise it will cause
memory leak.

Fixes: 091c12e1f50c ("ASoC: SOF: debug: add new debugfs entries for IPC flood test")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20190705081637.157169-1-weiyongjun1@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 54bb53bfc81b..2388477a965e 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -162,7 +162,7 @@ static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
 	else
 		ret = kstrtoul(string, 0, &ipc_count);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/* limit max duration/ipc count for flood test */
 	if (flood_duration_test) {
@@ -191,7 +191,7 @@ static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
 				    "error: debugfs write failed to resume %d\n",
 				    ret);
 		pm_runtime_put_noidle(sdev->dev);
-		return ret;
+		goto out;
 	}
 
 	/* flood test */
-- 
2.20.1

