Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B017BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A4020857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfCKN1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:27:31 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:36589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbfCKNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:36 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mnac7-1gcDkR3n41-00jXMU for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 056/114] drivers: spi: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:08 +0100
Message-Id: <1552310346-7629-57-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:KXZ3Uu216TQMPsP+cOxxbw/9iRF/zhmEvxzV257NE4EBeu86XF0
 cDCwRaDFgFm1MVslCWvbl5wqjH9mrPhoEl8GnpSlP1pJ+S0E22KPVDEvJzBaWnvTnC+/3gP
 TjDgGi5SAIsAf9X3ppBdZB8nYasK0Pt9YcKfmIehEcUA6NAHKKnti+5oA8zEHBL5ber96JY
 fzHGJOtjKWQMFiApK+jIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f22cwRjUeA8=:xMIB+lEc//JDoN3Anyfyto
 /yeV3MCJKvD4+5mF5b4RW1oy3UTBS5X/kytoTlKr0v/PNHt7MVWlH6eHuQzsfkB2s91IYSFkA
 w8U4JrGp7ZemdBUXAoJOUnu0VdnEjSTLkkUtNwPSgagL99mOKL1BwG83EZEtUKqGb+8LiiHz8
 OPfwtu2jPIkA1Ic8CbFMDT+kKk+tkjEh5HcJ301RnZ5bB1kwmUATaFScV7Vz1vO/rxt+vc175
 2kNeMVWhJw5vHqI3JdG0vWC0kQ96z82ojO8WGeWpnsYIYmlE/km6v05oN3GolhDJagI72pLZl
 lmlpqD2xL7sbeL9vc47IzcIU2aKLE2+ToShvuFXqK0zxU7eRyGMRT9+DD4U3Mql6KrDT+DpH4
 JTrWKYo+HiCA7DKwyWn+ixAMoEDG9HYuVnO2idQJ/pbtkq4xSgiOekalWQJwrT/LlCAFOtVYw
 nDFxuQm7W+96EcyU92M+CAn14mzhkwt9D/IYdAy+qSFv/Kf0iPwux/WDsTnyrY5JZ4LJX0QQK
 ytsGXV18GZwnHM7VJB8Ahgc3Z7nwqtcGtXukIsUUlbLaNjZV4wDe414d/yQfSOEbwpfkDXpjc
 2fn+eJ7xPKGIWKLDcCeU6mjQP1pS5vr6WJ1uNfeWdHydkMIMYEqdN/8Wlf1cVsCVRa2SeZoND
 bqvdUTp+bhYUc8yiuUG37kww/q9x/brSr7LsAOjs4PctGWdGkWRoQP7m6Wr36DPntLV3kjrJT
 O4TuY8UF5og+sRXJyXUw8Nw/jhQCuz0XvAPcGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/spi/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f761655..73d31a5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -142,7 +142,7 @@ config SPI_BCM63XX
 	tristate "Broadcom BCM63xx SPI controller"
 	depends on BCM63XX || COMPILE_TEST
 	help
-          Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
+	  Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
 
 config SPI_BCM63XX_HSSPI
 	tristate "Broadcom BCM63XX HS SPI controller driver"
@@ -230,14 +230,14 @@ config SPI_DW_MMIO
 	depends on SPI_DESIGNWARE
 
 config SPI_DLN2
-       tristate "Diolan DLN-2 USB SPI adapter"
-       depends on MFD_DLN2
-       help
-         If you say yes to this option, support will be included for Diolan
-         DLN2, a USB to SPI interface.
+	tristate "Diolan DLN-2 USB SPI adapter"
+	depends on MFD_DLN2
+	help
+	  If you say yes to this option, support will be included for Diolan
+	  DLN2, a USB to SPI interface.
 
-         This driver can also be built as a module.  If so, the module
-         will be called spi-dln2.
+	  This driver can also be built as a module.  If so, the module
+	  will be called spi-dln2.
 
 config SPI_EFM32
 	tristate "EFM32 SPI controller"
@@ -727,10 +727,10 @@ config SPI_SUN6I
 	  This enables using the SPI controller on the Allwinner A31 SoCs.
 
 config SPI_MXIC
-        tristate "Macronix MX25F0A SPI controller"
-        depends on SPI_MASTER
-        help
-          This selects the Macronix MX25F0A SPI controller driver.
+	tristate "Macronix MX25F0A SPI controller"
+	depends on SPI_MASTER
+	help
+	  This selects the Macronix MX25F0A SPI controller driver.
 
 config SPI_MXS
 	tristate "Freescale MXS SPI controller"
-- 
1.9.1

