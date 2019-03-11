Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C216DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3813214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfCKS4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfCKS4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:01 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MNcYX-1hRPx42ZvH-00P325; Mon, 11 Mar 2019 19:55:45 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        thierry.reding@gmail.com, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr,
        yamada.masahiro@socionext.com, jun.nie@linaro.org,
        shawnguo@kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 26/42] drivers: gpio: rcar: pendantic formatting
Date:   Mon, 11 Mar 2019 19:55:05 +0100
Message-Id: <1552330521-4276-26-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:WZUSasT9svg+DRGMBLjdJIsxvTDhtPEmsBIQ6GBWeBChWb6ydQi
 emACcz5b29DWaX/3Hzr/ZozQnf0NNjNjV9fNZOtqteVyu8pGkMBG1NYgI8y4O+QxeeBObg3
 19JJ8H3QCdCzD3DDfpJZa3nL429oSdIsokn5iM5FLBW8r2PhXGOTSvDEJx5ok3Q7IzWPl2R
 EF5pmv8HVtwITWu98GhEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DS3RSw9sMLk=:UA0yQf750NLf3ZGP8ZJUkV
 8R3k7YjRG8sqobJCVrPITaMIapG0vUnjnqjVZ4MyoKV8mIQGnxmdpm377Qo1DnIujv+8jEFxr
 rfGj8nqKH04idlZoYanYOkCNSelZfo5AdAzKWW8+f610hH9pBLUfsQ+n2wWkjiAV5WHIAI4/P
 AFf9ihu7GLOc+KPQXkhlIrnEX1SrzvkZhMFUbMdiQeDZcJ1P9+5PKArvq64+j8k8BXVBOF/7f
 cHyf6k4VTEkGrQzlOEzf6pzBA9PMluptZDGY0kil4FBY9y4TPyjuRshVxHVrBjWpZVxaWEy07
 TCk9+tqauCXqMMtADFvrvJpW1WEhsBUaFSFyQrqziiLfw27b5slEqHDS4FlpAL/vZ/swRDwZZ
 EzXBLc8hxkHAD24Gvrt66xVVqXMjSFeaKDVw7spcSFEcsF/VR+A7mVLHIVXom3LCQhaKaTA3w
 d8TkhKYtKsUnEHmFp/6QdNSCgSFZ8ozBVw3dGanYii3ihfa7yAfJfbc8c+2yZcZF1wRd2+vBO
 wStcgOoh+gQXiYM675+6cYvMZHqUWQDsTGfC4U9HiGHsMn25ncs5mOEFBZOoQI43geGiuiY3z
 QtGTrxJSuaFB0eUkt7n6VJN3SdyKATFMUBPVWN5l0sCb9HcOKeD4RNv9EBiFphCrE3vuByMIZ
 B7BGvu72S6abQ/kJrUUsLTv1qHsvMUlcK7nfRrl3tkRQD/ihdpK7MgQvXYu9vd419laea0dFJ
 9SYPE+uUekiOQWNUvcjnw1iF32m80WORfilJUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a tab sneaked in, where it shouldn't be.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 500a359..df4419e 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -490,7 +490,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	irq_chip->irq_unmask = gpio_rcar_irq_enable;
 	irq_chip->irq_set_type = gpio_rcar_irq_set_type;
 	irq_chip->irq_set_wake = gpio_rcar_irq_set_wake;
-	irq_chip->flags	= IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
+	irq_chip->flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
 
 	ret = gpiochip_add_data(gpio_chip, p);
 	if (ret) {
-- 
1.9.1

