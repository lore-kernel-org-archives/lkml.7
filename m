Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE76C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0219720643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfCKS76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:59:58 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56709 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfCKSzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:48 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mv2l4-1glkjv0Z96-00qwjm; Mon, 11 Mar 2019 19:55:27 +0100
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
Subject: [PATCH 03/42] drivers: gpio: amdpt: drop unneeded deref of &pdev->dev
Date:   Mon, 11 Mar 2019 19:54:42 +0100
Message-Id: <1552330521-4276-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:MB90/paVBPmJRTSCmdVCoN+KhFi++p5O8RVWv0YnjT+OAKhP4VL
 LsYMs9ns21OPWmx+Ev5oikkJWJ3/sY/bmOKgBynN3jZ5XIn9MhCNQOuiJiL13VIvwcrc0jo
 YIKe2SFe54asSWMxC8Q3h904bjFP9OvzFq8LykE9X4kq5vNVVbCM9flhW247i7UFlaOP1wu
 0LVzPF7w2Zv9HErP8X8gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jq8YX2ANlZc=:6mHFW8SLy+qSqaqd2CuPnW
 ZH+Uwif76ej3J8SLS4yCnbNM3LdU5ttwt+aTuc3hZ3Z+Qi8ympUH+c2JKxJEyofr45E+xOwOu
 X8VRRWBTGtniSJ0hfyAeMdIQRjCMvRxm9IqbPacTnE3mMktATdggd2qy+EW6TCIqram2m56xV
 fLQrCSp3IHrO9uwuhn+52NCCLLnyaKNDa235kBafjlXBsIj/Z/jNe4zccjXhosHVfs+Ug0MDF
 azpSFgqao1G8YVpueXGwsiZuw1NtO2fAVj4KobnwCFXGMpKwUof3w19TnPyVcKk5/9hygT8/+
 kq6hvNSBicDukRAHCp7NMTUqEBj7T8Ty4RDVw5UFAGS90ua1s0Hd0+cZZCB0P8x+saFtr2snM
 Tj613fGIVupo+X3mOQFSut2PwXsXufadIy1S7nVCZBouXphkmXBjIGPzhbhOxjYS6/LBfCHs5
 iLjO/VpIR/jDhOoWm/hQXvBATcFJ+fHI6TS0aWyd7u9itME5D3Jw5sVbtATt4cLzwsEci3VDd
 FGr8l6siMJ0DYfbYbb0SV9i5bPY1zuc2asO0RQgIfR8rpWjd92QoI+eGVecLRgEJexs/ke8hL
 gBbF/Vk+w2VJjbv5+kp2FX3ZHSjnGkr2jf81r3/jZ5WkudliOZTjgcit/ikadRFtqO0KPaApL
 MpTsbeNZxIeYUXUgqmcGi/FV+ii7RIPiPI671IzoXgqOzHMliJAycQwYxWIcjDbDxu3dlDtvV
 L9QmOO5jwQDUZWq/uzQQBxTejoA1dAlGjtKJKQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the struct device* pointer in a local variable,
so we can write this a bit shorter.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-amdpt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index 1ffd7c2..3220f3c 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -91,7 +91,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 
 	pt_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pt_gpio->reg_base)) {
-		dev_err(&pdev->dev, "Failed to map MMIO resource for PT GPIO.\n");
+		dev_err(dev, "Failed to map MMIO resource for PT GPIO.\n");
 		return PTR_ERR(pt_gpio->reg_base);
 	}
 
@@ -101,7 +101,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 			 pt_gpio->reg_base + PT_DIRECTION_REG, NULL,
 			 BGPIOF_READ_OUTPUT_REG_SET);
 	if (ret) {
-		dev_err(&pdev->dev, "bgpio_init failed\n");
+		dev_err(dev, "bgpio_init failed\n");
 		return ret;
 	}
 
@@ -110,11 +110,11 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	pt_gpio->gc.free             = pt_gpio_free;
 	pt_gpio->gc.ngpio            = PT_TOTAL_GPIO;
 #if defined(CONFIG_OF_GPIO)
-	pt_gpio->gc.of_node          = pdev->dev.of_node;
+	pt_gpio->gc.of_node          = dev.of_node;
 #endif
 	ret = gpiochip_add_data(&pt_gpio->gc, pt_gpio);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to register GPIO lib\n");
+		dev_err(dev, "Failed to register GPIO lib\n");
 		return ret;
 	}
 
@@ -124,7 +124,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	writel(0, pt_gpio->reg_base + PT_SYNC_REG);
 	writel(0, pt_gpio->reg_base + PT_CLOCKRATE_REG);
 
-	dev_dbg(&pdev->dev, "PT GPIO driver loaded\n");
+	dev_dbg(dev, "PT GPIO driver loaded\n");
 	return ret;
 }
 
-- 
1.9.1

