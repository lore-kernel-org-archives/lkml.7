Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC54CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A651C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555494415;
	bh=310wTViniLcYh4gh2Bq6fgseRFWAWJTfwcmq2h+BcYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cq/htDsZZsZgWZIPkA4SgX6LF+oKbWDG/BFXF18xEJ0BCMfQ6peU4wjlG8wd+wvq8
	 9+d4krJRVcr4paVS3WZ6TzamROhqNmOU8JGJsy/sAWx+6C/61luJqxxJBdHuYgOBcQ
	 8P929gDbXMjbTrEDZL/oZDL1eAsAlpMJf064Es/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbfDQJqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:46:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbfDQJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T9FpEx+v6dirYQZTfEZfPbIv51pWI5oRflnlTBdAXUY=; b=goV7bMHicbYRntVJTgbguoBQaM
        Odm046UHeDAmg2npO9g6EYrSR113MwbsQazz0BACus9WBjjqPYUGkvnLb3soZQ5jgKkfWrZb00sX/
        9mtZNPgrQ7tmvLQIXOWA/obkh8SdXIZFjm7qjqmVrI1K/793LmbIMVeSHW9yE5i7J2sHzB3X2KTWM
        9HV+gP1CP+kiqBL1VgrMaIUzGWaAlAZuAUZUUaMCY9shdXfIk7FQhEXlpb4abRBpH2j69wRRPc9vY
        iFYT1IIZSRup5pgZq9sFqX6p2YKnHFNQStbb/Ssy997oP3Es6g8GfWz9SMOSOoC5V0b5EQPEhlgDD
        4byUu/Aw==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGh9G-0000a9-Hk; Wed, 17 Apr 2019 09:46:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGh9C-0003ua-VO; Wed, 17 Apr 2019 06:46:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 08/21] docs: hwmon: w83791d: convert to ReST format
Date:   Wed, 17 Apr 2019 06:46:16 -0300
Message-Id: <38a07bc9042995a8fa88ba59f847238fcdff1c0e.1555494108.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555494108.git.mchehab+samsung@kernel.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert w83791d to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/w83791d | 123 +++++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 52 deletions(-)

diff --git a/Documentation/hwmon/w83791d b/Documentation/hwmon/w83791d
index f4021a285460..a91f9e5fb0c6 100644
--- a/Documentation/hwmon/w83791d
+++ b/Documentation/hwmon/w83791d
@@ -2,9 +2,13 @@ Kernel driver w83791d
 =====================
 
 Supported chips:
+
   * Winbond W83791D
+
     Prefix: 'w83791d'
+
     Addresses scanned: I2C 0x2c - 0x2f
+
     Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83791D_W83791Gb.pdf
 
 Author: Charles Spirakis <bezaur@gmail.com>
@@ -12,39 +16,46 @@ Author: Charles Spirakis <bezaur@gmail.com>
 This driver was derived from the w83781d.c and w83792d.c source files.
 
 Credits:
+
   w83781d.c:
-    Frodo Looijaard <frodol@dds.nl>,
-    Philip Edelbrock <phil@netroedge.com>,
-    and Mark Studebaker <mdsxyz123@yahoo.com>
+
+    - Frodo Looijaard <frodol@dds.nl>,
+    - Philip Edelbrock <phil@netroedge.com>,
+    - Mark Studebaker <mdsxyz123@yahoo.com>
+
   w83792d.c:
-    Shane Huang (Winbond),
-    Rudolf Marek <r.marek@assembler.cz>
+
+    - Shane Huang (Winbond),
+    - Rudolf Marek <r.marek@assembler.cz>
 
 Additional contributors:
-    Sven Anders <anders@anduras.de>
-    Marc Hulsman <m.hulsman@tudelft.nl>
+
+    - Sven Anders <anders@anduras.de>
+    - Marc Hulsman <m.hulsman@tudelft.nl>
 
 Module Parameters
 -----------------
 
 * init boolean
-  (default 0)
-  Use 'init=1' to have the driver do extra software initializations.
-  The default behavior is to do the minimum initialization possible
-  and depend on the BIOS to properly setup the chip. If you know you
-  have a w83791d and you're having problems, try init=1 before trying
-  reset=1.
+    (default 0)
+
+    Use 'init=1' to have the driver do extra software initializations.
+    The default behavior is to do the minimum initialization possible
+    and depend on the BIOS to properly setup the chip. If you know you
+    have a w83791d and you're having problems, try init=1 before trying
+    reset=1.
 
 * reset boolean
-  (default 0)
-  Use 'reset=1' to reset the chip (via index 0x40, bit 7). The default
-  behavior is no chip reset to preserve BIOS settings.
+    (default 0)
+
+    Use 'reset=1' to reset the chip (via index 0x40, bit 7). The default
+    behavior is no chip reset to preserve BIOS settings.
 
 * force_subclients=bus,caddr,saddr,saddr
