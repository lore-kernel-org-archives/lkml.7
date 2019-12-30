Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E717C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332F520730
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577726488;
	bh=16Vm2+4bOHtwFPrZ/Vs4bLTz4LXA5yWYbJqpA0iY+e8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=O+A7h2aCJqxUyYI4cVfkHnR7mURBBSWe1vgg4TezEcZSK1ZvTW9Vy0UK2e7eFhqva
	 07WGmH3hQoA5xfyNRVBIG9y+LcLEfPHKKEiRgmKMDGvvbu67QRvSdgqw9OjxpJPD+j
	 KBEA8WE/XWrEHC3Vtpb2kSrhMx8EeVLYiZYtNiRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfL3RV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfL3RV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:21:26 -0500
Received: from localhost.localdomain (unknown [194.230.155.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2393420718;
        Mon, 30 Dec 2019 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577726486;
        bh=16Vm2+4bOHtwFPrZ/Vs4bLTz4LXA5yWYbJqpA0iY+e8=;
        h=From:To:Cc:Subject:Date:From;
        b=Ga+N7QV2jpHzzuMqRwqfmYcncnpQgMfPYcpoG9EdfkQ6s37hUOof4OYzE08ndjlWv
         aktqnm77s9ZkoefUY3VIVMFVfWZ5zriRi45vTDGWQkFHNQDKDuFtBub2CBw7vPzvUS
         RKfsShogNTWooDzeVgbJkAuU0lk/y4Jq0m8wN8jE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] pwm: Fix minor Kconfig whitespace issues
Date:   Mon, 30 Dec 2019 18:21:12 +0100
Message-Id: <20191230172113.17222-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove double whitespace after "config" keyword.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pwm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index bd21655c37a6..c865d688f6b4 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -490,7 +490,7 @@ config PWM_TEGRA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tegra.
 
-config  PWM_TIECAP
+config PWM_TIECAP
 	tristate "ECAP PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3
 	help
@@ -499,7 +499,7 @@ config  PWM_TIECAP
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tiecap.
 
-config  PWM_TIEHRPWM
+config PWM_TIEHRPWM
 	tristate "EHRPWM PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_K3
 	help
-- 
2.17.1

