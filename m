Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8006BC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A9420850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894822;
	bh=/n0QS1Mzj9bvYeGqcwkyN9+ti2FuCmSx5A4+Z0bJ/RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OVSf6xq57NAXMfyqW6GUPUEi331eyeKWCCOtp1bwWwzmaduFNN1UNbTRksjOaTX2w
	 Pso4/XMZl5b3FpZMf4whIj2xpTPr5rsc4chUnpwr3Dm8IuFkbq2OXgsqBIHlirVq8K
	 1Q3C+XVepzaAW/sHh4HK77TyIENqQRaA8PtwSa7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbfDJLNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:13:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbfDJLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mlRqSQKMERxo4U6P56rCaREwz+SXWHUjZdwuZwnS5MU=; b=iZJ5Sxgq8TxqScfGLhu7hC2yWe
        jK99oQ37BnYhD4ahp2oysOLv8DnvOKssjVkx2hq45f5reV5FVMQBjAnfvrwgj94UDiq0N0GxXpq54
        OwJB30j126QSIoJCtTtb8UdRMBs2zhJUdnHwDaI+eIxOm2QVwtA3gFPfZTbQDOzL+ECjDXOUVQG0d
        hOOmgdOStw0g4zcNOEHdHq0km5UsSxaGSxLkztaIFOUpvqciNWeJHdvGi0Xu/55bHk8zK/qOJO8ns
        RDEdWIzsxq1iptcDLwivopsTV6l35CZfeXg2EBu645XWyKpkgxbAoRXI4AnbpzBs9pcf/JGE7jiHI
        X48NsJBA==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEB9L-0006n0-MU; Wed, 10 Apr 2019 11:12:15 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEB9J-0007St-ED; Wed, 10 Apr 2019 08:12:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 09/21] docs: hwmon: coretemp: convert to ReST format
Date:   Wed, 10 Apr 2019 08:11:59 -0300
Message-Id: <2a3a67d543eef1712a0cc4175ba8e684bd49bb22.1554893882.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554893881.git.mchehab+samsung@kernel.org>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert coretemp to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org
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

