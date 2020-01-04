Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA56CC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929722464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578151344;
	bh=cCjYxGd/KL0FWzSgniFPKokn3dk8mcXrfNpZVsyTpT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=02EqFtDs5ShsbTgqh6zLYtu71BvZJmih50atifO1AiPmGyMPGg38OyIxBRoZqIIXZ
	 56PFkXGXLqcbu15TCB4xSrJuEJpar3ajPLLRBp5Yp29nGWHpWG6E80w8p53+c9x36c
	 4IQSkxRkE9ZyeHZj6gI0GArXNNwCr0vdNOW86Ozw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgADPWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgADPWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:22:20 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0DA224654;
        Sat,  4 Jan 2020 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578151340;
        bh=cCjYxGd/KL0FWzSgniFPKokn3dk8mcXrfNpZVsyTpT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1J1kuop57Wb+ntVAfEzwMWj1PWTgRa4ppNYveV8D6Y8QO43O5/tgXgHWmZxm1zyS
         G7COIBAKT2BPWI2GF1glTovDMcbPN5F3BdDYx6X5tyEqr7dD4uMfYmPISfdG6WgKc4
         4om/fqQR1FlejAB6P1D9Ig4d4+y3gm5uo/mgbx04=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 09/20] memory: samsung: Rename Exynos to lowercase
Date:   Sat,  4 Jan 2020 16:20:56 +0100
Message-Id: <20200104152107.11407-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104152107.11407-1-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Exynos"
name.

"EXYNOS" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/samsung/Kconfig       | 2 +-
 drivers/memory/samsung/exynos-srom.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/samsung/Kconfig b/drivers/memory/samsung/Kconfig
index e9c3ce92350c..20a8406ce786 100644
--- a/drivers/memory/samsung/Kconfig
+++ b/drivers/memory/samsung/Kconfig
@@ -8,7 +8,7 @@ config SAMSUNG_MC
 if SAMSUNG_MC
 
 config EXYNOS5422_DMC
-	tristate "EXYNOS5422 Dynamic Memory Controller driver"
+	tristate "Exynos5422 Dynamic Memory Controller driver"
 	depends on ARCH_EXYNOS || (COMPILE_TEST && HAS_IOMEM)
 	select DDR
 	depends on DEVFREQ_GOV_SIMPLE_ONDEMAND
diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index c27c6105c66d..6510d7bab217 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -3,7 +3,7 @@
 // Copyright (c) 2015 Samsung Electronics Co., Ltd.
 //	      http://www.samsung.com/
 //
-// EXYNOS - SROM Controller support
+// Exynos - SROM Controller support
 // Author: Pankaj Dubey <pankaj.dubey@samsung.com>
 
 #include <linux/io.h>
-- 
2.17.1

