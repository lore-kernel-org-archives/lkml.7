Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21126C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFC820717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556220310;
	bh=ErdVazcKg+QDoFRHsDSgn+oYh+4HCb9kdnfZthFYi1U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=g3KXv767VBg31901t8B02QVCizR7z83mSf+hw3tUQDceGTjRLF/YV9D56/3SLueMm
	 JCrNnRTHySo0PLQP9C0GYOBUs9PqjwbxfORelnXRxRZlNuyob3nS5QOYCAjshAAxnK
	 aqG4Os95UK6lNMqriYTKbWDQKB733ujmIIE2FbtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfDYTZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:25:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49652 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbfDYTZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pT4ivZO2GuwNMUQ901+2XgWhRT/NBbQ/poic4mSUhgI=; b=m3EQjzy4cYgk
        89jFuIQQjWy4LyazBPlJXuXmf0I9U2CRO3d1k/uSimmIS9yccTpKHpMQ3WV8iwmt6GmMnuFyd4ugS
        tSPM4kqeWjburCkYzCpYJDb4qvRIXjOQDqg8Z3coM4zx7SlcN2Pxg1yJMKD64T/8D6Vz5KmY6XmWW
        LwVOY=;
Received: from 188.29.164.24.threembb.co.uk ([188.29.164.24] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJjzB-0004ZQ-IQ; Thu, 25 Apr 2019 19:24:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4FDE9441D3D; Thu, 25 Apr 2019 20:24:39 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Gyungoh Yoo <gyungoh@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: sky81452: Constify sky81452_reg_ops" to the regulator tree
In-Reply-To: <20190420072001.16900-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190425192439.4FDE9441D3D@finisterre.ee.mobilebroadband>
Date:   Thu, 25 Apr 2019 20:24:39 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: sky81452: Constify sky81452_reg_ops

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2

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

From fa20b70e4c847e761a426e67d6495c39e1453656 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 20 Apr 2019 15:20:00 +0800
Subject: [PATCH] regulator: sky81452: Constify sky81452_reg_ops

sky81452_reg_ops is never changed, make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/sky81452-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/sky81452-regulator.c b/drivers/regulator/sky81452-regulator.c
index 647860611916..eb2b60968a1a 100644
--- a/drivers/regulator/sky81452-regulator.c
+++ b/drivers/regulator/sky81452-regulator.c
@@ -34,7 +34,7 @@
 #define SKY81452_LEN	0x40
 #define SKY81452_LOUT	0x1F
 
-static struct regulator_ops sky81452_reg_ops = {
+static const struct regulator_ops sky81452_reg_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_linear_range,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
-- 
2.20.1

