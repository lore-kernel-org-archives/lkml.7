Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE1DC282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8402183F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555714468;
	bh=89T0JcF7PSh9zPmWK0qOYgfN+PVKA9PmFKUpijXkcqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y9RkF5hgxUGmvZRcULtyh2UBAWmvA3KktvHOeYRlQYN7ie1LuQrV9/NvAQZ1Kw3IF
	 E2sXK9gq/TuypnPbjcMPX1iUAc+1TOCZD8cTF1LaU6xJaO9QT4RWYsYB8zcyQvZL7R
	 G5+gdMqHHjg0mS1F2yH46mPK6cFUcwwOxucGGokY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfDSWyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:54:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49702 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfDSWyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gJ2PQQNaiu2hKSXn44Dr3ifW17YuOc71FwaAt+BwT5w=; b=r1KiZoXwmadwJQGyP5RsoRjbRi
        vYHsH1JCxZ0bD5RYu36PNNCiM1MxW3jyVKAQ02GT1OsxIDT68YTy7HfIy+rxaWcn+Dnq94WPYiCig
        5ZFsmeSt+Vutube4AVF6fNLwICqUYpLm8WYvCwWqTjKVIIq39cvTEtCaIOGuE+BA1c+DHLAlpkn3Z
        KUzDHAT77Axx4vZepIz42tnEiYvkv8bhXmtpPSncF8I8jS49HjR76DaQ0Zu2drvSny4t4IgAcYeD4
        OwJ4ayuKWjwvzYGVbVmjqOfwAcHl2XS9WUq1nS5pNnU1+YiwatcChZY/waBJgJroHvTaou120EVLt
        fqXF4rEA==;
Received: from 177.18.24.91.dynamic.adsl.gvt.net.br ([177.18.24.91] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHQnJ-0002uF-Pj; Fri, 19 Apr 2019 10:30:57 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hHQnG-0000D9-1h; Fri, 19 Apr 2019 07:30:54 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 2/2] docs: hwmon: remove the extension from .rst files
Date:   Fri, 19 Apr 2019 07:30:52 -0300
Message-Id: <79280b1c2193d9de3ad45df4f024a64c2c1c85d7.1555669842.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <70d1286cf7ddb5c44abb7278faac4b7f135d8462.1555669842.git.mchehab+samsung@kernel.org>
References: <70d1286cf7ddb5c44abb7278faac4b7f135d8462.1555669842.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On almost all places, we're including ReST files without the
extension.

Let's remove the extension here	as well, in order to use just
one standard.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/index.rst | 316 +++++++++++++++++-----------------
 1 file changed, 158 insertions(+), 158 deletions(-)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 893804414510..bc74c43e3e2c 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -5,11 +5,11 @@ Linux Hardware Monitoring
 .. toctree::
    :maxdepth: 1
 
-   hwmon-kernel-api.rst
-   pmbus-core.rst
-   submitting-patches.rst
-   sysfs-interface.rst
-   userspace-tools.rst
+   hwmon-kernel-api
+   pmbus-core
+   submitting-patches
+   sysfs-interface
+   userspace-tools
 
 Hardware Monitoring Kernel Drivers
 ==================================
@@ -17,159 +17,159 @@ Hardware Monitoring Kernel Drivers
 .. toctree::
    :maxdepth: 1
 
