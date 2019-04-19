Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A897C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD619222E8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698055;
	bh=8Mnvk/UwczpcMK9A69HTFt5D0acY5JPGIeocDIVjjzk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=neLIAHP30wks4Fw8EYGgsiyJX0NaP2Ho1ZHqjUvUZlm6GaeAlkwnZvDOb0ToKMPaM
	 R7aGNt8UNjGin/NfQs5uqkMLxeepJckNFQl6TY4VZeRYavI8q1QF5HfwYNU6mkRp06
	 bP9CBeNOwGb11aSue9PJXinB3cwwGmQroS3pyobc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDSSUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:20:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38528 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfDSSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=f2OggTjbQFsksjzNAmXKhmBiR/H5MgdLPi1h3YYXEKo=; b=lzrmXD0nk+cN
        80On/r1ZpSF84o904Tn3Ibex9iBYXDwRzwaFeAWWnKcJprfuo+2SCmzYWxJDmx+Jf9KohxrmkLS6R
        udlgYzz47PElllLv98ikAfpuspVuc5W1dwiTiFR7I5nZMnnUeQVkh0MtyFT5prx/B+Y0fQ0Mv7eSZ
        l5o9Y=;
Received: from 188.29.164.213.threembb.co.uk ([188.29.164.213] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hHW9R-0008Vb-A7; Fri, 19 Apr 2019 16:14:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id ED76A441D3C; Fri, 19 Apr 2019 17:14:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        liam.r.girdwood@linux.intel.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        tiwai@suse.com, yang.jie@linux.intel.com
Subject: Applied "ASoC: Intel: Haswell: Remove set but not used variable 'stage_type'" to the asoc tree
In-Reply-To: <20190418024848.39112-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190419161405.ED76A441D3C@finisterre.ee.mobilebroadband>
Date:   Fri, 19 Apr 2019 17:14:05 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: Haswell: Remove set but not used variable 'stage_type'

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

From 479879701758206a2cc75176119fcc9dacc40846 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 18 Apr 2019 10:48:48 +0800
Subject: [PATCH] ASoC: Intel: Haswell: Remove set but not used variable
 'stage_type'

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/intel/haswell/sst-haswell-ipc.c: In function 'hsw_stream_message':
sound/soc/intel/haswell/sst-haswell-ipc.c:669:29: warning: variable 'stage_type' set but not used [-Wunused-but-set-variable]

It is never used since introduction in
commit ba57f68235cf ("ASoC: Intel: create haswell folder and move haswell platform files in")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 31fcdf12c67d..74acf9c65161 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -345,11 +345,6 @@ static inline u32 msg_get_stream_type(u32 msg)
 	return (msg & IPC_STR_TYPE_MASK) >>  IPC_STR_TYPE_SHIFT;
 }
 
-static inline u32 msg_get_stage_type(u32 msg)
-{
-	return (msg & IPC_STG_TYPE_MASK) >>  IPC_STG_TYPE_SHIFT;
-}
-
 static inline u32 msg_get_stream_id(u32 msg)
 {
 	return (msg & IPC_STR_ID_MASK) >>  IPC_STR_ID_SHIFT;
@@ -666,13 +661,12 @@ static int hsw_module_message(struct sst_hsw *hsw, u32 header)
 
 static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
 {
-	u32 stream_msg, stream_id, stage_type;
+	u32 stream_msg, stream_id;
 	struct sst_hsw_stream *stream;
 	int handled = 0;
 
 	stream_msg = msg_get_stream_type(header);
 	stream_id = msg_get_stream_id(header);
-	stage_type = msg_get_stage_type(header);
 
 	stream = get_stream_by_id(hsw, stream_id);
 	if (stream == NULL)
-- 
2.20.1