-  This is used to force the i2c addresses for subclients of
-  a certain chip. Example usage is `force_subclients=0,0x2f,0x4a,0x4b'
-  to force the subclients of chip 0x2f on bus 0 to i2c addresses
-  0x4a and 0x4b.
+    This is used to force the i2c addresses for subclients of
+    a certain chip. Example usage is `force_subclients=0,0x2f,0x4a,0x4b`
+    to force the subclients of chip 0x2f on bus 0 to i2c addresses
+    0x4a and 0x4b.
 
 
 Description
@@ -91,11 +102,11 @@ This file is used for both legacy and new code.
 
 The sysfs interface to the beep bitmask has migrated from the original legacy
 method of a single sysfs beep_mask file to a newer method using multiple
-*_beep files as described in .../Documentation/hwmon/sysfs-interface.
+`*_beep` files as described in `Documentation/hwmon/sysfs-interface`.
 
 A similar change has occurred for the bitmap corresponding to the alarms. The
 original legacy method used a single sysfs alarms file containing a bitmap
-of triggered alarms. The newer method uses multiple sysfs *_alarm files
+of triggered alarms. The newer method uses multiple sysfs `*_alarm` files
 (again following the pattern described in sysfs-interface).
 
 Since both methods read and write the underlying hardware, they can be used
@@ -116,46 +127,54 @@ User mode code requesting values more often will receive cached values.
 The sysfs-interface is documented in the 'sysfs-interface' file. Only
 chip-specific options are documented here.
 
-pwm[1-3]_enable -	this file controls mode of fan/temperature control for
+======================= =======================================================
+pwm[1-3]_enable		this file controls mode of fan/temperature control for
 			fan 1-3. Fan/PWM 4-5 only support manual mode.
-		            * 1 Manual mode
-		            * 2 Thermal Cruise mode
-		            * 3 Fan Speed Cruise mode (no further support)
 
-temp[1-3]_target -	defines the target temperature for Thermal Cruise mode.
+			    * 1 Manual mode
+			    * 2 Thermal Cruise mode
+			    * 3 Fan Speed Cruise mode (no further support)
+
+temp[1-3]_target	defines the target temperature for Thermal Cruise mode.
 			Unit: millidegree Celsius
 			RW
 
-temp[1-3]_tolerance -	temperature tolerance for Thermal Cruise mode.
+temp[1-3]_tolerance	temperature tolerance for Thermal Cruise mode.
 			Specifies an interval around the target temperature
 			in which the fan speed is not changed.
 			Unit: millidegree Celsius
 			RW
+======================= =======================================================
 
 Alarms bitmap vs. beep_mask bitmask
-------------------------------------
+-----------------------------------
+
 For legacy code using the alarms and beep_mask files:
 
-in0 (VCORE)  :  alarms: 0x000001 beep_mask: 0x000001
-in1 (VINR0)  :  alarms: 0x000002 beep_mask: 0x002000 <== mismatch
-in2 (+3.3VIN):  alarms: 0x000004 beep_mask: 0x000004
-in3 (5VDD)   :  alarms: 0x000008 beep_mask: 0x000008
-in4 (+12VIN) :  alarms: 0x000100 beep_mask: 0x000100
-in5 (-12VIN) :  alarms: 0x000200 beep_mask: 0x000200
-in6 (-5VIN)  :  alarms: 0x000400 beep_mask: 0x000400
-in7 (VSB)    :  alarms: 0x080000 beep_mask: 0x010000 <== mismatch
-in8 (VBAT)   :  alarms: 0x100000 beep_mask: 0x020000 <== mismatch
-in9 (VINR1)  :  alarms: 0x004000 beep_mask: 0x004000
-temp1        :  alarms: 0x000010 beep_mask: 0x000010
-temp2        :  alarms: 0x000020 beep_mask: 0x000020
-temp3        :  alarms: 0x002000 beep_mask: 0x000002 <== mismatch
-fan1         :  alarms: 0x000040 beep_mask: 0x000040
-fan2         :  alarms: 0x000080 beep_mask: 0x000080
-fan3         :  alarms: 0x000800 beep_mask: 0x000800
-fan4         :  alarms: 0x200000 beep_mask: 0x200000
-fan5         :  alarms: 0x400000 beep_mask: 0x400000
-tart1        :  alarms: 0x010000 beep_mask: 0x040000 <== mismatch
-tart2        :  alarms: 0x020000 beep_mask: 0x080000 <== mismatch
-tart3        :  alarms: 0x040000 beep_mask: 0x100000 <== mismatch
-case_open    :  alarms: 0x001000 beep_mask: 0x001000
-global_enable:  alarms: -------- beep_mask: 0x800000 (modified via beep_enable)
+=============  ========  ========= ==========================
+Signal         Alarms    beep_mask Obs
+=============  ========  ========= ==========================
+in0 (VCORE)    0x000001  0x000001
+in1 (VINR0)    0x000002  0x002000  <== mismatch
+in2 (+3.3VIN)  0x000004  0x000004
+in3 (5VDD)     0x000008  0x000008
+in4 (+12VIN)   0x000100  0x000100
+in5 (-12VIN)   0x000200  0x000200
+in6 (-5VIN)    0x000400  0x000400
+in7 (VSB)      0x080000  0x010000  <== mismatch
+in8 (VBAT)     0x100000  0x020000  <== mismatch
+in9 (VINR1)    0x004000  0x004000
+temp1          0x000010  0x000010
+temp2          0x000020  0x000020
+temp3          0x002000  0x000002  <== mismatch
+fan1           0x000040  0x000040
+fan2           0x000080  0x000080
+fan3           0x000800  0x000800
+fan4           0x200000  0x200000
+fan5           0x400000  0x400000
+tart1          0x010000  0x040000  <== mismatch
+tart2          0x020000  0x080000  <== mismatch
+tart3          0x040000  0x100000  <== mismatch
+case_open      0x001000  0x001000
+global_enable  -         0x800000  (modified via beep_enable)
+=============  ========  ========= ==========================
-- 
2.20.1

