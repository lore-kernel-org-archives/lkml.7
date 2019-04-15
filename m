Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E41C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2018620833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555318472;
	bh=7E/VefCc5pwp8P1BeDe6bfKJsgWGB8S0+ujmuK0YILk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=LWKY9HTpMov3IcBORNrfpLzSrx4fVbErObRIL1XPMrTT8VX8js6gus0LLB3Nxb0Lg
	 UO0ZtfRWvga1JX54z+Tw78XX+ZJrKM9B3QlmVMC293BibQPVL4Pa8wvaOF3VX5sN/E
	 uVf/Cvcv39DVausBhqLIebdtpmsHcQIX3DLPImDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfDOIya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:54:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35610 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=T3ldRSSiIzByRj5eWFtv0cqvlSVqiDzlzfyv7MpBxpM=; b=bsNozHXb6IU7
        52aNFXO8azrbFfRJpv9a5H3Y9c2XRTAxgRzF3UqWk4a1HO5n1yUEu7uPsvdUd5LYi7NmqFkO/yvzT
        2GvyEphG3pOWhX3omzVgAKPpIJzpFALLsWQjdmtpPQCOvPV1PpTY+H3Bd6glYwGIYOsino7Snfxv+
        DM2eY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hFxMr-0007j7-NM; Mon, 15 Apr 2019 08:53:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 212661127A64; Mon, 15 Apr 2019 09:53:32 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Bengt Jonsson <bengt.g.jonsson@stericsson.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab8500-ext: Constify ab8500_ext_regulator_ops" to the regulator tree
In-Reply-To: <20190412140658.11754-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190415085332.212661127A64@debutante.sirena.org.uk>
Date:   Mon, 15 Apr 2019 09:53:32 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab8500-ext: Constify ab8500_ext_regulator_ops

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

From 8e5be4f7e142daa47303ee8238b891833024e7df Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 12 Apr 2019 22:06:56 +0800
Subject: [PATCH] regulator: ab8500-ext: Constify ab8500_ext_regulator_ops

ab8500_ext_regulator_ops never need to be modified, make it const so
compiler can put it to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab8500-ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index f232a7a90fd5..95704446d89e 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -718,7 +718,7 @@ static int ab8500_ext_list_voltage(struct regulator_dev *rdev,
 	return -EINVAL;
 }
 
-static struct regulator_ops ab8500_ext_regulator_ops = {
+static const struct regulator_ops ab8500_ext_regulator_ops = {
 	.enable			= ab8500_ext_regulator_enable,
 	.disable		= ab8500_ext_regulator_disable,
 	.is_enabled		= ab8500_ext_regulator_is_enabled,
-- 
2.20.1

