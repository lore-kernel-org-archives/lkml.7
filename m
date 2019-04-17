Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD025C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7967D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555494425;
	bh=Yc/FLqXQMdNValdr8j0Ryj4GGZiq7XWnjcOa3w9Nxv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ky+9Jdq4AKcKO1utv32DJzUmx1R+K2WeIE821m5faZOPwJm5xsEKgljLzXHamPjI
	 hf60ZkToIGPl3goXJZgje4kChsnsgsQiBPmu+/CSpPgJ9E/dusd0zwQxFVqoBJQew7
	 UNXFV8FYxEi0MhYa+pFQvLftw9jSSlMzd4rAYNQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbfDQJqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:46:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731645AbfDQJqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q1pNcpslvmb56dzJY2LQ9VFTGyQXrn+n93Lv3V4JY2c=; b=oPnLT253S6biASai9M/vZlBPYS
        93eiTuJ9TdiqJqvh9nZ+05jNnzKT6D26a+QoPgvCXuVtqdnjXMHOtd0zD/GSdOjAHJpdgakji2yog
        gSGd9U/5BZ9lO4V/mPqqIllEGdHBSOr0jUl6qtATLnpoK0qnHVlN08vVlPcUClkFPbwbYlVHTtTud
        dzwZsgq3kBNOa2n3eAJ+uxcANQyULA9I9y0G96c7tDYvQUpR+e/mg2OvODWk5swRfLzbJEWDjSNNu
        zx7y0A/wdBCN4qjIrcyo/8Ekz1S6tAMT3OOsfozgcZCzvEl5rY1rXiPH24+Iq8UUoXJtIzC8UkRxy
        pp5LkGqw==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGh9G-0000a3-Jk; Wed, 17 Apr 2019 09:46:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGh9C-0003u8-PW; Wed, 17 Apr 2019 06:46:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 01/21] docs: hwmon: k10temp: convert to ReST format
Date:   Wed, 17 Apr 2019 06:46:09 -0300
Message-Id: <9ed57114de6b0a1ed13a8b219ccb579ca2662320.1555494108.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555494108.git.mchehab+samsung@kernel.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert k10temp to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/k10temp | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/k10temp b/Documentation/hwmon/k10temp
index 254d2f55345a..12a86ba17de9 100644
--- a/Documentation/hwmon/k10temp
+++ b/Documentation/hwmon/k10temp
@@ -2,42 +2,77 @@ Kernel driver k10temp
 =====================
 
 Supported chips:
+
 * AMD Family 10h processors:
+
   Socket F: Quad-Core/Six-Core/Embedded Opteron (but see below)
+
   Socket AM2+: Quad-Core Opteron, Phenom (II) X3/X4, Athlon X2 (but see below)
+
   Socket AM3: Quad-Core Opteron, Athlon/Phenom II X2/X3/X4, Sempron II
+
   Socket S1G3: Athlon II, Sempron, Turion II
+
 * AMD Family 11h processors:
+
   Socket S1G2: Athlon (X2), Sempron (X2), Turion X2 (Ultra)
+
 * AMD Family 12h processors: "Llano" (E2/A4/A6/A8-Series)
+
 * AMD Family 14h processors: "Brazos" (C/E/G/Z-Series)
+
 * AMD Family 15h processors: "Bulldozer" (FX-Series), "Trinity", "Kaveri", "Carrizo"
+
 * AMD Family 16h processors: "Kabini", "Mullins"
 
   Prefix: 'k10temp'
+
   Addresses scanned: PCI space
+
   Datasheets:
+
   BIOS and Kernel Developer's Guide (BKDG) For AMD Family 10h Processors:
+
     http://support.amd.com/us/Processor_TechDocs/31116.pdf
+
   BIOS and Kernel Developer's Guide (BKDG) for AMD Family 11h Processors:
+
     http://support.amd.com/us/Processor_TechDocs/41256.pdf
+
   BIOS and Kernel Developer's Guide (BKDG) for AMD Family 12h Processors:
+
     http://support.amd.com/us/Processor_TechDocs/41131.pdf
+
   BIOS and Kernel Developer's Guide (BKDG) for AMD Family 14h Models 00h-0Fh Processors:
+
     http://support.amd.com/us/Processor_TechDocs/43170.pdf
+
   Revision Guide for AMD Family 10h Processors:
+
     http://support.amd.com/us/Processor_TechDocs/41322.pdf
+
   Revision Guide for AMD Family 11h Processors:
+
     http://support.amd.com/us/Processor_TechDocs/41788.pdf
+
   Revision Guide for AMD Family 12h Processors:
+
     http://support.amd.com/us/Processor_TechDocs/44739.pdf
+
   Revision Guide for AMD Family 14h Models 00h-0Fh Processors:
+
     http://support.amd.com/us/Processor_TechDocs/47534.pdf
+
   AMD Family 11h Processor Power and Thermal Data Sheet for Notebooks:
+
     http://support.amd.com/us/Processor_TechDocs/43373.pdf
+
   AMD Family 10h Server and Workstation Processor Power and Thermal Data Sheet:
+
     http://support.amd.com/us/Processor_TechDocs/43374.pdf
+
   AMD Family 10h Desktop Processor Power and Thermal Data Sheet:
+
     http://support.amd.com/us/Processor_TechDocs/43375.pdf
 
 Author: Clemens Ladisch <clemens@ladisch.de>
@@ -60,7 +95,7 @@ are using an AM3 processor on an AM2+ mainboard, you can safely use the
 
 There is one temperature measurement value, available as temp1_input in
 sysfs. It is measured in degrees Celsius with a resolution of 1/8th degree.
-Please note that it is defined as a relative value; to quote the AMD manual:
+Please note that it is defined as a relative value; to quote the AMD manual::
 
   Tctl is the processor temperature control value, used by the platform to
   control cooling systems. Tctl is a non-physical temperature on an
-- 
2.20.1

