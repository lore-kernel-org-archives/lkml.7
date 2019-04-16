Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A652C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057E820656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383749;
	bh=ahpd6P217+zRCs+vSIUNZSR2oMilYY0CJ5PazONy9nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hjRgqUe7ey8+esgZJHrUJLMpYzN401goCtVJnKmuCnNFPSwQkwz/iC/xvXUPL9Xcl
	 xobRD88gpReA8bo4Y7atF7rDJtrSgztELRcduaX5y6lAeYf8Or5Yom8oet9ioTpf2Y
	 Ora59vG+EYNo/9qSaPwnGyTcqk26EkSUhxv4swQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDPDCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:02:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfDPC4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q+3EGdDIPNdAXYdZsIcsA19ZmC3MF/U+m8Me7nsjfpc=; b=el0vw79HHjbsTtt4ZEshIsivdz
        qckrtfdk8kl2lDCdSqXv9XK0V5gb3zwHnXcYWAsDyiSW4Do+S7tCUD9Cs8GC7TTRQ8NRnuRRBkgms
        RwgpYp9W8g/wH4AbpIdywnwuW8h+rG/nr/A0ZecbKCnGjfFaB1FHsFRMprgqjJUdYfWCdnfloVMEz
        5eFgWlIHfIaQAoR0lSyHJd8t8uRqNQ22WcxDawnM5rW9g5xybJgB4rIQfc86vw8M98+K3P2rd1Zo5
        GcNASURqNNDjL13Kakc0pSTp646K8QSM/Fu6u+an2gJoUmmwKEVviyO9/VqIaDRw8ZaoSoZ0nRIb6
        l8LgkRuA==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGt-0007aS-Lq; Tue, 16 Apr 2019 02:56:31 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGo-0001q2-Bl; Mon, 15 Apr 2019 23:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 52/57] docs: memory-devices: convert ti-emif.txt to ReST format
Date:   Mon, 15 Apr 2019 23:56:17 -0300
Message-Id: <67c899f93d3e5c7ac712488f6d498777f0a0390f.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare this file to be moved to a kernel book by converting
it to ReST format.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/bus-devices/ti-gpmc.txt    |  1 +
 Documentation/memory-devices/ti-emif.txt | 25 ++++++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/bus-devices/ti-gpmc.txt b/Documentation/bus-devices/ti-gpmc.txt
index cc9ce57e0a26..c434fcfc5e4c 100644
--- a/Documentation/bus-devices/ti-gpmc.txt
+++ b/Documentation/bus-devices/ti-gpmc.txt
@@ -3,6 +3,7 @@ GPMC (General Purpose Memory Controller):
 
 GPMC is an unified memory controller dedicated to interfacing external
 memory devices like
+
  * Asynchronous SRAM like memories and application specific integrated
    circuit devices.
  * Asynchronous, synchronous, and page mode burst NOR flash devices
diff --git a/Documentation/memory-devices/ti-emif.txt b/Documentation/memory-devices/ti-emif.txt
index f4ad9a7d0f4b..371f581bd276 100644
--- a/Documentation/memory-devices/ti-emif.txt
+++ b/Documentation/memory-devices/ti-emif.txt
@@ -1,20 +1,22 @@
-TI EMIF SDRAM Controller Driver:
+===============================
+TI EMIF SDRAM Controller Driver
+===============================
 
 Author
-========
+======
 Aneesh V <aneesh@ti.com>
 
 Location
-============
+========
 driver/memory/emif.c
 
 Supported SoCs:
-===================
+===============
 TI OMAP44xx
 TI OMAP54xx
 
 Menuconfig option:
-==========================
+==================
 Device Drivers
 	Memory devices
 		Texas Instruments EMIF driver
@@ -29,10 +31,11 @@ functions of the driver includes re-configuring AC timing
 parameters and other settings during frequency, voltage and
 temperature changes
 
-Platform Data (see include/linux/platform_data/emif_plat.h):
-=====================================================================
+Platform Data (see include/linux/platform_data/emif_plat.h)
+===========================================================
 DDR device details and other board dependent and SoC dependent
 information can be passed through platform data (struct emif_platform_data)
+
 - DDR device details: 'struct ddr_device_info'
 - Device AC timings: 'struct lpddr2_timings' and 'struct lpddr2_min_tck'
 - Custom configurations: customizable policy options through
@@ -40,17 +43,19 @@ information can be passed through platform data (struct emif_platform_data)
 - IP revision
 - PHY type
 
-Interface to the external world:
-================================
+Interface to the external world
+===============================
 EMIF driver registers notifiers for voltage and frequency changes
 affecting EMIF and takes appropriate actions when these are invoked.
+
 - freq_pre_notify_handling()
 - freq_post_notify_handling()
 - volt_notify_handling()
 
 Debugfs
-========
+=======
 The driver creates two debugfs entries per device.
+
 - regcache_dump : dump of register values calculated and saved for all
   frequencies used so far.
 - mr4 : last polled value of MR4 register in the LPDDR2 device. MR4
-- 
2.20.1

