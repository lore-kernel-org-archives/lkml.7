Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F539C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CDD2176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfK2Ixx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:53:53 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:52736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbfK2Ixx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:53:53 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BB507169AF5DDB851819;
        Fri, 29 Nov 2019 16:53:50 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 29 Nov 2019
 16:53:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] gpiolib: of: Make of_gpio_spi_cs_get_count static
Date:   Fri, 29 Nov 2019 16:53:36 +0800
Message-ID: <20191129085336.15968-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/gpio/gpiolib-of.c:35:5: warning: symbol 'of_gpio_spi_cs_get_count' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 610c6622f62d..b696e4598a24 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -32,7 +32,7 @@
  * the counting of "cs-gpios" to count "gpios" transparent to the
  * driver.
  */
-int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
+static int of_gpio_spi_cs_get_count(struct device *dev, const char *con_id)
 {
 	struct device_node *np = dev->of_node;
 
-- 
2.20.1


