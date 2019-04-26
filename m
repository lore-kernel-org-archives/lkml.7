Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86230C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578CD206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272057;
	bh=DdBSdm5TL3z05CQUTqpvTxj9GXse+B1DOXyKtHgnfnE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ZHMHrxKE8yY51qOuHgG4BDvcr9BPoEBwOgZAke1o9DHZYh2BtIYYAzRBnzp7B2OaE
	 9fqfBCph5Ze4INHmSkVeXgg1nipEyg9wux8UaAWqKEphhzUgPkuIncuFhXv/dEqqdk
	 XUDrSMcYmo0yaiR5S1Op7qQA94vBSZ+ZGe8KPQd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfDZJox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:44:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53304 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfDZJot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jtTH0TpgOBBUDtpKKnyrbTESZBwmjBlYdKBRoCyTaqs=; b=nrNftXcmqmih
        EiTQipIlUXf+XmhR+yk9m1Qo+OWxnZbzHzQo2UpSm+xsBiT79DzDGTtiLtikFvNChHtovatziZKea
        h7L9M7nLEHhm9fT2lNqz5e7WYF8+1YtfKJxp/S2WOgxnsSzm5IqwVeiuuSLpDi9dHgEVCt2UWwFnk
        I8ohc=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxPT-0003Pk-F0; Fri, 26 Apr 2019 09:44:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5E716441D3B; Fri, 26 Apr 2019 10:44:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: tps80031: Switch to SPDX identifier" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094446.5E716441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:44:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: tps80031: Switch to SPDX identifier

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From fd1a4da3bfd77d3fe15165948b948ead2b522c1c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 16 Apr 2019 18:17:29 +0800
Subject: [PATCH] regulator: tps80031: Switch to SPDX identifier

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/tps80031-regulator.c | 34 ++++++++------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/tps80031-regulator.c b/drivers/regulator/tps80031-regulator.c
index 8e65a13e2ef5..85a6a8ca8c1b 100644
--- a/drivers/regulator/tps80031-regulator.c
+++ b/drivers/regulator/tps80031-regulator.c
@@ -1,27 +1,13 @@
-/*
- * tps80031-regulator.c -- TI TPS80031 regulator driver.
- *
- * Regulator driver for TI TPS80031/TPS80032 Fully Integrated Power
- * Management with Power Path and Battery Charger.
- *
- * Copyright (c) 2012, NVIDIA Corporation.
- *
- * Author: Laxman Dewangan <ldewangan@nvidia.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
- * whether express or implied; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
- * 02111-1307, USA
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// tps80031-regulator.c -- TI TPS80031 regulator driver.
+//
+// Regulator driver for TI TPS80031/TPS80032 Fully Integrated Power
+// Management with Power Path and Battery Charger.
+//
+// Copyright (c) 2012, NVIDIA Corporation.
+//
+// Author: Laxman Dewangan <ldewangan@nvidia.com>
 
 #include <linux/delay.h>
 #include <linux/err.h>
-- 
2.20.1

