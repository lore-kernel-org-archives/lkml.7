Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD978C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B62216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565615411;
	bh=NJC7RxVutOjJ6ZDzweButGU0v8irF9j+XpVMBhdyERI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=hH+4irY0N2obzjLirkywFL5mxDsIVu1d/X8W+Ben+sYdyDGIEo4FfziW1jeZiwnr3
	 doYUKNgiIyGGxxBDCt8TNY0JEZIXDOsseHlOEXnQwvY+0kQTuhHJfgR/Y+S0QYDTQn
	 Phf85LoSdAla+QRuwYgzSELkLTkiBe+q1q7H5FZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfHLNKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:10:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40362 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfHLNKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZyTCBEw26HPO4hNsabNswLIYhe65sPxbGwi2SQZZZ1k=; b=aiVfOKiNbIvj
        /89trdewnMeO27dxlxDipw6Ex9acfpSGEi/y/nNnhK09Kbx8EaZ1n9QQZOT+H5XwbJfcVcmlb6UP0
        Cm+rDd7ibx881kw0wDaNSnb8Iq3Ce+8Wsx+5W+3zyP6iIrnUWL6NPkw3f25AMGjEcZhKzqhIb1/vS
        CtLuE=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxA5B-0001Mk-Se; Mon, 12 Aug 2019 13:09:53 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4D0E92740CED; Mon, 12 Aug 2019 14:09:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, kstewart@linuxfoundation.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: max98926: remove two unused variables" to the asoc tree
In-Reply-To: <20190808143215.65904-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190812130953.4D0E92740CED@ypsilon.sirena.org.uk>
Date:   Mon, 12 Aug 2019 14:09:53 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: max98926: remove two unused variables

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

From dbf0649f4340c8bb7d36b8d6255dba03ed6981e7 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 8 Aug 2019 22:32:15 +0800
Subject: [PATCH] ASoC: max98926: remove two unused variables

sound/soc/codecs/max98926.c:28:26: warning:
 max98926_dai_txt defined but not used [-Wunused-const-variable=]
sound/soc/codecs/max98926.c:23:27: warning:
 max98926_boost_current_txt defined but not used [-Wunused-const-variable=]

They are never used, so can be removd.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190808143215.65904-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98926.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 818c0301fb29..c4dfa8ab1d49 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -20,15 +20,6 @@ static const char * const max98926_boost_voltage_txt[] = {
 	"6.5V", "6.5V", "6.5V", "6.5V", "6.5V", "6.5V", "6.5V", "6.5V"
 };
 
-static const char * const max98926_boost_current_txt[] = {
-	"0.6", "0.8", "1.0", "1.2", "1.4", "1.6", "1.8", "2.0",
-	"2.2", "2.4", "2.6", "2.8", "3.2", "3.6", "4.0", "4.4"
-};
-
-static const char *const max98926_dai_txt[] = {
-	"Left", "Right", "LeftRight", "LeftRightDiv2",
-};
-
 static const char *const max98926_pdm_ch_text[] = {
 	"Current", "Voltage",
 };
-- 
2.20.1

