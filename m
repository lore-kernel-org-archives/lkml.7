Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C5DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C8721D6C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568023683;
	bh=Hk2n2dKBxfs4zAuUlVbwnSInRmDdHdg3lRHxTLXj9Xs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ow+X3E32iA/JL2paQHQUiRJypphCn7JPQKI0G9OV6e48/sPSavI1JaPydQkpheK4Q
	 HLHT8FpMRQWnNQsxqAtCM4dfnaNe6tMS8OPPeqG1XiIPnvzLLMWuwpbAYepnv673GY
	 8Y7/aEpZVA9P8JVv0MULDP5ut5Jv9f4OnKUD3PDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390392AbfIIKIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:08:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56124 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390204AbfIIKH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=7w2LNq0l01blkf8Ovxz57vph2tfWB91hAoQ/F6ph7eU=; b=TsNquHlerb4i
        uZmGHimJ9xuqN1MjJBI5Byyj2RozKhiZnG0VQXsDJx5d9G5C8Uhdopl5YxBSAiEdOIckgXWFosGPI
        w1rr2v4lYTlJ8RShwh8ZclKRTnlq1GomakQszRtgWUpiINMi4eUiyherUDNg12B9OUYZlt74goMBh
        DpNpY=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7GZv-0001tn-AF; Mon, 09 Sep 2019 10:07:23 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id B5A28D02D1F; Mon,  9 Sep 2019 11:07:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Milo Kim <milo.kim@ti.com>
Subject: Applied "regulator: lp8788-ldo: make array en_mask static const, makes object smaller" to the regulator tree
In-Reply-To: <20190906130632.6709-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190909100722.B5A28D02D1F@fitzroy.sirena.org.uk>
Date:   Mon,  9 Sep 2019 11:07:22 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lp8788-ldo: make array en_mask static const, makes object smaller

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

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

From 6cbe29c92311ea6ef67a7eac2bc089357412973b Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 6 Sep 2019 14:06:32 +0100
Subject: [PATCH] regulator: lp8788-ldo: make array en_mask static const, makes
 object smaller

Don't populate the array en_mask on the stack but instead make it
static const. Makes the object code smaller by 87 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  12967	   3408	      0	  16375	   3ff7	drivers/regulator/lp8788-ldo.o

After:
   text	   data	    bss	    dec	    hex	filename
  12816	   3472	      0	  16288	   3fa0	drivers/regulator/lp8788-ldo.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190906130632.6709-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lp8788-ldo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index 1b00f3638996..00e9bb92c326 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -464,7 +464,7 @@ static int lp8788_config_ldo_enable_mode(struct platform_device *pdev,
 {
 	struct lp8788 *lp = ldo->lp;
 	enum lp8788_ext_ldo_en_id enable_id;
-	u8 en_mask[] = {
+	static const u8 en_mask[] = {
 		[EN_ALDO1]   = LP8788_EN_SEL_ALDO1_M,
 		[EN_ALDO234] = LP8788_EN_SEL_ALDO234_M,
 		[EN_ALDO5]   = LP8788_EN_SEL_ALDO5_M,
-- 
2.20.1

