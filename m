Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D22C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFC624AEC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559660365;
	bh=Kn6WIdJTnDo8Mrp6WEzeHOrO7ROabhyjdCHg6Iee8PY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2fWypGh/j8aUdKYW/DNGK/5gBVf0iXqtUozE+iP/WNb+il3gro5RXZgE0zb8UbiSI
	 9aPpooNx0rXMRW1hBKG8zZ2CsiN9SsQscwo51GntxIrI1JbmnyRKfZWTPSwz/EaxKr
	 CbQ1mNB0NaAd02VUnCLtfqhSqSbPO2srRB6fKPEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfFDO7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:59:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49118 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfFDO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=H/ZcNeXJodL5Cb2bnUP5HmMZO4APpeQuHpnxJOQLxfk=; b=whxSdku8q/zL
        lOLDiPZC2Yeb3aEsSRQyxXApgSYlPeIxbaBAg/2QQ2J/tHSTd5cHMjOFOuRulT2I9DIS1UkAde92w
        fuPcrjbaZ3+dfqvYA8W4HtR0yw/lZDy7rpkTeLNCXOhMxOQjfbgB/nIpvTAxzUCG8hIwO3qXPODa0
        1fd1M=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYAtw-0006Eg-SR; Tue, 04 Jun 2019 14:59:01 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5CA98440046; Tue,  4 Jun 2019 15:59:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, kaichieh.chuang@mediatek.com,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: mediatek: Make some symbols static" to the asoc tree
In-Reply-To: <20190529150437.19004-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190604145900.5CA98440046@finisterre.sirena.org.uk>
Date:   Tue,  4 Jun 2019 15:59:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: Make some symbols static

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

From 52194513ba1388443a067cee9606d6fe27e7650e Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 29 May 2019 23:04:37 +0800
Subject: [PATCH] ASoC: mediatek: Make some symbols static

Fix sparse warnings:

sound/soc/mediatek/common/mtk-btcvsd.c:410:5: warning: symbol 'mtk_btcvsd_write_to_bt' was not declared. Should it be static?
sound/soc/mediatek/common/mtk-btcvsd.c:698:9: warning: symbol 'mtk_btcvsd_snd_read' was not declared. Should it be static?
sound/soc/mediatek/common/mtk-btcvsd.c:779:9: warning: symbol 'mtk_btcvsd_snd_write' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index bd55c546e790..c7a81c4be068 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -407,11 +407,11 @@ static int mtk_btcvsd_read_from_bt(struct mtk_btcvsd_snd *bt,
 	return 0;
 }
 
-int mtk_btcvsd_write_to_bt(struct mtk_btcvsd_snd *bt,
-			   enum bt_sco_packet_len packet_type,
-			   unsigned int packet_length,
-			   unsigned int packet_num,
-			   unsigned int blk_size)
+static int mtk_btcvsd_write_to_bt(struct mtk_btcvsd_snd *bt,
+				  enum bt_sco_packet_len packet_type,
+				  unsigned int packet_length,
+				  unsigned int packet_num,
+				  unsigned int blk_size)
 {
 	unsigned int i;
 	unsigned long flags;
@@ -695,9 +695,9 @@ static int wait_for_bt_irq(struct mtk_btcvsd_snd *bt,
 	return 0;
 }
 
-ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
-			    char __user *buf,
-			    size_t count)
+static ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
+				   char __user *buf,
+				   size_t count)
 {
 	ssize_t read_size = 0, read_count = 0, cur_read_idx, cont;
 	unsigned int cur_buf_ofs = 0;
@@ -776,9 +776,9 @@ ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
 	return read_count;
 }
 
-ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
-			     char __user *buf,
-			     size_t count)
+static ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
+				    char __user *buf,
+				    size_t count)
 {
 	int written_size = count, avail = 0, cur_write_idx, write_size, cont;
 	unsigned int cur_buf_ofs = 0;
-- 
2.20.1