-   ab8500.rst
-   abituguru.rst
-   abituguru3.rst
-   abx500.rst
-   acpi_power_meter.rst
-   ad7314.rst
-   adc128d818.rst
-   adm1021.rst
-   adm1025.rst
-   adm1026.rst
-   adm1031.rst
-   adm1275.rst
-   adm9240.rst
-   ads1015.rst
-   ads7828.rst
-   adt7410.rst
-   adt7411.rst
-   adt7462.rst
-   adt7470.rst
-   adt7475.rst
-   amc6821.rst
-   asb100.rst
-   asc7621.rst
-   aspeed-pwm-tacho.rst
-   coretemp.rst
-   da9052.rst
-   da9055.rst
-   dme1737.rst
-   ds1621.rst
-   ds620.rst
-   emc1403.rst
-   emc2103.rst
-   emc6w201.rst
-   f71805f.rst
-   f71882fg.rst
-   fam15h_power.rst
-   ftsteutates.rst
-   g760a.rst
-   g762.rst
-   gl518sm.rst
-   hih6130.rst
-   ibmaem.rst
-   ibm-cffps.rst
-   ibmpowernv.rst
-   ina209.rst
-   ina2xx.rst
-   ina3221.rst
-   ir35221.rst
-   it87.rst
-   jc42.rst
-   k10temp.rst
-   k8temp.rst
-   lineage-pem.rst
-   lm25066.rst
-   lm63.rst
-   lm70.rst
-   lm73.rst
-   lm75.rst
-   lm77.rst
-   lm78.rst
-   lm80.rst
-   lm83.rst
-   lm85.rst
-   lm87.rst
-   lm90.rst
-   lm92.rst
-   lm93.rst
-   lm95234.rst
-   lm95245.rst
-   ltc2945.rst
-   ltc2978.rst
-   ltc2990.rst
-   ltc3815.rst
-   ltc4151.rst
-   ltc4215.rst
-   ltc4245.rst
-   ltc4260.rst
-   ltc4261.rst
-   max16064.rst
-   max16065.rst
-   max1619.rst
-   max1668.rst
-   max197.rst
-   max20751.rst
-   max31722.rst
-   max31785.rst
-   max31790.rst
-   max34440.rst
-   max6639.rst
-   max6642.rst
-   max6650.rst
-   max6697.rst
-   max8688.rst
-   mc13783-adc.rst
-   mcp3021.rst
-   menf21bmc.rst
-   mlxreg-fan.rst
-   nct6683.rst
-   nct6775.rst
-   nct7802.rst
-   nct7904.rst
-   npcm750-pwm-fan.rst
-   nsa320.rst
-   ntc_thermistor.rst
-   occ.rst
-   pc87360.rst
-   pc87427.rst
-   pcf8591.rst
-   pmbus.rst
-   powr1220.rst
-   pwm-fan.rst
-   raspberrypi-hwmon.rst
-   sch5627.rst
-   sch5636.rst
-   scpi-hwmon.rst
-   sht15.rst
-   sht21.rst
-   sht3x.rst
-   shtc1.rst
-   sis5595.rst
-   smm665.rst
-   smsc47b397.rst
-   smsc47m192.rst
-   smsc47m1.rst
-   tc654.rst
-   tc74.rst
-   thmc50.rst
-   tmp102.rst
-   tmp103.rst
-   tmp108.rst
-   tmp401.rst
-   tmp421.rst
-   tps40422.rst
-   twl4030-madc-hwmon.rst
-   ucd9000.rst
-   ucd9200.rst
-   vexpress.rst
-   via686a.rst
-   vt1211.rst
-   w83627ehf.rst
-   w83627hf.rst
-   w83773g.rst
-   w83781d.rst
-   w83791d.rst
-   w83792d.rst
-   w83793.rst
-   w83795.rst
-   w83l785ts.rst
-   w83l786ng.rst
-   wm831x.rst
-   wm8350.rst
-   xgene-hwmon.rst
-   zl6100.rst
+   ab8500
+   abituguru
+   abituguru3
+   abx500
+   acpi_power_meter
+   ad7314
+   adc128d818
+   adm1021
+   adm1025
+   adm1026
+   adm1031
+   adm1275
+   adm9240
+   ads1015
+   ads7828
+   adt7410
+   adt7411
+   adt7462
+   adt7470
+   adt7475
+   amc6821
+   asb100
+   asc7621
+   aspeed-pwm-tacho
+   coretemp
+   da9052
+   da9055
+   dme1737
+   ds1621
+   ds620
+   emc1403
+   emc2103
+   emc6w201
+   f71805f
+   f71882fg
+   fam15h_power
+   ftsteutates
+   g760a
+   g762
+   gl518sm
+   hih6130
+   ibmaem
+   ibm-cffps
+   ibmpowernv
+   ina209
+   ina2xx
+   ina3221
+   ir35221
+   it87
+   jc42
+   k10temp
+   k8temp
+   lineage-pem
+   lm25066
+   lm63
+   lm70
+   lm73
+   lm75
+   lm77
+   lm78
+   lm80
+   lm83
+   lm85
+   lm87
+   lm90
+   lm92
+   lm93
+   lm95234
+   lm95245
+   ltc2945
+   ltc2978
+   ltc2990
+   ltc3815
+   ltc4151
+   ltc4215
+   ltc4245
+   ltc4260
+   ltc4261
+   max16064
+   max16065
+   max1619
+   max1668
+   max197
+   max20751
+   max31722
+   max31785
+   max31790
+   max34440
+   max6639
+   max6642
+   max6650
+   max6697
+   max8688
+   mc13783-adc
+   mcp3021
+   menf21bmc
+   mlxreg-fan
+   nct6683
+   nct6775
+   nct7802
+   nct7904
+   npcm750-pwm-fan
+   nsa320
+   ntc_thermistor
+   occ
+   pc87360
+   pc87427
+   pcf8591
+   pmbus
+   powr1220
+   pwm-fan
+   raspberrypi-hwmon
+   sch5627
+   sch5636
+   scpi-hwmon
+   sht15
+   sht21
+   sht3x
+   shtc1
+   sis5595
+   smm665
+   smsc47b397
+   smsc47m192
+   smsc47m1
+   tc654
+   tc74
+   thmc50
+   tmp102
+   tmp103
+   tmp108
+   tmp401
+   tmp421
+   tps40422
+   twl4030-madc-hwmon
+   ucd9000
+   ucd9200
+   vexpress
+   via686a
+   vt1211
+   w83627ehf
+   w83627hf
+   w83773g
+   w83781d
+   w83791d
+   w83792d
+   w83793
+   w83795
+   w83l785ts
+   w83l786ng
+   wm831x
+   wm8350
+   xgene-hwmon
+   zl6100
 
 .. only::  subproject and html
 
-- 
2.20.1

