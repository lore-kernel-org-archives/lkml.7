Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD72EC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FDA20721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306366;
	bh=ifqHJVoSLl+vbbYtf0TPbPr6t6kMcndP/j4HcMcUtpU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uzW5JEInrYlwu6vh5qXtcJ0dI/s6OPOZs/Xb0MsggbFl4/+sIMqRm58kvSXVqFPQP
	 om54z+sJFTEsWhcVQgg4E770SeyzFxAs/eHFR7xmBBPr1Jw6wLJXH7ouoUl9WQj/Wi
	 JxaSuez+4ZEGuVFypTR/oDsYL/Mk/UojfGHrFqo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfKUDTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:19:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:32768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbfKUDTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:23 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40A322089D;
        Thu, 21 Nov 2019 03:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306362;
        bh=ifqHJVoSLl+vbbYtf0TPbPr6t6kMcndP/j4HcMcUtpU=;
        h=From:To:Cc:Subject:Date:From;
        b=yYq4Yd0UuWujyXv+F5jJ06wCTGY+2AJPa9SeACpXMOmQQ9HILv+UP/Idh5ilBtPMe
         PJ9qRQ5svMZe3Yhm4nfZB/JIKbVIyq8gxDtqFR1fWZxqrYvtzhF9h39+Yny68QUly1
         q2IOvxfiGYVzYkjx8mms3Cje44wYv1WEU0+Y/tLM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:19 +0100
Message-Id: <1574306359-29372-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/iio/gyro/Kconfig | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 95e6f96d4529..7de77419b4a1 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -75,26 +75,26 @@ config BMG160_SPI
 	select REGMAP_SPI
 
 config FXAS21002C
-       tristate "NXP FXAS21002C Gyro Sensor"
-       select IIO_BUFFER
-       select IIO_TRIGGERED_BUFFER
-       select FXAS21002C_I2C if (I2C)
-       select FXAS21002C_SPI if (SPI)
-       depends on (I2C || SPI_MASTER)
-       help
-         Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
-         Sensor driver connected via I2C or SPI.
-
-         This driver can also be built as a module.  If so, the module
-         will be called fxas21002c_i2c or fxas21002c_spi.
+	tristate "NXP FXAS21002C Gyro Sensor"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select FXAS21002C_I2C if (I2C)
+	select FXAS21002C_SPI if (SPI)
+	depends on (I2C || SPI_MASTER)
+	help
+	 Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
+	 Sensor driver connected via I2C or SPI.
+
+	 This driver can also be built as a module.  If so, the module
+	 will be called fxas21002c_i2c or fxas21002c_spi.
 
 config FXAS21002C_I2C
-       tristate
-       select REGMAP_I2C
+	tristate
+	select REGMAP_I2C
 
 config FXAS21002C_SPI
-       tristate
-       select REGMAP_SPI
+	tristate
+	select REGMAP_SPI
 
 config HID_SENSOR_GYRO_3D
 	depends on HID_SENSOR_HUB
-- 
2.7.4

