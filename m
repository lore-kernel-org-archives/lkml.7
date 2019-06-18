Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC543C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DF520863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560882808;
	bh=aJ3fDnOzTltwrapycAyk9bRzJi0sGHVE33oRqW3D7RA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=cLOOemK5wk+U2DX/k/xmemxhvIrqEB/5FDqSXnOogfN6IOvsVNFBWUdMJUvG0KFZA
	 jqHcBLVNzMIlqDMrjkoDOLN+A7F0qka9WnBEQAi1EHzr5jsRsZjaVkls5x2/xp9M/O
	 zwqqGh8rv2ACiGJMh8EsynqLQmE10LfQKIjKZdzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfFRSd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:33:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47568 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbfFRSdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TPsujIWTKKE1424oPCy7XooqmWFVUeyhp6UwM7y6KlE=; b=r7yXU3t3v2Ej
        X8PNK1F9ZGRCM5GtXrRTJWqBox/dfKlcpmqa0PqVwBLnlGSLEpB3OhUkAz7e0VEcQ2Yv7zgSXqpQe
        yv3sdGd8EIxZNWNgw7/gko1jP3I6bqunftZKq6MSBo6ryWspMojiek8dPE3vvu716ajOZeBgSfEpY
        5q2us=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdIv5-0005LO-Vh; Tue, 18 Jun 2019 18:33:24 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 78864440046; Tue, 18 Jun 2019 19:33:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Make entire header comment C++ style" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190618183323.78864440046@finisterre.sirena.org.uk>
Date:   Tue, 18 Jun 2019 19:33:23 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Make entire header comment C++ style

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

From f2c6203fdd1197d8254073a8f3f3372b0d3d9e6b Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 17 Jun 2019 18:16:52 +0100
Subject: [PATCH] regulator: core: Make entire header comment C++ style

Makes things look more consistent.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c    | 15 +++++++--------
 drivers/regulator/helpers.c | 11 +++++------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 85f61e5dc312..9d3ed13b7f12 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * core.c  --  Voltage/Current Regulator framework.
- *
- * Copyright 2007, 2008 Wolfson Microelectronics PLC.
- * Copyright 2008 SlimLogic Ltd.
- *
- * Author: Liam Girdwood <lrg@slimlogic.co.uk>
- */
+//
+// core.c  --  Voltage/Current Regulator framework.
+//
+// Copyright 2007, 2008 Wolfson Microelectronics PLC.
+// Copyright 2008 SlimLogic Ltd.
+//
+// Author: Liam Girdwood <lrg@slimlogic.co.uk>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index b9ae45d2d199..4986cc5064a1 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -1,10 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * helpers.c  --  Voltage/Current Regulator framework helper functions.
- *
- * Copyright 2007, 2008 Wolfson Microelectronics PLC.
- * Copyright 2008 SlimLogic Ltd.
- */
+//
+// helpers.c  --  Voltage/Current Regulator framework helper functions.
+//
+// Copyright 2007, 2008 Wolfson Microelectronics PLC.
+// Copyright 2008 SlimLogic Ltd.
 
 #include <linux/kernel.h>
 #include <linux/err.h>
-- 
2.20.1

