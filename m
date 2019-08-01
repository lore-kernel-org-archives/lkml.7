Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF9CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0230B206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564665084;
	bh=zEjKNCwLhLZs6xhI2KNvqf/LEzX4r37swN4YW6TmewI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=s7B8V6Npkz62iE7fj6do7Ck7k0rlmtJN+zhi44kdiFbDPFzqlHUU3BFwo7rUlA85d
	 2nzFk4w7uAJVhXage+Pvl2zZdtH60/tIEVLmOL1+4QhvW+lLSlHElR0baFcRxoRjJD
	 c81DqeyZZzseE+DnZBJt28+CZT3v7EcmyazvCqeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbfHANLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:11:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731656AbfHANKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1XTmM3uejsE/Bu0l2+bTtFtXWG9tBVr4XVnGjE0EpVE=; b=hkvWHyr6Pj2k
        RQFahO4YtkOwThiLQVpOJBOYw7UDIk+oplNRl/mXz9C/mPmNUcACRB/zkqRk86tyWWtndtJLZHLGU
        oqniujsOKD6Ce7PZpoc9LL2UeE+/WYtd6QibDoaExLBV1EL7aaJOrsHWI/kd5prYjj41H8IC32nel
        6aIMs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htAqu-0004im-FJ; Thu, 01 Aug 2019 13:10:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3CC712742C48; Thu,  1 Aug 2019 14:10:39 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Jun Nie <jun.nie@linaro.org>, kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: zx-tdm: remove redundant assignment to ts_width on error return path" to the asoc tree
In-Reply-To: <20190731223234.16153-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190801131039.3CC712742C48@ypsilon.sirena.org.uk>
Date:   Thu,  1 Aug 2019 14:10:39 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: zx-tdm: remove redundant assignment to ts_width on error return path

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

From f24e41d3d04f326613d8a7ebecf72c3019826f71 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 31 Jul 2019 23:32:34 +0100
Subject: [PATCH] ASoC: zx-tdm: remove redundant assignment to ts_width on
 error return path

The value assigned to ts_width is never read on the error return path
so the assignment is redundant and can be removed.  Remove it.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190731223234.16153-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/zx-tdm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/zte/zx-tdm.c b/sound/soc/zte/zx-tdm.c
index 5e877fe9ba7b..0e5a05b25a77 100644
--- a/sound/soc/zte/zx-tdm.c
+++ b/sound/soc/zte/zx-tdm.c
@@ -211,7 +211,6 @@ static int zx_tdm_hw_params(struct snd_pcm_substream *substream,
 		ts_width = 1;
 		break;
 	default:
-		ts_width = 0;
 		dev_err(socdai->dev, "Unknown data format\n");
 		return -EINVAL;
 	}
-- 
2.20.1

