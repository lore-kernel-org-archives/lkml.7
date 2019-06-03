Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2CAC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441602719A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559589573;
	bh=XQ1OCD9q7CWGt1bcJE5keuNo+GEJGaz+/7Wb9Xj0j/s=;
	h=From:To:Subject:Date:List-ID:From;
	b=BD0gB2ZDHcZyczKpEcvv/+bxkIA91ruFfCE3MN7gIGaOHPyJeixYnQOJsnBSLBcSN
	 41pnVNPhv2Cg0P99iROnPv/+5XF1fciHGQhxIUDkZ+1c3O7kNMAj9xBUFcVic970La
	 DLccOiFFOBhh2jEMPbjQ95Q4U1XeHsvaLX/3PPM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfFCTTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfFCTTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:19:32 -0400
Received: from localhost.localdomain (unknown [194.230.155.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1999A27199;
        Mon,  3 Jun 2019 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559589571;
        bh=XQ1OCD9q7CWGt1bcJE5keuNo+GEJGaz+/7Wb9Xj0j/s=;
        h=From:To:Subject:Date:From;
        b=WvyxZu0qk4A1lr+JbjV3V0NcW/ZquERVyl6mRApOw3Mz6JxN06wF9DLsWjrfp522I
         Dw1THS1zWT1TGlPVcd8EFthbnm6El3/jKM+adf3a8wEhfxOVLTJjc8Kd+3ZGzqHbR7
         hzMAVj/3H3GWA754c8OMInGYObKW9bvTTLNVnUWg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh: config: Remove left-over BACKLIGHT_LCD_SUPPORT
Date:   Mon,  3 Jun 2019 21:19:25 +0200
Message-Id: <20190603191925.20659-1-krzk@kernel.org>
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
 arch/sh/configs/hp6xx_defconfig  | 1 -
 arch/sh/configs/sh2007_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defconfig
index 4dcf7f552582..91d43e2bffea 100644
--- a/arch/sh/configs/hp6xx_defconfig
+++ b/arch/sh/configs/hp6xx_defconfig
@@ -40,7 +40,6 @@ CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_HIT=y
 CONFIG_FB_SH_MOBILE_LCDC=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FONTS=y
 CONFIG_FONT_PEARL_8x8=y
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index a1cf6447dbb1..cbd6742eb423 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -85,7 +85,6 @@ CONFIG_WATCHDOG=y
 CONFIG_SH_WDT=y
 CONFIG_SSB=y
 CONFIG_FB=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
-- 
2.17.1

