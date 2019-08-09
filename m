Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148D6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6AE208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 12:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565353939;
	bh=VbRlVSlGaqzv4dTOXhOD0Vh4dUZ/yRKiwjNvmYjRU/A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=VUjjQdCh1qIdug5b+eAu71BagVl7/EupKSD39iVb8Npg5+id+Ng+tETspViPFBbGH
	 bYDsH+9ND1To6/wWxYrLOqS2XhHy7sVzgAQCE9ZytYcHyasukMwOe4Fs6i7kS4NC9F
	 dpINP3KkMoIHajzSM/vAmpQSHFBbWGigvs985M98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407032AbfHIMcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 08:32:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59466 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407003AbfHIMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 08:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/jo88AcFDfqbdS1YL/mJqykjovRrReNV4GrM29uIo6I=; b=beh/h/nA91ib
        PMNIJTuxEbXDVpq+KGoMpQCkFasHwzcTy5iqXQohAtvZumX8+mBl+v2W8SEubU6osQU6bq7MT9T8y
        cLitK/M81arRm74Tq7h1CSTysPVZcDFPQLFHoA//YZ97ZjhG7CqsZUM8LQC7bJ6ALjVdRGqWpPH/e
        bNrLo=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hw43l-000618-2D; Fri, 09 Aug 2019 12:31:53 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6CEB82743057; Fri,  9 Aug 2019 13:31:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, Hulk Robot <hulkci@huawei.com>,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        rfontana@redhat.com, tiwai@suse.com
Subject: Applied "ASoC: ml26124: remove unused variable 'ngth'" to the asoc tree
In-Reply-To: <20190809082440.67412-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190809123152.6CEB82743057@ypsilon.sirena.org.uk>
Date:   Fri,  9 Aug 2019 13:31:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ml26124: remove unused variable 'ngth'

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

From 0fd70e22a0ffebd13028bf2c7da6b747070475bf Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 9 Aug 2019 16:24:40 +0800
Subject: [PATCH] ASoC: ml26124: remove unused variable 'ngth'

In file included from ./include/sound/tlv.h:10:0,
                 from sound/soc/codecs/ml26124.c:19:
sound/soc/codecs/ml26124.c:59:35: warning: ngth defined but not used [-Wunused-const-variable=]
 static const DECLARE_TLV_DB_SCALE(ngth, -7650, 150, 0);
                                   ^
./include/uapi/sound/tlv.h:64:15: note: in definition of macro SNDRV_CTL_TLVD_DECLARE_DB_SCALE
  unsigned int name[] = { \
               ^~~~
sound/soc/codecs/ml26124.c:59:14: note: in expansion of macro DECLARE_TLV_DB_SCALE
 static const DECLARE_TLV_DB_SCALE(ngth, -7650, 150, 0);
              ^~~~~~~~~~~~~~~~~~~~

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190809082440.67412-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ml26124.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index 3abd27893ce6..55823bc95d06 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -56,7 +56,6 @@ static const DECLARE_TLV_DB_SCALE(alclvl, -2250, 150, 0);
 static const DECLARE_TLV_DB_SCALE(mingain, -1200, 600, 0);
 static const DECLARE_TLV_DB_SCALE(maxgain, -675, 600, 0);
 static const DECLARE_TLV_DB_SCALE(boost_vol, -1200, 75, 0);
-static const DECLARE_TLV_DB_SCALE(ngth, -7650, 150, 0);
 
 static const char * const ml26124_companding[] = {"16bit PCM", "u-law",
 						  "A-law"};
-- 
2.20.1

