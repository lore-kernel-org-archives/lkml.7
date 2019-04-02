Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC76C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E8721473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201182;
	bh=AKr6t1xXWnweNX3s4uwiR+GQcz0UOYU5vc4Z3bTWT/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jvxrwpsWdMjckxn72ZUbXflFmym2eUDcjBBnc+gb1Qi+dP85X78rMa3HmY697hYAN
	 EXZ+3ymAvGzsUSemUS629fatsyLZO5fF3tjOa4qKGjA/VcG8oUk5LNK5EIese+UrAM
	 Qy1yZfkCLx9TbThXYA+aUNBDAw+Xdnkoh+9bZZzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfDBKdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730484AbfDBKcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A522133D;
        Tue,  2 Apr 2019 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201174;
        bh=AKr6t1xXWnweNX3s4uwiR+GQcz0UOYU5vc4Z3bTWT/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNbYYTcQ47XjxFSSjzmgKhK1wXSdNnegXKH5jBTqTP+wt7oigdF/A3q/alnr2fo2m
         6eZFnyOxllWmH79SA8z9w1uFoHiFukqz/mYbfYum5BJanK3bP5ANb6+5SkW3J8kAjB
         6Kn+kY8CzxZJFdjo8oclnjETazjjn9OIYpQPrusE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 08/16] staging: iio: add proper SPDX identifiers to remaining driver files
Date:   Tue,  2 Apr 2019 12:31:55 +0200
Message-Id: <20190402103203.14959-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of IIO staging drivers that do not have a proper SPDX
identifier on it.  So fix that up and at the same time, remove the "free
form" license text, as that's pretty much impossible for any tool to
parse.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/iio/accel/adis16203.c           | 3 +--
 drivers/staging/iio/accel/adis16240.c           | 3 +--
 drivers/staging/iio/adc/ad7192.c                | 3 +--
 drivers/staging/iio/adc/ad7192.h                | 3 +--
 drivers/staging/iio/adc/ad7280a.c               | 3 +--
 drivers/staging/iio/adc/ad7280a.h               | 3 +--
 drivers/staging/iio/adc/ad7780.c                | 3 +--
 drivers/staging/iio/adc/ad7816.c                | 3 +--
 drivers/staging/iio/addac/adt7316-i2c.c         | 3 +--
 drivers/staging/iio/addac/adt7316-spi.c         | 3 +--
 drivers/staging/iio/addac/adt7316.c             | 4 +---
 drivers/staging/iio/addac/adt7316.h             | 3 +--
 drivers/staging/iio/cdc/ad7150.c                | 3 +--
 drivers/staging/iio/cdc/ad7746.c                | 3 +--
 drivers/staging/iio/cdc/ad7746.h                | 3 +--
 drivers/staging/iio/frequency/ad9832.c          | 3 +--
 drivers/staging/iio/frequency/ad9832.h          | 3 +--
 drivers/staging/iio/frequency/ad9834.c          | 3 +--
 drivers/staging/iio/frequency/ad9834.h          | 3 +--
 drivers/staging/iio/frequency/dds.h             | 3 +--
 drivers/staging/iio/impedance-analyzer/ad5933.c | 3 +--
 drivers/staging/iio/meter/ade7854-i2c.c         | 3 +--
 drivers/staging/iio/meter/ade7854-spi.c         | 3 +--
 drivers/staging/iio/meter/ade7854.c             | 3 +--
 drivers/staging/iio/resolver/ad2s1210.c         | 6 +-----
 25 files changed, 25 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 5cc96c8086b5..70381756a64a 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ADIS16203 Programmable 360 Degrees Inclinometer
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 24e525f1ef25..b80e0d248b0f 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ADIS16240 Programmable Impact Sensor and Recorder driver
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index acdbc07fd259..dfb79fbf63f4 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7190 AD7192 AD7193 AD7195 SPI ADC driver
  *
  * Copyright 2011-2015 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
