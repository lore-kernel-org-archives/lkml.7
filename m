Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5D1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73467224EB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257045;
	bh=96uViNmOJ3sAbZzXst6e75EPddNChDMy7dw1ZPU6UAs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2crEMzWmPnhV4y8qP2+MvsJpr1D+GR19uylzRa6394tPx3pgt9LLbxNtuIv5jyRYl
	 7RyxA4oJ7VukbFdomUmfBTlIUrkA5lgGOAJ2PsVlIqDY+FKfhsOTMsXr3Hx+9la9bi
	 gvsR/lNZChb9jjAoLZj/RgCl7MGTH17MykMi9Ql0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfKTNhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfKTNhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:21 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DA2221939;
        Wed, 20 Nov 2019 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257040;
        bh=96uViNmOJ3sAbZzXst6e75EPddNChDMy7dw1ZPU6UAs=;
        h=From:To:Cc:Subject:Date:From;
        b=XqBiDAse8stSBE+yGAFsDr/QN6z5op5BshFjjw+jXMA1FKTSH9OnljlmRLt4R5IYy
         zZhD7RpQuIsg16XW+oHKvB5FzIJAIjxdd7BuUBSAdpPC1djtfNcGh9V1jp2IvymXvm
         SpcBFQ3tRECueF8UeYMdKfw7hETx3Ksf+Fl3IlOU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH] nds32: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:16 +0800
Message-Id: <20191120133717.12122-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/nds32/Kconfig.cpu | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index f80a4ab63da2..2216cd789b29 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -13,8 +13,8 @@ config FPU
 	default n
 	help
 	  If FPU ISA is used in user space, this configuration shall be Y to
-          enable required support in kerenl such as fpu context switch and
-          fpu exception handler.
+	  enable required support in kerenl such as fpu context switch and
+	  fpu exception handler.
 
 	  If no FPU ISA is used in user space, say N.
 
@@ -24,7 +24,7 @@ config LAZY_FPU
 	default y
 	help
 	  Say Y here to enable the lazy FPU scheme. The lazy FPU scheme can
-          enhance system performance by reducing the context switch
+	  enhance system performance by reducing the context switch
 	  frequency of the FPU register.
 
 	  For nomal case, say Y.
@@ -75,11 +75,11 @@ choice
 	  if its cache way size is larger than page size. You can specify the
 	  CPU type direcly or choose CPU_V3 if unsure.
 
-          A kernel built for N10 is able to run on N15, D15, N13, N10 or D10.
-          A kernel built for N15 is able to run on N15 or D15.
-          A kernel built for D10 is able to run on D10 or D15.
-          A kernel built for D15 is able to run on D15.
-          A kernel built for N13 is able to run on N15, N13 or D15.
+	  A kernel built for N10 is able to run on N15, D15, N13, N10 or D10.
+	  A kernel built for N15 is able to run on N15 or D15.
+	  A kernel built for D10 is able to run on D10 or D15.
+	  A kernel built for D15 is able to run on D15.
+	  A kernel built for N13 is able to run on N15, N13 or D15.
 
 config CPU_N15
 	bool "AndesCore N15"
@@ -173,7 +173,7 @@ config HIGHMEM
 
 config CACHE_L2
 	bool "Support L2 cache"
-        default y
+	default y
 	help
 	  Say Y here to enable L2 cache if your SoC are integrated with L2CC.
 	  If unsure, say N.
-- 
2.17.1

