Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0989C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94C62084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDITKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:10:48 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55749 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfDITKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:10:48 -0400
Received: from localhost ([2.171.41.193]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N1Ok1-1gluix10nL-012lfk; Tue, 09 Apr 2019 21:10:24 +0200
Date:   Tue, 9 Apr 2019 21:10:22 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        songqiang1304521@gmail.com, robh@kernel.org, m.othacehe@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/3] srf04.c: add maxbotix ultrasonic sensors
Message-ID: <20190409191021.w6phf2q4m2pxcrkq@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:pBHh8YUyJ5asc3vB4tRHolmNO9Q4UOo/6jjRPdC6UmKbIrRZiig
 +XDMS2OaOC2qi8SncL71WKwNt/q7QMs9wOuzJu0gFj8vJ+pWAuJzg4kTsOhSb3VcjrVOzoS
 bU2LXFMqjHl1VkHZYjhWMhWAuqaKgXRQWyUDwAfSYHBpNfsyUumVhR4slUKkTa3TOjCjc4N
 fX5i1xdJLokufAiQF1ZDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WHm4lkGAv6M=:D+Ao2kP1Il/d3ZamGcS0Pu
 mYQIp312F7ECCFM1wUuJHEatndYcobA3Fc9lwZc/utL7yi+QYMIm+kZLRXFmaYG+b1sZC3YMf
 uss2dGCloI+zVlSd8mK91JJlPfQy3gIXjwPKNQFFHYB/KsHLS+qPZudscefB2SH009gXaG3DN
 jwm/irSi4I+0os7res0b/iPGwIB5Z0KTVqcrXuKqN0fPa/9KHf5KxZeEqw5A/uv1eknLVo+Ks
 HJEAwKpG++w6rlO4BlH8JiExEftmyvMh00iXHHbjr3sYowRP6liMKXN1z54hDtd8aJgPpD5Sk
 krHhD1YptlkK17bWqnNnHIbd8BTw90nbFuodrM2AdpT8HXHMxdEpZAkWEcunbiSA6KLRjKUAL
 yerta8Nbf/2IE1NnZ0eiCXEj7mA5lsp+oQ6vqtGLgGd/vWyEJmc7shWC4JExvgzqRuB/VURVZ
 PWTIdvrfiojWjafnCUaIvic6rTZzWfWTxql16FMjt5+8trmp19eEjyeQbHL/HAUerQsicrqKj
 S7mL+jM0azCzuQOQ1PkOWHNJ3nElfi86rxqLknE4QGf6YXPgBN3N1yQmqN0BFPtpqhFZ/Yqbr
 D1GzHbt4jdE1xYF8mqnFtif7DXveJ/EAgQg3YoA6QZrC5BNhIAruXPvTsQw0PDvwL585BH4Os
 FpX2H+/boU1K9wk+drbe2KWn8vZzsE62rj3EABAr7PEz8co2RtvWXLbAfOIHPpP3WNxXp+ajB
 79i6+He+qevMgGO1VXOV7Oe/c5Bys8rlhn2ziA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add Maxbotix LV ultrasonic sensor types mb1000, mb1010, mb1020, mb1030
and mb1040

add a configuration struct with the different trigger pulse lengths

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf04.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 09c7b9c095b0..1bad4018d1aa 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -23,7 +23,7 @@
  * trig:  --+   +------------------------------------------------------
  *          ^   ^
  *          |<->|
- *         udelay(10)
+ *         udelay(trigger_pulse_us)
  *
  * ultra           +-+ +-+ +-+
  * sonic           | | | | | |
@@ -48,6 +48,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/sched.h>
@@ -56,6 +57,10 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+struct srf04_cfg {
+	unsigned long trigger_pulse_us;
+};
+
 struct srf04_data {
 	struct device		*dev;
 	struct gpio_desc	*gpiod_trig;
@@ -66,6 +71,15 @@ struct srf04_data {
 	ktime_t			ts_falling;
 	struct completion	rising;
 	struct completion	falling;
+	const struct srf04_cfg	*cfg;
+};
+
+static const struct srf04_cfg srf04_cfg = {
+	.trigger_pulse_us = 10,
+};
+
+static const struct srf04_cfg mb_lv_cfg = {
+	.trigger_pulse_us = 20,
 };
 
 static irqreturn_t srf04_handle_irq(int irq, void *dev_id)
@@ -102,7 +116,7 @@ static int srf04_read(struct srf04_data *data)
 	reinit_completion(&data->falling);
 
 	gpiod_set_value(data->gpiod_trig, 1);
-	udelay(10);
+	udelay(data->cfg->trigger_pulse_us);
 	gpiod_set_value(data->gpiod_trig, 0);
 
 	/* it cannot take more than 20 ms */
@@ -215,6 +229,18 @@ static const struct iio_chan_spec srf04_chan_spec[] = {
 	},
 };
 
+static const struct of_device_id of_srf04_match[] = {
+	{ .compatible = "devantech,srf04", .data = &srf04_cfg},
+	{ .compatible = "maxbotix,mb1000", .data = &mb_lv_cfg},
+	{ .compatible = "maxbotix,mb1010", .data = &mb_lv_cfg},
+	{ .compatible = "maxbotix,mb1020", .data = &mb_lv_cfg},
+	{ .compatible = "maxbotix,mb1030", .data = &mb_lv_cfg},
+	{ .compatible = "maxbotix,mb1040", .data = &mb_lv_cfg},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_srf04_match);
+
 static int srf04_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -230,6 +256,7 @@ static int srf04_probe(struct platform_device *pdev)
 
 	data = iio_priv(indio_dev);
 	data->dev = dev;
+	data->cfg = of_match_device(of_srf04_match, dev)->data;
 
 	mutex_init(&data->lock);
 	init_completion(&data->rising);
@@ -280,13 +307,6 @@ static int srf04_probe(struct platform_device *pdev)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-static const struct of_device_id of_srf04_match[] = {
-	{ .compatible = "devantech,srf04", },
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, of_srf04_match);
-
 static struct platform_driver srf04_driver = {
 	.probe		= srf04_probe,
 	.driver		= {
-- 
2.11.0
