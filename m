Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A403DCA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D03208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572274617;
	bh=QYdHmgTyRVIVXwiClwdjXChz9pTZ8G+QcBmCt7N4dm0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Pjvzcl/fRl4TAxh2nmev0PtBNGYig44LqjEF2V907gS6rguPROPkxl8npQiIddY/p
	 wYfy3WGV6V5MMFS0ZhGSx+W9EiI7DEhHIcfrQajvMuhlI2VT+d8Xcipfi8r4PS2o3b
	 eDxiw+jL6jklu+vKFapBsBnchZbTU9eKH4+wCg2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390478AbfJ1O44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:56:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40078 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390428AbfJ1O4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=AFCr3rynD8V4Xu0si+l9pX7hWrr9yeLzz/mOG9Iw2wc=; b=G0w0eKogHrhP
        q8K6V3DrJgZC7vPrVoys+O16CN+nQi6vYsFPu8CvMZEwCu5kkSS4vSxjP3s7vUiAjyT4NK3LXZEyV
        jL/XjtfWFgEw2xMIxEP60y7Y8B3QdjH5BHZfNy8tuaf8+JJbATHxKGqcJUUP1mlVNnb1QD2L2Btzj
        J8NKk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iP6Rk-0008Rv-0Q; Mon, 28 Oct 2019 14:56:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6969827403EF; Mon, 28 Oct 2019 14:56:38 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     alsa-devel@alsa-project.org, "Cc:"@sirena.co.uk,
        "Cc:"@sirena.co.uk, emamd001@umn.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, kjlu@umn.edu,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        smccaman@umn.edu, Takashi Iwai <tiwai@suse.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: Applied "ASoC: SOF: Fix memory leak in sof_dfsentry_write" to the asoc tree
In-Reply-To: <20191027194856.4056-1-navid.emamdoost@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191028145638.6969827403EF@ypsilon.sirena.org.uk>
Date:   Mon, 28 Oct 2019 14:56:38 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: Fix memory leak in sof_dfsentry_write

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

From c0a333d842ef67ac04adc72ff79dc1ccc3dca4ed Mon Sep 17 00:00:00 2001
From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Sun, 27 Oct 2019 14:48:47 -0500
Subject: [PATCH] ASoC: SOF: Fix memory leak in sof_dfsentry_write

In the implementation of sof_dfsentry_write() memory allocated for
string is leaked in case of an error. Go to error handling path if the
d_name.name is not valid.

Fixes: 091c12e1f50c ("ASoC: SOF: debug: add new debugfs entries for IPC flood test")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Link: https://lore.kernel.org/r/20191027194856.4056-1-navid.emamdoost@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/debug.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 54cd431faab7..5529e8eeca46 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -152,8 +152,10 @@ static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
 	 */
 	dentry = file->f_path.dentry;
 	if (strcmp(dentry->d_name.name, "ipc_flood_count") &&
-	    strcmp(dentry->d_name.name, "ipc_flood_duration_ms"))
-		return -EINVAL;
+	    strcmp(dentry->d_name.name, "ipc_flood_duration_ms")) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (!strcmp(dentry->d_name.name, "ipc_flood_duration_ms"))
 		flood_duration_test = true;
-- 
2.20.1

