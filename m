Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A63C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E0F222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578089210;
	bh=PuE8ZCiJD8DgMUZwzGmLaQNAO/btEjzMcvcDwImLPRc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nc9MdnxN+I27weBLxg18JPY2duVhL8Lp4NdBTv/MjjQlkjmfzbT+yd/eQIvm/EQG1
	 YpvD9TPSkIEXN3eGAqd8isvWOWuRBU7kBuEVDoagczpoAsM+CEAL3rmdy+6tE7KJcb
	 /gjYClKXKx7E2vkjacgxvHgGZrXEZ8bDfAqUVJiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgACWGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbgACWGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:06:49 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15EF221835;
        Fri,  3 Jan 2020 22:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578089208;
        bh=PuE8ZCiJD8DgMUZwzGmLaQNAO/btEjzMcvcDwImLPRc=;
        h=From:To:Cc:Subject:Date:From;
        b=u6UMfjc9LpwixT1Bn3oMOU/HQfWOtmqfhezL/wMSZRTnyIt8cIKPKGASi4L1tp5Lu
         qEW3iU66ILCr6WcYXqKTc8A2QM2F7LQvhANOL2UZr9ojvw7QZFsBTxzGUxPMfNVqnl
         DKitmgQ28gwFdpWeLEbDr1cSgf2jYqY9LIrgGklc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] soc: fsl: Enable compile testing of FSL_RCPM
Date:   Fri,  3 Jan 2020 23:06:31 +0100
Message-Id: <20200103220631.3846-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSL_RCPM can be compile tested to increase build coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 4df32bc4c7a6..e142662d7c99 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -43,7 +43,7 @@ config DPAA2_CONSOLE
 
 config FSL_RCPM
 	bool "Freescale RCPM support"
-	depends on PM_SLEEP && (ARM || ARM64)
+	depends on PM_SLEEP && (ARM || ARM64 || COMPILE_TEST)
 	help
 	  The NXP QorIQ Processors based on ARM Core have RCPM module
 	  (Run Control and Power Management), which performs all device-level
-- 
2.17.1

