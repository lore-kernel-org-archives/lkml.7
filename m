Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA89C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B122464B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578071565;
	bh=KISZBPbueXgh6MYL4P8fo2t7dbtR9islwQqQs7IMFKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mpKBbrEAebtvyte5idxGGmAZtOX35CQ7nT06sBLb7xMlhvY39eLHvxIc5IZeca4vt
	 0J59rMqxijGGHqUCTU3uoLBK0lvp5T9FXa8L6gqgdgtH5y8pZk8wMcRiL6hnxNhWpA
	 HeUgjRgmvFeB745vVxwGaxf74Mm1ZUQ/AxsfOg/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgACRMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:12:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbgACRMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:12:42 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0694224649;
        Fri,  3 Jan 2020 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071561;
        bh=KISZBPbueXgh6MYL4P8fo2t7dbtR9islwQqQs7IMFKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EvWOa50IZlMCt8Yf5qRq1ohKw7kU6EiQZ2SO4yLcUnE3ACwzo/5D0MJh4bdqWWPVA
         9Aj+j+ImP8+z78YQQrL1IjjVYuBW5XodRl1fs6SjKXQL+I8Y/9iX90f3f0RrmJ5yaL
         3soy42mzomZTV29/cubTk8SLMjPLfq1onJUv4snI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 10/19] clocksource/drivers/exynos_mct: Rename Exynos to lowercase
Date:   Fri,  3 Jan 2020 18:11:22 +0100
Message-Id: <20200103171131.9900-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103171131.9900-1-krzk@kernel.org>
References: <20200103171131.9900-1-krzk@kernel.org>
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
 drivers/clocksource/exynos_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 74cb299f5089..a267fe31ef13 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * EXYNOS4 MCT(Multi-Core Timer) support
+ * Exynos4 MCT(Multi-Core Timer) support
 */
 
 #include <linux/interrupt.h>
-- 
2.17.1

