Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CDCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4412082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfC0OPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:15:43 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:35852 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726344AbfC0OPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:15:43 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 27 Mar 2019 16:15:39 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x2REFbWB023645;
        Wed, 27 Mar 2019 10:15:37 -0400
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x2REFbJD021972;
        Wed, 27 Mar 2019 10:15:37 -0400
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Shravan Kumar Ramani <sramani@mellanox.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] gpio: gpio-mlxbf: Add dependency on 64BIT to Kconfig entry
Date:   Wed, 27 Mar 2019 10:15:15 -0400
Message-Id: <bfe609b73c36810457e5ae75b74e1d0fb7f6c5ac.1553696064.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a compile test failure

Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0d9ddff..530ee34 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1318,7 +1318,7 @@ config GPIO_MERRIFIELD
 
 config GPIO_MLXBF
 	tristate "Mellanox BlueField SoC GPIO"
-	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || COMPILE_TEST
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMPILE_TEST)
 	select GPIO_GENERIC
 	help
 	  Say Y here if you want GPIO support on Mellanox BlueField SoC.
-- 
2.1.2

