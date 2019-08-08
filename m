Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEC0C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1C22173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565296434;
	bh=mCipJ2+FlBNsyOpLvnPNK0m3RzC85jIj5e4eNWP5bfs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=nZjkNWL8B3RS9Ov57FfJym8e0ffEUkar5RWtw4elEKHM14uTluSo3AD3COXm+M52z
	 P22R6eg551fg8UuxXQh0BhrFSUl+u553lR6De+L2EPYyl+BR3lsicxNNjF699AYz7r
	 Ur8VQuX4Yyu6+klNTsOKR6t0WS7GUxYwNxt29kA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbfHHUdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:33:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59006 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389974AbfHHUdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MVpAPxBt8ZhswfIlLL1JU/jg2jSxi77lrappcNJH5Bk=; b=nQvyrWqmuFf1
        WIV5m3AVAX7ebPPun2VoxGfJLyfGTDPxBjHqqNxRV/IY4CsUw2VeE0TIsthdBWGH0bNNIIzRfig+V
        b8Nr2/thaX3B5GMYQW69wKLrmQW6QwcS68wvmRvWo8U2fEeSXqjpLiHK4PxVP2gihm/UJUGpzsc6i
        S7uWU=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hvp6S-00041B-4s; Thu, 08 Aug 2019 20:33:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6ED712742EDC; Thu,  8 Aug 2019 21:33:39 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        steven.eckhoff.opensource@gmail.com, tiwai@suse.com
Subject: Applied "ASoC: tscs454: remove unused variable 'PLL_48K_RATE'" to the asoc tree
In-Reply-To: <20190808032552.45360-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190808203339.6ED712742EDC@ypsilon.sirena.org.uk>
Date:   Thu,  8 Aug 2019 21:33:39 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tscs454: remove unused variable 'PLL_48K_RATE'

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

From 8e082d8f42fabf9a4a0708d8012f4995765478fc Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 8 Aug 2019 11:25:52 +0800
Subject: [PATCH] ASoC: tscs454: remove unused variable 'PLL_48K_RATE'

The global variable 'PLL_48K_RATE' is never used
so just remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190808032552.45360-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tscs454.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index 93d84e5ae2d5..c3587af9985c 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -22,7 +22,6 @@
 
 #include "tscs454.h"
 
-static const unsigned int PLL_48K_RATE = (48000 * 256);
 static const unsigned int PLL_44_1K_RATE = (44100 * 256);
 
 #define COEFF_SIZE 3
-- 
2.20.1

