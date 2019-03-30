Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92822C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B482218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907291;
	bh=LP+Z8yzaX46pFeM6VEfhJSEN5jVsO9qr7zPK339cvvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oORbsa01dpfFOjKQ7t0YQS0/h1CAZOpt83xaaUwMsmvByV7lRwoH4B7t9x7FUTsNJ
	 TogodnLyQHtFCOfoNAVxN3RZH3gxaUb+tatX8t37CW8ktcEd/JD212G7xGbDyIIfAK
	 M3osRGODpcXdkkoySGyt6Qa+VU67IpLOpGpDbdL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbfC3Ayu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731593AbfC3Ayp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:54:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6004B206DD;
        Sat, 30 Mar 2019 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907285;
        bh=LP+Z8yzaX46pFeM6VEfhJSEN5jVsO9qr7zPK339cvvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJMqRR+3DyKPO4ECi6vNrzKMF9sZZZ8elkY2JszoM7UbjcChnX6CmMqYnhK3uAfHU
         jQNfS01855Ftq3ORr74LrYtt4IV/xqtETGuMUfUbibYRo2NrHJAKtpLW6mce7TTM0/
         PwOWfq2o5YYJqqSL7FBc6xH0lXNhSdRfJHQNEyLo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 02/37] arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM
Date:   Fri, 29 Mar 2019 20:54:03 -0400
Message-Id: <20190330005441.27540-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit 0728aeb7ead99a9b0dac2f3c92b3752b4e02ff97 ]

We have now a HSDK device in our kernelci lab, but kernel builded via
the hsdk_defconfig lacks ramfs supports, so it cannot boot kernelci jobs
yet.

So this patch enable CONFIG_BLK_DEV_RAM in hsdk_defconfig.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/configs/hsdk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 083560e9e571..4dac1169f528 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -9,6 +9,7 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_RAM=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
-- 
2.19.1

