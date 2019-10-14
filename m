Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A247ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E3B21848
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571066316;
	bh=ALQ5UxywvT//9lJbbkXZTePou3aJF/KOrmc5NuILAzA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=q3YtjBcFQ8q5e0MOe22NtQnxliQlSEknSwCjJczbYZTzuwskYfx+vKqogfr9A+DmR
	 +2OgHieCLtg4ADuzvy24K0vyiCrD5r4IyxmfbVRyDxPdEKfqCXqM67f4uJYflNOnvI
	 CZTihBUAQSQDuczujFoGToB9AELRj4Vn5fWg9rEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbfJNPSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732422AbfJNPSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:18:35 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA6A20854;
        Mon, 14 Oct 2019 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571066314;
        bh=ALQ5UxywvT//9lJbbkXZTePou3aJF/KOrmc5NuILAzA=;
        h=From:To:Cc:Subject:Date:From;
        b=ipcAyOIkQUw8FOCSpqQIXtDBtmugpggpjixPI+iKZz9DGOR6RYat4PZa2gKKmimhW
         0McYtPtG7QRKI5KFh2nJ9O2UTf5K0s80uBqUHoaAV9JaihnIkiuJu2bF4N8Z3UrlNB
         1O1swvkJIQdh7JYQUyUc8hsE5jkgqGYibjoLADm0=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     p.zabel@pengutronix.de
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2] reset: build simple reset controller driver for Agilex
Date:   Mon, 14 Oct 2019 10:18:27 -0500
Message-Id: <20191014151827.9486-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel SoCFPGA Agilex platform shares the same reset controller that
is on the Stratix10.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: rebase to v5.4-rc1
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7b07281aa0ae..46f7986c3587 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -129,7 +129,7 @@ config RESET_SCMI
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN || ARC
+	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN || ARC || ARCH_AGILEX
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
-- 
2.20.0

