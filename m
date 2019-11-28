Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C4CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D986E2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfK1Opk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:45:40 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:60777 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfK1OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:45:21 -0500
Received: from orion.localdomain ([95.117.37.214]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAgMY-1igxnx1kxk-00B7U2; Thu, 28 Nov 2019 15:45:17 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 5/7] drivers: clk: unexport clk_gpio_mux_ops field
Date:   Thu, 28 Nov 2019 15:44:48 +0100
Message-Id: <20191128144450.24094-5-info@metux.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191128144450.24094-1-info@metux.net>
References: <20191128144450.24094-1-info@metux.net>
X-Provags-ID: V03:K1:UsYWvEnNaP1cmWcVGvDZ1M+iUNZGsqnI8X5qh8YC71B62pYVjOD
 U8niG4qlESWgxpaQRjDFzx/oUmdrm/rL0OoGbQLqwucFIXBqob9noP64kxGI7C0Dhz79CjT
 oQnhYIrJCa33O8CXkNo/nSgImYNAi6eEPGovd9OkdsUwve38AZ42iA8Nx2L0OhgQG+66pYG
 7AcK+v2CF4KoR0S0rZCqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I0L954mxSAs=:ebQ/ei7sJBAPa2UnjRlOce
 Hb5aalYzKwNHElbdShQdupvuq/1k6zJu1fWhYLh3V+RKHwr3Xvo/3SV8kHZ/T9ym8GaymIT4r
 BaqClK224VT83EP6iWXFJgWQxSvYM6hfn7HvuE3wG3l73YFcGFawt6yigYSZcjF6q278Z7ZeB
 OS8Om6/HyECAQtPQF6AeGUVStPfqh7Q8XANuVpye55Wnlq+nzsjnc6Hp/waQuypuzAxPQU2+9
 iTEWR8JHl2C59s8AD/CZMlIOFtj1FmihvIjaUpY09dvQDTd+eHhIieLIHRR9mED6rQCPawUwF
 doLXhNBhMAKvUjyx51H+91dW1UYp1O9geYxyEmKH5uUaYytkHlpNdr+vFvxgSUrawXdNBqZAv
 /tnJKe90fUDLovIZO45LVmYFA2jRpufaGU1CnkS0Gsr09MXY7OUzEY7nMLF4fN5d2SAaOii7m
 Rmvsnt39D8UNw3uQgL4EFBT3fX9Xnq57EYND/qttWVONlnv6e8sobxFiDJeJmeWjn2ba/7D4D
 Q2k7xTrPnIEycoyYUOlM/vMf96U/YF03Y9rKMLl1/09g1Pm6VXiM7AEuy0LZtl4Ir9c230MJl
 t1Ly1FLRNb31ilZOcZOWKPgdWdUiXZOQyfi9bKo4/QxVTbEU4B8eZ2e8qGFupJCShWPpseX/5
 3NseObk4cOcJzQvwbrJXjtcMMKIh2nPNbkQq4YSJi6IvnRl9F7/fATYgvpWwBjLityrDdyUc5
 VoqiwLHvZO7DJqbF42E/GPovRv3122aVtMR4MtSf6qUX0U06yt4VO9JZUv/uPj9E25fiLeduK
 l7HUzI517k4Qic8gOQZdzeWPeDYeyMSwTY9Ja9JEYeasmHJf4PGQ5bujlRQAm8jqKIrH6pnkS
 QqaRtn9mKWcbSrj3hZLQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clk_gpio_mux_ops field doesn't seem to have any users
outside clk-gpio.c, thus unexport and make it static.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/clk/clk-gpio.c       | 3 +--
 include/linux/clk-provider.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index 5aa9ffe394ef..005e311c1822 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -111,12 +111,11 @@ static int clk_gpio_mux_set_parent(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
-const struct clk_ops clk_gpio_mux_ops = {
+static const struct clk_ops clk_gpio_mux_ops = {
 	.get_parent = clk_gpio_mux_get_parent,
 	.set_parent = clk_gpio_mux_set_parent,
 	.determine_rate = __clk_mux_determine_rate,
 };
-EXPORT_SYMBOL_GPL(clk_gpio_mux_ops);
 
 static struct clk_hw *clk_register_gpio(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 054e3c128ac5..b00adc1909a1 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -774,7 +774,6 @@ struct clk_gpio {
 
 extern const struct clk_ops clk_gpio_gate_ops;
 
-extern const struct clk_ops clk_gpio_mux_ops;
 struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
 		unsigned long flags);
-- 
2.11.0

