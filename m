Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB3CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED92B21882
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571065723;
	bh=1pAv96NFGm8gZDp9S4+nLH8j6jWk8PocjMG/QGURbqY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BwxTrO3U3yiYgqKjq5FHfiGa5LKORaXS05MzUv39m9FguBjjX2Jz+X8vVb30fyZT4
	 QvDlEdQgC5O+7xCFDfb9wHUR6kWIWqj+ec6nMPXRWqyhJ5EhN+2nHgoINsZivL0fhH
	 oVGQhzwqGvzfAbkwnEPELBYrsmwA+v4EAWjiWQFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbfJNPIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732647AbfJNPIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:08:41 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB0962133F;
        Mon, 14 Oct 2019 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571065721;
        bh=1pAv96NFGm8gZDp9S4+nLH8j6jWk8PocjMG/QGURbqY=;
        h=From:To:Cc:Subject:Date:From;
        b=iN8zxsQJSNWlIBmQ8vuMVzRb/u+b91EVOoV67rsSZ2nk8IfurQ2f2tCehIqSoep8s
         Zv1WcAQYau1o1yEvx8yKSYTPog+bfxJMM+VgTl/mPzbUuTCU6dLE1Aj5a20U9tubUX
         XMm2Q9rAQr8mzYpM9hXSiYCUdTeFAKHxQTvkXQYc=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     p.zabel@pengutronix.de
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] reset: build simple reset controller driver for Agilex
Date:   Mon, 14 Oct 2019 10:08:22 -0500
Message-Id: <20191014150822.9108-1-dinguyen@kernel.org>
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
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 21efb7d39d62..280e69fbf86d 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -118,7 +118,7 @@ config RESET_QCOM_PDC
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN
+	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN || ARCH_AGILEX
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
-- 
2.20.0