index 7433a43c2611..e382b22c460b 100644
--- a/drivers/staging/iio/adc/ad7192.h
+++ b/drivers/staging/iio/adc/ad7192.h
@@ -1,9 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * AD7190 AD7192 AD7195 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 #ifndef IIO_ADC_AD7192_H_
 #define IIO_ADC_AD7192_H_
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d9df12665176..47cfe920b2ae 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7280A Lithium Ion Battery Monitoring System
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/crc8.h>
diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
index ccfb90d20e71..23f18bb9e279 100644
--- a/drivers/staging/iio/adc/ad7280a.h
+++ b/drivers/staging/iio/adc/ad7280a.h
@@ -1,9 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * AD7280A Lithium Ion Battery Monitoring System
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #ifndef IIO_ADC_AD7280_H_
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c4a85789c2db..c15389f562b2 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index ee50e7296795..a0e13f29ec07 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * AD7816 digital temperature sensor driver supporting AD7816/7/8
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 0f26bc38edc6..5543cc909707 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * I2C bus driver for ADT7316/7/8 ADT7516/7/9 digital temperature
  * sensor, ADC and DAC
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/device.h>
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 8294b9c1e3c2..2066241b15b1 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * API bus driver for ADT7316/7/8 ADT7516/7/9 digital temperature
  * sensor, ADC and DAC
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/device.h>
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 5e5d3d961a6c..b6a65ee8d558 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ADT7316 digital temperature sensor driver supporting ADT7316/7/8 ADT7516/7/9
  *
- *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index 84ca4f6c88f5..8c2a92ae7157 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -1,9 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * ADT7316 digital temperature sensor driver supporting ADT7316/7/8 ADT7516/7/9
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #ifndef _ADT7316_H_
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 24f74ce60f80..dd7fcab8e19e 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * AD7150 capacitive sensor driver supporting AD7150/1/6
  *
  * Copyright 2010-2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 0eb28fea876e..47610d863908 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
index ea8572d1df02..8bdbd732dbbd 100644
--- a/drivers/staging/iio/cdc/ad7746.h
+++ b/drivers/staging/iio/cdc/ad7746.h
@@ -1,9 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #ifndef IIO_CDC_AD7746_H_
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index a3ce50427724..18fae8ff5dd9 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD9832 SPI DDS driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/device.h>
diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
index 39d326cc1af9..dc66477f4c84 100644
--- a/drivers/staging/iio/frequency/ad9832.h
+++ b/drivers/staging/iio/frequency/ad9832.h
@@ -1,9 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * AD9832 SPI DDS driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 #ifndef IIO_DDS_AD9832_H_
 #define IIO_DDS_AD9832_H_
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 0b0287503fb4..fc7e1126d143 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD9833/AD9834/AD9837/AD9838 SPI DDS driver
  *
  * Copyright 2010-2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/staging/iio/frequency/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
index da7e83ceedad..521943aa0e61 100644
--- a/drivers/staging/iio/frequency/ad9834.h
+++ b/drivers/staging/iio/frequency/ad9834.h
@@ -1,9 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * AD9833/AD9834/AD9837/AD9838 SPI DDS driver
  *
  * Copyright 2010-2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 #ifndef IIO_DDS_AD9834_H_
 #define IIO_DDS_AD9834_H_
diff --git a/drivers/staging/iio/frequency/dds.h b/drivers/staging/iio/frequency/dds.h
index d6ccd99c14d7..2ebe68eb7398 100644
--- a/drivers/staging/iio/frequency/dds.h
+++ b/drivers/staging/iio/frequency/dds.h
@@ -1,9 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * dds.h - sysfs attributes associated with DDS devices
  *
  * Copyright (c) 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 #ifndef IIO_DDS_H_
 #define IIO_DDS_H_
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 3134295f014f..f98f6e8ff390 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD5933 AD5934 Impedance Converter, Network Analyzer
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index c3aa6ea9d036..a9a06e8dda51 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver (I2C Bus)
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/device.h>
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index fc9146757283..f12a6c8b3e88 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver (SPI Bus)
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/device.h>
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 029c3bf42d4d..b7fbf9022046 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/interrupt.h>
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index cec9d995b3df..b6be0bc202f5 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ad2s1210.c support for the ADI Resolver to Digital Converters: AD2S1210
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 #include <linux/types.h>
 #include <linux/mutex.h>
-- 
2.21.0

