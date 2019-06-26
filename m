Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939B5C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F29D208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="G49Ed7DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfFZNHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:07:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49659 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:07:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QD771m4115517
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 06:07:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QD771m4115517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561554428;
        bh=M+HknD5PhsH6AD+/lxuIlR6Cxr1LBQ3MZt90rOeigVU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=G49Ed7DHKem32wYpCXQGR6S8a+hnUyz6zAfWzU6cJbgW/R7q1XhrV9LPm5ZRpjpam
         ep+5o+YZbsXHMg/BsU8eOAUaWqAElEReYGS/2RUPwi034I5gg2Zflk4Ece1C2PgBmY
         +taW06r+LYncojXwuNcPcVcKpQh9TEavbLTJwYfyPeHKDjNueHA9ExhteMtWd3j8hq
         YgZSHyXFe9qg0OLGB4UxYtCOdpoBVpiplnPE8qFL09u5ALkMYt4ntgL0tjl6T5MVT4
         GkhQWX2vx94dKOU8QMAFYB9lJZt8PR/MB3h+aZg+n2JxKn6PFDjnVLWpaNpWnOGRIG
         xipBvuciI9J7w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QD77Nx4115514;
        Wed, 26 Jun 2019 06:07:07 -0700
Date:   Wed, 26 Jun 2019 06:07:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Linus Walleij <tipbot@zytor.com>
Message-ID: <tip-670b004417e37b2d080ff6817703dc02e009dc94@git.kernel.org>
Cc:     dilinger@queued.net, mingo@kernel.org, dvhart@infradead.org,
        tglx@linutronix.de, linus.walleij@linaro.org, andy@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, andy@infradead.org,
          linus.walleij@linaro.org, hpa@zytor.com, mingo@kernel.org,
          dvhart@infradead.org, tglx@linutronix.de, dilinger@queued.net
In-Reply-To: <20190626092119.3172-1-linus.walleij@linaro.org>
References: <20190626092119.3172-1-linus.walleij@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/platform/geode: Drop <linux/gpio.h> includes
Git-Commit-ID: 670b004417e37b2d080ff6817703dc02e009dc94
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  670b004417e37b2d080ff6817703dc02e009dc94
Gitweb:     https://git.kernel.org/tip/670b004417e37b2d080ff6817703dc02e009dc94
Author:     Linus Walleij <linus.walleij@linaro.org>
AuthorDate: Wed, 26 Jun 2019 11:21:19 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 15:00:12 +0200

x86/platform/geode: Drop <linux/gpio.h> includes

These board files only use gpio_keys not gpio in general.  This include is
just surplus, delete it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-gpio@vger.kernel.org
Cc: Andres Salomon <dilinger@queued.net>
Cc: linux-geode@lists.infradead.org
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Link: https://lkml.kernel.org/r/20190626092119.3172-1-linus.walleij@linaro.org

---
 arch/x86/platform/geode/alix.c    | 1 -
 arch/x86/platform/geode/geos.c    | 1 -
 arch/x86/platform/geode/net5501.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/x86/platform/geode/alix.c b/arch/x86/platform/geode/alix.c
index 1865c196f136..abcf27077bac 100644
--- a/arch/x86/platform/geode/alix.c
+++ b/arch/x86/platform/geode/alix.c
@@ -24,7 +24,6 @@
 #include <linux/moduleparam.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <linux/dmi.h>
diff --git a/arch/x86/platform/geode/geos.c b/arch/x86/platform/geode/geos.c
index 4fcdb91318a0..529ad847d496 100644
--- a/arch/x86/platform/geode/geos.c
+++ b/arch/x86/platform/geode/geos.c
@@ -21,7 +21,6 @@
 #include <linux/string.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <linux/dmi.h>
diff --git a/arch/x86/platform/geode/net5501.c b/arch/x86/platform/geode/net5501.c
index a2f6b982a729..30cb3377ecc7 100644
--- a/arch/x86/platform/geode/net5501.c
+++ b/arch/x86/platform/geode/net5501.c
@@ -22,7 +22,6 @@
 #include <linux/string.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 
