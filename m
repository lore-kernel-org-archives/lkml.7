Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E79C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A5820818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894865;
	bh=t1tLMNhpDmnVUogcnR769TRTWOLd+uhiXrw/mXwLtk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OerJa0KInqU6pjxjTA1rhLiGwBJM9jDrpWERbPhqRuVuMHDJ/e+RIFEb0PICZGIQt
	 oLdjfKiqt/tKl5bOWti5csCCWDwwhsBzXKAD3kay2l4UBRm3f+rWivpq8820rD4vrc
	 +sBecLdpG0nI/JWYe09+v/Ywrdf4UPirb4CAYDbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfDJLOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:14:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730822AbfDJLMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/B+lWmatDXzgWdtG0bzCa3wUSj6cMsUS9L/SsfIHpEM=; b=QoMwkrd/PRXaz2tAS/SDKCpggU
        9SMxE0+I/0sVAUNmQtbEnfBP84pdhTNrihkpV8BkUM1OGj3gtmRsVVAV3/NlGeN5+9HqFj2KK9HXz
        H9/4lstPVvRPFZf/dvpdUFd+vmLsjHeOAJLhhZnwRCxEz0D8asEyeffMcM6PGyi1oJOWwecsPxQ6S
        1/KhwM6XOT6X04WXTlcPzHjPS2xhvj01mEDxSp7K2trmdIlmbWQYMTnEDV4EKP/IdQVMfBV9ugrL4
        xJtLhWL3BepoG6AltRJTfYELcCMPnyTf8DFGuy34vFRcldDB7MMcxd1zdnx3SNnmfnlPoXgM8l0d3
        zxXe+VQw==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEB9L-0006mv-KK; Wed, 10 Apr 2019 11:12:15 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEB9J-0007SN-7g; Wed, 10 Apr 2019 08:12:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 01/21] docs: hwmon: k10temp: convert to ReST format
Date:   Wed, 10 Apr 2019 08:11:51 -0300
Message-Id: <9ed53a4f160d7cd4f7c05fb919196ac15ecb6d63.1554893882.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554893881.git.mchehab+samsung@kernel.org>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert k10temp to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org
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

