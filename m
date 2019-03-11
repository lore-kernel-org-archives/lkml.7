Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CD2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448E720643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfCKS5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:57:48 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfCKS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:04 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9nAB-1h70S31pDh-005rzP; Mon, 11 Mar 2019 19:55:50 +0100
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
Subject: [PATCH 32/42] drivers: gpio: tb10x: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:11 +0100
Message-Id: <1552330521-4276-32-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:/wgkM/HX0HEMgBvIMBFm2L67vzdkA8Xhh7uiv1GN4Uu2BkhHtGa
 uHsMy7cTxMg+FUiJF/mfTwL1X3sUgXp2pf8AcxIMW4XtN3TEjOv7PI/P7hW2+eyV5iRHsgi
 DANZCi6BsUcI1vzScifVv1TNs8BSUc/Ql2ghNzBJVbXgYWYllrIPD3uzYfLgJGBW+Fl8Ahc
 hnmGFsPuRVCQDWhSKjI1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yg6qm3arTig=:w/UhXM4dsXt3gKXuVYrZzL
 mDSGMw3Q2iW1Pd0+E+Tx2TR7AjCZh3exfSYebtcFRP03DWG8/Gi+g151NU3RlBkho7xvk1M4w
 D28qAaj/T01kVFHgr8SN5dMSYrcklunqOtvhs1Dh9SWGNcxaraUJj8KEtsF/KVDnQGqbvf8Hi
 wo33ebib0nHp5HWhr3wFHPmswLT1qfSXXKd6OA78MTeoovtaLOSySwwgseVuusLCNYXyL3OV8
 /v/408H48ithyIIT2+T+b50QBPsE9V5yW5hY+MTgsP+irvhuRR0bOZLMmUgH1lq67N3407+Cs
 b4yg+ysJmY+sbJqNHX1ow9lTw8InKpX3RRDxgySVaNplfCDGfGUYy8H4DpGVlbfNUyTYF00Jl
 4I2BW1ay9XLKzgEi8NZdDgIbltJDMxxrzEiOdepqx5tAbNxHUyVAYqhdv7ClthicuCWRTd+bn
 nZdSHxGIuHmrxHUnFhFuSA1qz+OIRn5w8NJgMBxMzCp2XObCCCh/d+3mGDqahTm4JQcZ0yjLq
 wXtU26oEBgMU8V6pLOxpEPygOWp+VuSItXvHBWQDX8Z9ZlHhx6eYZ/zuhMar6OsOOx1wXvtci
 a12Dop3Il064WzBN/51qY0a6lyK0MlSGva5aC/ispSjhmHly+jCHh14alTb+etfFyNc35udrX
 XP6UoZr8bNyg31LSgZnSSC0cjBpgGS4X3O8Ddh8w8Hn5L63ZgZWqgvGE/o/FIctyFImiqxnAs
 R/CaUOuSPBR/hKI/fadDrJIdWJAIvAhKOcC2Tw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-tb10x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index d5e5d19..6bbac6c 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -120,7 +120,6 @@ static irqreturn_t tb10x_gpio_irq_cascade(int irq, void *data)
 static int tb10x_gpio_probe(struct platform_device *pdev)
 {
 	struct tb10x_gpio *tb10x_gpio;
-	struct resource *mem;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	int ret = -EBUSY;
@@ -136,8 +135,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	if (tb10x_gpio == NULL)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tb10x_gpio->base = devm_ioremap_resource(dev, mem);
+	tb10x_gpio->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tb10x_gpio->base))
 		return PTR_ERR(tb10x_gpio->base);
 
-- 
1.9.1

