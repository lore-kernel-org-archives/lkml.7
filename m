Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0A8C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BF721479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568140979;
	bh=/LooAfLWrCT1T8tDGhy1qtaoR6dOFBqW+Qnf0Z9e0n8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=o0DuRulpDj9MqbgLakoHsbZb+HT21zkZDNStmu/PAgUebukMm6f3ZvpeIsmLS4+4D
	 v+DN9XoHYfLuxSasChbbrvCZb2G4Iprviqi8XPn1BjJQQq7V1piU7ldQTaKKvlQh5W
	 awAAiWx9zZikyKAJkKUCJq4x4jH3W9QQayMVgMEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfIJSm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfIJSm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:42:58 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 800E120872;
        Tue, 10 Sep 2019 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568140977;
        bh=/LooAfLWrCT1T8tDGhy1qtaoR6dOFBqW+Qnf0Z9e0n8=;
        h=From:To:Cc:Subject:Date:From;
        b=SFfk6a5HWSAUpEvuHFeEzTqvZw2bgdoxrWVszGKc2/TsQ2+1fdPapzYMo56UwZ3P3
         cSqGUR79jN+gRE5suKQWROiRxkHZjeciopgMIb558OgChPYnyTKMezrdsp+PpxaVWL
         ps+WzZu8sLxhh1ZjtcGiysueKHt5GHu6CtyqepvA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH RESEND] config: android: Remove left-over BACKLIGHT_LCD_SUPPORT
Date:   Tue, 10 Sep 2019 20:42:41 +0200
Message-Id: <20190910184241.20897-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_BACKLIGHT_LCD_SUPPORT was removed in commit 8c5dc8d9f19c
("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel
symbol"). Options protected by CONFIG_BACKLIGHT_LCD_SUPPORT are now
available directly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 kernel/configs/android-recommended.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
index 81e9af7dcec2..c51f4c221ad6 100644
--- a/kernel/configs/android-recommended.config
+++ b/kernel/configs/android-recommended.config
@@ -7,7 +7,6 @@
 # CONFIG_PM_WAKELOCKS_GC is not set
 # CONFIG_VT is not set
 CONFIG_ARM64_SW_TTBR0_PAN=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_BLK_DEV_DM=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-- 
2.17.1

