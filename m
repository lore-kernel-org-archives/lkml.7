Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB655C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F9C2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555494406;
	bh=dzp3IsEVCphMnbgP4k2U8VhFQmoTeSsxphS5KQ+jf/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kSDgaKXLTYXF8axj1niBzf45sbJsfIkQ0Jzr9LBkIAf1Hk6d70XnR4kAGRb8Cn7C2
	 2vV1E8DnWvBLow2wdRnAZ4ZNiVGtNMsNkQ4YfbhLxl89p22Qjvq2xSUlHDSWL5L+Gq
	 t5gSvvWjvffjA/cPzHKlIoSWVQ35oUXcq4Khi/V8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbfDQJqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:46:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731632AbfDQJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XJ5nNnNov1WL9We9Rkq0YuX1IdpxSUQHOhnmRyQ5KdY=; b=sKSNJPQLGO0D/zt+T5GNzRoia8
        9UjLRTJFRkxV/JrJwL5Orq08QFcfZjJn8stjoQs8LTYmwhq1g5O/lMUFt4uWLlpdQJoMa9L9v2M2x
        lXXqjJrE7gJEe2RllGIbUrfXY1nCTrv+rWJm6QQJUCNARy0unLvjS6MN9AKfG+0inKpVO36cab4Dt
        h/ngBkXfGCAuRWcobOJVpfRQ9T5JmPYE7hkZaInb7HfHEemwmfgWxy2fAoUGtYfS3StG9CJnjNR4p
        GNqwHp6U8DCb7e+umFCnUVM7Vr2pMFJMTpJo8DHgc+guD80pfN/G8QtLTSo32fW/LJPYXIYIerhGS
        2i3X7+9w==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGh9G-0000aB-Gg; Wed, 17 Apr 2019 09:46:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGh9C-0003ue-WF; Wed, 17 Apr 2019 06:46:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 09/21] docs: hwmon: coretemp: convert to ReST format
Date:   Wed, 17 Apr 2019 06:46:17 -0300
Message-Id: <5d264b71876d4e03dd72e27749158a30794cc1b8.1555494108.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555494108.git.mchehab+samsung@kernel.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert coretemp to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/coretemp | 46 +++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
index fec5a9bf755f..c609329e3bc4 100644
--- a/Documentation/hwmon/coretemp
+++ b/Documentation/hwmon/coretemp
@@ -3,20 +3,29 @@ Kernel driver coretemp
 
 Supported chips:
   * All Intel Core family
+
     Prefix: 'coretemp'
-    CPUID: family 0x6, models 0xe (Pentium M DC), 0xf (Core 2 DC 65nm),
-                              0x16 (Core 2 SC 65nm), 0x17 (Penryn 45nm),
-                              0x1a (Nehalem), 0x1c (Atom), 0x1e (Lynnfield),
-                              0x26 (Tunnel Creek Atom), 0x27 (Medfield Atom),
-                              0x36 (Cedar Trail Atom)
-    Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
-               Volume 3A: System Programming Guide
-               http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
+
+    CPUID: family 0x6, models
+
+			    - 0xe (Pentium M DC), 0xf (Core 2 DC 65nm),
+			    - 0x16 (Core 2 SC 65nm), 0x17 (Penryn 45nm),
+			    - 0x1a (Nehalem), 0x1c (Atom), 0x1e (Lynnfield),
+			    - 0x26 (Tunnel Creek Atom), 0x27 (Medfield Atom),
+			    - 0x36 (Cedar Trail Atom)
+
+    Datasheet:
+
+	       Intel 64 and IA-32 Architectures Software Developer's Manual
+	       Volume 3A: System Programming Guide
+
+	       http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
 
 Author: Rudolf Marek
 
 Description
 -----------
+
 This driver permits reading the DTS (Digital Temperature Sensor) embedded
 inside Intel CPUs. This driver can read both the per-core and per-package
 temperature using the appropriate sensors. The per-package sensor is new;
@@ -35,14 +44,17 @@ may be raised, if the temperature grows enough (more than TjMax) to trigger
 the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
 
 All Sysfs entries are named with their core_id (represented here by 'X').
-tempX_input	 - Core temperature (in millidegrees Celsius).
-tempX_max	 - All cooling devices should be turned on (on Core2).
-tempX_crit	 - Maximum junction temperature (in millidegrees Celsius).
-tempX_crit_alarm - Set when Out-of-spec bit is set, never clears.
-		   Correct CPU operation is no longer guaranteed.
-tempX_label	 - Contains string "Core X", where X is processor
-		   number. For Package temp, this will be "Physical id Y",
-		   where Y is the package number.
+
+================= ========================================================
+tempX_input	  Core temperature (in millidegrees Celsius).
+tempX_max	  All cooling devices should be turned on (on Core2).
+tempX_crit	  Maximum junction temperature (in millidegrees Celsius).
+tempX_crit_alarm  Set when Out-of-spec bit is set, never clears.
+		  Correct CPU operation is no longer guaranteed.
+tempX_label	  Contains string "Core X", where X is processor
+		  number. For Package temp, this will be "Physical id Y",
+		  where Y is the package number.
+================= ========================================================
 
 On CPU models which support it, TjMax is read from a model-specific register.
 On other models, it is set to an arbitrary value based on weak heuristics.
@@ -52,6 +64,7 @@ as a module parameter (tjmax).
 Appendix A. Known TjMax lists (TBD):
 Some information comes from ark.intel.com
 
+=============== =============================================== ================
 Process		Processor					TjMax(C)
 
 22nm		Core i5/i7 Processors
@@ -179,3 +192,4 @@ Process		Processor					TjMax(C)
 65nm		Celeron Processors
 		T1700/1600					100
 		560/550/540/530					100
+=============== =============================================== ================
-- 
2.20.1

