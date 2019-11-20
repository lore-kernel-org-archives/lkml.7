Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24952C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8F722527
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257026;
	bh=j2YAYXvroo9OHO+N+68fsKVGN+xoU/UWYxOEmQQo7QA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=w1EHHfs+xEju37+iLYQ6nPlWIk2/Q9E5HqvzVuso2uXOLd4Uz4B5Fghrtkd2yW8h7
	 cGAyEqrugw6W7CumQIj1ZvKrWVs0Z05pBSGjJtuaQdnPKYkv6lX2AnvGdsgvn/3sIP
	 k697LDdFwq3zFaJK8+3nz9t2DW2kkHHS/AKL/ApE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfKTNhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:37:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730864AbfKTNhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:03 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A41E622526;
        Wed, 20 Nov 2019 13:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257022;
        bh=j2YAYXvroo9OHO+N+68fsKVGN+xoU/UWYxOEmQQo7QA=;
        h=From:To:Cc:Subject:Date:From;
        b=bt+FokNz1Zvtzm0uVb6kHOb9G3/qWKYi3k/0YFRQKUXLPKyZIQRuKXskhRXPYMflF
         ZRTrtPUgHdIwbLLg7ariJtLgXFHwdiOkFWTuQqtyd8AQW4cucI0t8eEXN8nXoZTkmY
         vWn/dz8eRjE2wQDG1N1ug0LW76JC7n3pIf31fbE0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH] sh: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:36:59 +0800
Message-Id: <20191120133659.11893-1-krzk@kernel.org>
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
 arch/sh/boards/Kconfig | 2 +-
 arch/sh/mm/Kconfig     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index cee24c308337..60a113114a76 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -231,7 +231,7 @@ config SH_MIGOR
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
-          by Renesas System Solutions Asia Pte. Ltd.
+	  by Renesas System Solutions Asia Pte. Ltd.
 
 config SH_AP325RXA
 	bool "AP-325RXA"
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 5c8a2ebfc720..d84316abaa81 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -2,7 +2,7 @@
 menu "Memory management options"
 
 config MMU
-        bool "Support for memory management hardware"
+	bool "Support for memory management hardware"
 	depends on !CPU_SH2
 	default y
 	help
-- 
2.17.1

