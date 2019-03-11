Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD13C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B072B2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfCKS4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:09 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbfCKSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:54 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MgNtR-1gZJKg2Swp-00hwpN; Mon, 11 Mar 2019 19:55:37 +0100
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
Subject: [PATCH 16/42] drivers: gpio: janz-ttl: drop unneccessary temp variable dev
Date:   Mon, 11 Mar 2019 19:54:55 +0100
Message-Id: <1552330521-4276-16-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:xPkcHUo6RopzkqV+mh4vpPChYf4VH0lnv4qK/tFVXd518EX7goP
 fE+h/waGMIQcBXFyHl2mq0TNuKHgHulmHoMLbXWNaKlaC4lw9WQVO9LBFie7iE32I45XUI1
 KyMHsAW1M6/GmZKIMWnBmE8cCGG/5qnzhk9RUwoNViVB860YxZI+TDscphdHRZ+B2gdThZ3
 0FHTmo3xgE+FUIbLN8vEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8QpcY987fuE=:/gKt4XdUX6RqHGucbXMHoW
 xCMoIPSMVtUg33YrA3fgelxDXwIeXZhifNd/U2cJMB7pOqFNdknmnwiNxmMxTcM8O51Ap6cR3
 i2XbRBwlL3OdIm3u7LxhvhxCwHm+xoTjTJBV+s3RNJINRdzKJ5p/URe7pHc9os/zG0n+2za2d
 A6GRc+kZgVAbTore7ObSc6d++ZnfOcK3ANNatOUF/DUtct3LcPwmiMdZTuP6qiv3zRahbm+kR
 c8wcrFWF8IOjfCYGj42TjSxz/9HhPs6rHIXyR40NQcziHHQMDonaGv0Riui4cy1diwC0cwq5T
 PfbaHkkp1w7Hox1xPQfgxzTt7BcB9b3Nznwf20Kr4vmL323d9bHGaIddTF8sJtQbPw5aqCIA/
 sQtXJ8wPGsZqqFpHR13iRwYj0plB/C0sqlRBpi3YuGp0qbWnsXDSHFdv0q1QWQ3zH01jB/ipf
 PxdfD2epV+Xg2e6cFaxdB+kbdulcMAOYXHFTq17BXTATwIRRCi2b+1fYr49gqtmhSh+RrVrwF
 jVysRUnrx2llk/0JLN0MAi11znldRchik9TLq8Urojpz7dPyhxf1H7kCAlxQFe8CB4kXwhi6G
 UrIiqrxjQTKxFwTDy3od33T9Xm6SAcT+WwJlYS2kX1bk6iYcoIG7yMcTeD88stMPTrL4I44d3
 6PffckfAXooOoxGYn18u/kzXqOWaExACZ1qW/7T9jreSlUXuW79gbQJrp6ZxET5/K806+KOPu
 Abz9Zk1bn/SEYr2cEczrVeY3AmN1rUC96W1ugw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

don't need the temporary variable "dev", directly use &pdev->dev

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-janz-ttl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-janz-ttl.c b/drivers/gpio/gpio-janz-ttl.c
index b97a911..91f91f6 100644
--- a/drivers/gpio/gpio-janz-ttl.c
+++ b/drivers/gpio/gpio-janz-ttl.c
@@ -144,18 +144,17 @@ static void ttl_setup_device(struct ttl_module *mod)
 static int ttl_probe(struct platform_device *pdev)
 {
 	struct janz_platform_data *pdata;
-	struct device *dev = &pdev->dev;
 	struct ttl_module *mod;
 	struct gpio_chip *gpio;
 	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
-		dev_err(dev, "no platform data\n");
+		dev_err(&pdev->dev, "no platform data\n");
 		return -ENXIO;
 	}
 
-	mod = devm_kzalloc(dev, sizeof(*mod), GFP_KERNEL);
+	mod = devm_kzalloc(&pdev->dev, sizeof(*mod), GFP_KERNEL);
 	if (!mod)
 		return -ENOMEM;
 
@@ -181,9 +180,9 @@ static int ttl_probe(struct platform_device *pdev)
 	gpio->base = -1;
 	gpio->ngpio = 20;
 
-	ret = devm_gpiochip_add_data(dev, gpio, NULL);
+	ret = devm_gpiochip_add_data(&pdev->dev, gpio, NULL);
 	if (ret) {
-		dev_err(dev, "unable to add GPIO chip\n");
+		dev_err(&pdev->dev, "unable to add GPIO chip\n");
 		return ret;
 	}
 
-- 
1.9.1

