Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CE7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E5D20650
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 08:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392632AbfIFIpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 04:45:51 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:57794 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391715AbfIFIpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 04:45:44 -0400
Received: from ramsan ([84.194.98.4])
        by michel.telenet-ops.be with bizsmtp
        id y8lh2000805gfCL068lhD3; Fri, 06 Sep 2019 10:45:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i69sC-0003N7-Vj; Fri, 06 Sep 2019 10:45:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i69sC-0005h9-UA; Fri, 06 Sep 2019 10:45:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] gpio: of: Switch to EXPORT_SYMBOL_GPL()
Date:   Fri,  6 Sep 2019 10:45:38 +0200
Message-Id: <20190906084539.21838-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190906084539.21838-1-geert+renesas@glider.be>
References: <20190906084539.21838-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All exported functions provide genuine Linux-specific functionality.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpiolib-of.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index fad3aad667558325..7aea6d0f3ace9b82 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -274,7 +274,7 @@ int of_get_named_gpio_flags(struct device_node *np, const char *list_name,
 	else
 		return desc_to_gpio(desc);
 }
-EXPORT_SYMBOL(of_get_named_gpio_flags);
+EXPORT_SYMBOL_GPL(of_get_named_gpio_flags);
 
 /**
  * gpiod_get_from_of_node() - obtain a GPIO from an OF node
@@ -343,7 +343,7 @@ struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
 
 	return desc;
 }
-EXPORT_SYMBOL(gpiod_get_from_of_node);
+EXPORT_SYMBOL_GPL(gpiod_get_from_of_node);
 
 /*
  * The SPI GPIO bindings happened before we managed to establish that GPIO
@@ -719,7 +719,7 @@ int of_mm_gpiochip_add_data(struct device_node *np,
 	pr_err("%pOF: GPIO chip registration failed with status %d\n", np, ret);
 	return ret;
 }
-EXPORT_SYMBOL(of_mm_gpiochip_add_data);
+EXPORT_SYMBOL_GPL(of_mm_gpiochip_add_data);
 
 /**
  * of_mm_gpiochip_remove - Remove memory mapped GPIO chip (bank)
@@ -736,7 +736,7 @@ void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc)
 	iounmap(mm_gc->regs);
 	kfree(gc->label);
 }
-EXPORT_SYMBOL(of_mm_gpiochip_remove);
+EXPORT_SYMBOL_GPL(of_mm_gpiochip_remove);
 
 static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
 {
-- 
2.17.1

