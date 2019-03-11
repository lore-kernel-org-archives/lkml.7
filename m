Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A2AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB9D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfCKNZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:25:42 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfCKNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:38 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M3lgL-1h33zX1wCx-000t9U for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:36 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 067/114] drivers: i2c: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:19 +0100
Message-Id: <1552310346-7629-68-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:guAy5z+8yHPrxZS8EwPwdaQRESbhSWCVipwHlU2I9jV4tPmbcJ8
 ttn/36akX7E2S9sRiDXHjd9PxLjBHMaUNzhunRnC9TH2sYfaxnnlIXAAsyEpZ3neIektGPY
 X9AbGFfEfoZhFNJCb3kJ3ntldG47/JTEzegDdXoREUgGHa/P28WJ9N5cSm2a6ut/Jnt+qVD
 dbyaPm3cqgKyi1N5nWt5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8ZhQBYi+/2o=:oHjVydl5pd622sp8DZsOFT
 Z9zlfcAP+lKLQv5oLN6HrS67wnR7zp1/jc7EoqymuN+UsDZTX5JKcfNTmHDamjsNBMDF41eSd
 tOmiWouMUMveRhSB1XRrnKQ7O6ViFr29d7Xm3zCJh0TW7y6eopnix3eKl3wOEBYxeDJnqGJR3
 H+OemsyPkMdrsJll0bpdFw6OMghJ4XOYopk7I/3pzfQf9GaF9rtFouF3/Icw1f3++5J503iyA
 KfPEm/tBoIEz6i8KasI7LbRo+vcfSjdiY3wsmVFU9drAVwGEaHXEapO07GSTZCm+4ToHOMull
 tyFU/pBVdaZ8NTowVyxmS5rBsnLLysK8oCIZIAeegK8yPd+Fto0dHIaSuHuWVeCYXbD6PTdnW
 3kIWlt1+SwRdXH0Yv9c5o6/+FoLvuaJ8Tg1ppegOobQjkuQnI1nReTP3jKCnHeaJcB4Ol0+72
 jLegxyYmQQBVrai6jqf794BNs8YgylziYJf8wGRlzgOrWf5cShA17oS387nfhgaKxEB8azu54
 NYrxmy45oenGm2Pefu0YHRtW/mlsQlNBFu9WcC47jbRQU//cTcrEhsHFVy6d8hXTjCgaJNRps
 MyprHMEwSPHumcJ/StgqUZ/6jMro2XMQ8pvQxtLHf2mcTimJnqnDUipd1cf/goYEy2udSpDOA
 3mkVR02tJZV0UhumWq+BfwxTx6dH1gfpABbI721QtMRV1KQeNVO4FWVSD/mkpqcLGCfSgHmew
 UvVKj+sxQ7W7kZ6VMS9M+Yaf68pIUBzgGqiq4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/i2c/Kconfig        |  2 +-
 drivers/i2c/busses/Kconfig | 36 ++++++++++++++++++------------------
 drivers/i2c/muxes/Kconfig  | 18 +++++++++---------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index c6b7fc7..797c2c9 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -55,7 +55,7 @@ config I2C_CHARDEV
 	  programs use the I2C bus.  Information on how to do this is
 	  contained in the file <file:Documentation/i2c/dev-interface>.
 
-	  This support is also available as a module.  If so, the module 
+	  This support is also available as a module.  If so, the module
 	  will be called i2c-dev.
 
 config I2C_MUX
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f2c6819..4d0a668 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -277,7 +277,7 @@ config I2C_VIA
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the VIA
-          82C586B I2C interface
+	  82C586B I2C interface
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-via.
@@ -647,11 +647,11 @@ config I2C_IMX_LPI2C
 	tristate "IMX Low Power I2C interface"
 	depends on ARCH_MXC || COMPILE_TEST
 	help
-          Say Y here if you want to use the Low Power IIC bus controller
-          on the Freescale i.MX processors.
+	  Say Y here if you want to use the Low Power IIC bus controller
+	  on the Freescale i.MX processors.
 
-          This driver can also be built as a module. If so, the module
-          will be called i2c-imx-lpi2c.
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-imx-lpi2c.
 
 config I2C_IOP3XX
 	tristate "Intel IOPx3xx and IXP4xx on-chip I2C interface"
@@ -667,10 +667,10 @@ config I2C_JZ4780
 	tristate "JZ4780 I2C controller interface support"
 	depends on MACH_JZ4780 || COMPILE_TEST
 	help
-	 If you say yes to this option, support will be included for the
-	 Ingenic JZ4780 I2C controller.
+	  If you say yes to this option, support will be included for the
+	  Ingenic JZ4780 I2C controller.
 
-	 If you don't know what to do here, say N.
+	  If you don't know what to do here, say N.
 
 config I2C_KEMPLD
 	tristate "Kontron COM I2C Controller"
@@ -1145,14 +1145,14 @@ config I2C_DIOLAN_U2C
 	  will be called i2c-diolan-u2c.
 
 config I2C_DLN2
-       tristate "Diolan DLN-2 USB I2C adapter"
-       depends on MFD_DLN2
-       help
-	 If you say yes to this option, support will be included for Diolan
-	 DLN2, a USB to I2C interface.
+	tristate "Diolan DLN-2 USB I2C adapter"
+	depends on MFD_DLN2
+	help
+	  If you say yes to this option, support will be included for Diolan
+	  DLN2, a USB to I2C interface.
 
-	 This driver can also be built as a module.  If so, the module
-	 will be called i2c-dln2.
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-dln2.
 
 config I2C_PARPORT
 	tristate "Parallel port adapter"
@@ -1246,9 +1246,9 @@ config I2C_VIPERBOARD
 	help
 	  Say yes here to access the I2C part of the Nano River
 	  Technologies Viperboard as I2C master.
-          See viperboard API specification and Nano
-          River Tech's viperboard.h for detailed meaning
-          of the module parameters.
+	  See viperboard API specification and Nano
+	  River Tech's viperboard.h for detailed meaning
+	  of the module parameters.
 
 comment "Other I2C/SMBus bus drivers"
 
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 52a4a92..adff0cc 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -108,14 +108,14 @@ config I2C_DEMUX_PINCTRL
 	  want to change the I2C master at run-time depending on features.
 
 config I2C_MUX_MLXCPLD
-        tristate "Mellanox CPLD based I2C multiplexer"
-        help
-          If you say yes to this option, support will be included for a
-          CPLD based I2C multiplexer. This driver provides access to
-          I2C busses connected through a MUX, which is controlled
-          by a CPLD register.
-
-          This driver can also be built as a module.  If so, the module
-          will be called i2c-mux-mlxcpld.
+	tristate "Mellanox CPLD based I2C multiplexer"
+	help
+	  If you say yes to this option, support will be included for a
+	  CPLD based I2C multiplexer. This driver provides access to
+	  I2C busses connected through a MUX, which is controlled
+	  by a CPLD register.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-mux-mlxcpld.
 
 endmenu
-- 
1.9.1

