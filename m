Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994FBC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFB1206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908324;
	bh=6PYDiqOyMBKGjsOYaBQ/3YxVMPUov6leeuFtK5wVyVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gDQ2FgTsPeAw5MMb516YouEt739WyekOsaVFKmupvSuUcibucisquGMxUeL7oGDSN
	 tP3zTucnFe0G9m5VAolM0Z+M9AAXMiDlAaaLlmrAYyPEl4q5Wr6I/UufWUpzHT70pW
	 Yf1NiOkjMRDyFXNkOR76meIzrYTAJo1OedkVeTUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfC3Auy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730411AbfC3Auv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:50:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD71218CD;
        Sat, 30 Mar 2019 00:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907050;
        bh=6PYDiqOyMBKGjsOYaBQ/3YxVMPUov6leeuFtK5wVyVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZW7yRpSb72BVRhmkVnXT8zYxQC24dDUgO3D9jHXc6468awXpHMHuRMZlFl99Qkq41
         T9zdjmO4f7q02RI+nYqi+gHHOC1eQPektl80TfS9TWw+9NstPKifVhsYiw4d5RIoDf
         x6V23VUOoPze3I2l4ehO4PDYjOsWqeVY0rLwwBBU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 02/67] arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM
Date:   Fri, 29 Mar 2019 20:49:42 -0400
Message-Id: <20190330005047.25998-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
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
index 87b23b7fb781..aefcf7a4e17a 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -8,6 +8,7 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_RAM=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
-- 
2.19.1

