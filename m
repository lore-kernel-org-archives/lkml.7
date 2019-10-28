Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8C2CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F58821783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572274644;
	bh=xRrm6JBJeP+LcNvhoisJ2xn9IWWqH7oZwgPmf823Rn8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=aFs6BZ5KUnXnniktGwuJRwafJ5pacJ1lrbMGEnSFzULKFcxUpwHDnZZszwTLx3SkW
	 SX0jANqmpuxN2Y26fYMzjs2Jlikg3+3UyqMhI4h1j+7qMZYskW74XGl7B+4GDFZyEx
	 HCDDg4J+hB4bUMLilkQ1qwodGk0xehzlEmvt4q/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390552AbfJ1O5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:57:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39798 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbfJ1O4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=u+mJui0ruzCLEmUKsU0/VGpV9GrOClCKbHC9GKMJOjo=; b=gV2bpDY3iQO8
        S6FQqHkEOQBf2B2E2PJ9cmFjoHLPC8lJexj7PcHMUsMCkFDcca9420PkzP88ctRiDYwU86DV4Ddit
        6Yroml3b+C1UvHVqL4CWCrmhi1wjuYPm/yPCmckz5144wA8M51jO8MlyRia9MYudPziLAYcf0BIaG
        4IHsY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iP6Rp-0008TD-CN; Mon, 28 Oct 2019 14:56:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D037C27403EE; Mon, 28 Oct 2019 14:56:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: Release coupled_rdevs on regulator_init_coupling() error" to the regulator tree
In-Reply-To: <20191025002240.25288-1-digetx@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191028145644.D037C27403EE@ypsilon.sirena.org.uk>
Date:   Mon, 28 Oct 2019 14:56:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Release coupled_rdevs on regulator_init_coupling() error

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

From 26c2c997aa1a6c5522f6619910ba025e53e69763 Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Fri, 25 Oct 2019 03:22:39 +0300
Subject: [PATCH] regulator: core: Release coupled_rdevs on
 regulator_init_coupling() error

This patch fixes memory leak which should happen if regulator's coupling
fails to initialize.

Fixes: d8ca7d184b33 ("regulator: core: Introduce API for regulators coupling customization")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Link: https://lore.kernel.org/r/20191025002240.25288-1-digetx@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a46be221dbdc..51ce280c1ce1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5198,6 +5198,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	regulator_remove_coupling(rdev);
 	mutex_unlock(&regulator_list_mutex);
 wash:
+	kfree(rdev->coupling_desc.coupled_rdevs);
 	kfree(rdev->constraints);
 	mutex_lock(&regulator_list_mutex);
 	regulator_ena_gpio_free(rdev);
-- 
2.20.1

