Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A2FCA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE530222CD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505171AbfJRPmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:42:39 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405757AbfJRPmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:35 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M9Fvl-1iRFA60KiV-006MSw; Fri, 18 Oct 2019 17:42:25 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 15/46] ARM: pxa: maybe fix gpio lookup tables
Date:   Fri, 18 Oct 2019 17:41:30 +0200
Message-Id: <20191018154201.1276638-15-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:syPUHdH7zx5d1jKKxubzoRF3w6dnwzW9ph10lyNvIkzlg2UPc+n
 WicQDwAvgeDChbQgeTjfHAnra993MATAZ6ChdvdsZxWuh4SdT4z1yIP3/xQoWlTkqTO/Wjz
 ptxp60wybFrjdmfE2DdySvomyYIvEQLExy/RoAD2dpMr1ikMxEwvPajQvY+penWKv3Uojkj
 fNFRTETTMlT7VvFn8VggA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yWY/+VG4pjI=:DTl6Icej/SxGZGsMd8zgCF
 FWyMzXZMzJzFdyYEFXS0M5s8SRJkq5yZ3GvLFlskJQR69z/z77b0OCovzRWxYl6yiQIb1Qjx+
 vfbzsQ+8ojNroHUob+NZupz/vXHsEe7cn5nAaFh5p7lLElLQ9nhdy+CZFu57bEQfgyp8YlwCp
 67d/Ko59y5VCmou1dzKZsmcY2cLrnogZyOmnrqD4G1n0sJJBmD49l6YHmdKBmvskOHRbXCWhr
 Hmu1ajas2Ryo6teWSk3IUWsDQfZc9rWT/AtD5z2uNKjamqzJ4KGkXrQfJyHoaTrX+WlUdkmox
 PlDrWJemwJm//6GAe9e/Uq4O13E4Y61NuyT8r1p/PYgFduN5xSxIcOoA5z4R7D91otK4G0aai
 s4+ScCCx7ljRVe7fFgvzMtySpi5fC+pJ0kFGaJnXQTfWtdNXKdtsS5EphDA/hARlyD1WcPrS0
 tVW4fB2Rk97Que2WscRL2XryPygX1T7LGkcYYcCc1/v77xuNoot8ZKqW3ORYuDCVbXFiF+hCX
 m09pPLXkweQ4ClYfHwWG8Ijoeg4qFIuHIApkG2N12MNYiFzB/P26iDrviX6Gw3eukfdW+62bt
 u8Ym1nC+Kcng8raLcZvnd/BJuEDLUoWg0jhgaDwlsjJ7kOAZL48iss5jQV0tcj3Lm0OX1w+Ji
 iOIGfrHQtDLk+YmIsj6Yp6qboepnpj+rTn783RbubP6SkOhMhW1BJZ7wXrXYJXOlhFN2JU6dh
 RS6OHRFfTCq4qYudlFHfUESZ6Ax1D2tFgRKSYLK76t05DbSCpyetzP5yay30HsL9AkvEDWc4R
 rNuU88SdEvcEDf80P3EcL9umi+tw42HLvqon8M8DirFGVFPo1Rb80oUrRo9imj0L464bB2lww
 wqkChN0tT5zrIBG2RxGw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From inspection I found a couple of GPIO lookups that are
listed with device "gpio-pxa", but actually have a number
from a different gpio controller.

Try to rectify that here, with a guess of what the actual
device name is.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/cm-x300.c  | 8 ++++----
 arch/arm/mach-pxa/magician.c | 2 +-
 arch/arm/mach-pxa/tosa.c     | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 6cdc440672a6..92fbe4cf71c7 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -357,13 +357,13 @@ static struct platform_device cm_x300_spi_gpio = {
 static struct gpiod_lookup_table cm_x300_spi_gpiod_table = {
 	.dev_id         = "spi_gpio",
 	.table          = {
-		GPIO_LOOKUP("gpio-pxa", GPIO_LCD_SCL,
+		GPIO_LOOKUP("pca9555.1", GPIO_LCD_SCL - GPIO_LCD_BASE,
 			    "sck", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("gpio-pxa", GPIO_LCD_DIN,
+		GPIO_LOOKUP("pca9555.1", GPIO_LCD_DIN - GPIO_LCD_BASE,
 			    "mosi", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("gpio-pxa", GPIO_LCD_DOUT,
+		GPIO_LOOKUP("pca9555.1", GPIO_LCD_DOUT - GPIO_LCD_BASE,
 			    "miso", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("gpio-pxa", GPIO_LCD_CS,
+		GPIO_LOOKUP("pca9555.1", GPIO_LCD_CS - GPIO_LCD_BASE,
 			    "cs", GPIO_ACTIVE_HIGH),
 		{ },
 	},
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index e925f7a8d349..31037679bf24 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -675,7 +675,7 @@ static struct platform_device bq24022 = {
 static struct gpiod_lookup_table bq24022_gpiod_table = {
 	.dev_id = "gpio-regulator",
 	.table = {
-		GPIO_LOOKUP("gpio-pxa", EGPIO_MAGICIAN_BQ24022_ISET2,
+		GPIO_LOOKUP("htc-egpio-0", EGPIO_MAGICIAN_BQ24022_ISET2 - MAGICIAN_EGPIO_BASE,
 			    NULL, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("gpio-pxa", GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
 			    "enable", GPIO_ACTIVE_LOW),
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 23da9568c520..264b5b6ed13b 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -295,9 +295,9 @@ static struct gpiod_lookup_table tosa_mci_gpio_table = {
 	.table = {
 		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_nSD_DETECT,
 			    "cd", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_SD_WP,
+		GPIO_LOOKUP("sharp-scoop.0", TOSA_GPIO_SD_WP - TOSA_SCOOP_GPIO_BASE,
 			    "wp", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("gpio-pxa", TOSA_GPIO_PWR_ON,
+		GPIO_LOOKUP("sharp-scoop.0", TOSA_GPIO_PWR_ON - TOSA_SCOOP_GPIO_BASE,
 			    "power", GPIO_ACTIVE_HIGH),
 		{ },
 	},
-- 
2.20.0

