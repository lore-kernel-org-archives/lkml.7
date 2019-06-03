Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36705C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7A4271A9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559589588;
	bh=3uwe74qIbMfURcy3Wq0/4CqiYzWU+2RJSBxa5JvCv8s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nsMhNvn6hzdyPEx5YLQrR8tXgWBHC8Gl4AzQzLLMdDbbFm5ZnwBn4b/R/lVr6YfJ9
	 8lWD76UWrYhtmb2c49XMYjLGAGZRVf0lOvDDEe2Bqqk5bQ3HQCILlM7jLg/XRVyi2Q
	 Lgf/YEv0m22CZXCOUt/SlRiBTl5atWMQVaMeqAz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfFCTTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfFCTTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:19:46 -0400
Received: from localhost.localdomain (unknown [194.230.155.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB11A2719C;
        Mon,  3 Jun 2019 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559589586;
        bh=3uwe74qIbMfURcy3Wq0/4CqiYzWU+2RJSBxa5JvCv8s=;
        h=From:To:Cc:Subject:Date:From;
        b=oH5jJWUBFhcCraa5qEP6vros82SVl+juZUaoaRRkGgLVs6zJSe7kz+jBiB2UK78hS
         9q5LJuGYUThjgZwKF8VLDt5WkMJ8Hoqi2v1RlEgUWjo2e7j09DX+/V3NT/LtnadM6H
         UlZ139R1zeuamlirjZMjHa7qGv0GOzbnFUeAqZK8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        James Hartley <james.hartley@sondrel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] MIPS: config: Remove left-over BACKLIGHT_LCD_SUPPORT
Date:   Mon,  3 Jun 2019 21:19:34 +0200
Message-Id: <20190603191934.20721-1-krzk@kernel.org>
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
 arch/mips/configs/gpr_defconfig       | 1 -
 arch/mips/configs/lemote2f_defconfig  | 1 -
 arch/mips/configs/pistachio_defconfig | 1 -
 arch/mips/configs/qi_lb60_defconfig   | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index 9d9af5f923c3..9085f4d6c698 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -249,7 +249,6 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_SSB=m
 CONFIG_SSB_DRIVER_PCICORE=y
 # CONFIG_VGA_ARB is not set
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_BACKLIGHT_GENERIC is not set
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 300127b0f5b7..2d4cb03dfa03 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -144,7 +144,6 @@ CONFIG_FB_TILEBLITTING=y
 CONFIG_FB_SIS=y
 CONFIG_FB_SIS_300=y
 CONFIG_FB_SIS_315=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_GENERIC=m
diff --git a/arch/mips/configs/pistachio_defconfig b/arch/mips/configs/pistachio_defconfig
index 2f08d071ada6..24e07180c57d 100644
--- a/arch/mips/configs/pistachio_defconfig
+++ b/arch/mips/configs/pistachio_defconfig
@@ -214,7 +214,6 @@ CONFIG_IR_IMG_RC6=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 # CONFIG_LCD_CLASS_DEVICE is not set
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_SOUND=y
diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
index 1a0677d04982..199c7a7bf692 100644
--- a/arch/mips/configs/qi_lb60_defconfig
+++ b/arch/mips/configs/qi_lb60_defconfig
@@ -77,7 +77,6 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_FB=y
 CONFIG_FB_JZ4740=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 # CONFIG_BACKLIGHT_CLASS_DEVICE is not set
 # CONFIG_VGA_CONSOLE is not set
-- 
2.17.1

