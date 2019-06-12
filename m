Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA2AC31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A67206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364778;
	bh=MnVX7iQuZIgqPHdb+CCEwhDt53v8Xsm2o490cwgty30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KqNoOAbeHmWPJW6pDrzsbvm5LFQAD5O7vJ2jZDcr3yVt4vAGlUNI1y9/zUl2eEFfc
	 tUdmnkrGLsVpkLlapalLn5xwFVeb5vjspA4QTAUf94AmNE0rKejh0ltwltZVYFoish
	 +gncjKTHkIg20cKJ+PedC3irYDw9ntwLPUJOmSZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbfFLSiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:38:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFLSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4cWjMp5PaXweLfT1aRxtKRWZepkzB8FeW0x9RJN+xzA=; b=fFfzR0nY3KBlmi9kEYQomsIs1Y
        Yo5w0uh8FH9ibI3g09bEmNWpOteBELNH9BUbTVzVjXXtOTpcoS2uShfpXzN3xeiSEPVZImVUvmSI7
        4A/ulRkVWW86ob5b/3ovk+NdG6rCezO6nnBoUXyVbgRaZVkKHP1V2ozhN1Nu/GIkTv5CtOCuU7t8I
        Tz1wyUbgGBMerieN5+EM5iKGvOXvOYoSp4DynwF3TslRFNuA5q+Qn53AQt/oxFZKmvk/QoOcfZwPv
        TjDcDsgmqjYYu5XilaJxABFyPXX4xqkd69AovT5Gb+yYR9a6DPL2qkhhoFgrOSuXgUawmcWe0mtCB
        Fvb/GaHQ==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YA-O0; Wed, 12 Jun 2019 18:38:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002Ax-2e; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 11/31] docs: memory-devices: convert ti-emif.txt to ReST
Date:   Wed, 12 Jun 2019 15:38:14 -0300
Message-Id: <96e9fd3498f65c961073a033cf1070252913db18.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare this file to be moved to a kernel book by converting
it to ReST format and renaming it to ti-emif.rst.

While this is not part of any book, mark it as :orphan:, in order
to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{ti-emif.txt => ti-emif.rst}              | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)
 rename Documentation/memory-devices/{ti-emif.txt => ti-emif.rst} (81%)

diff --git a/Documentation/memory-devices/ti-emif.txt b/Documentation/memory-devices/ti-emif.rst
similarity index 81%
rename from Documentation/memory-devices/ti-emif.txt
rename to Documentation/memory-devices/ti-emif.rst
index f4ad9a7d0f4b..c9242294e63c 100644
--- a/Documentation/memory-devices/ti-emif.txt
+++ b/Documentation/memory-devices/ti-emif.rst
@@ -1,20 +1,24 @@
-TI EMIF SDRAM Controller Driver:
+:orphan:
+
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
@@ -29,10 +33,11 @@ functions of the driver includes re-configuring AC timing
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
@@ -40,17 +45,19 @@ information can be passed through platform data (struct emif_platform_data)
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
2.21.0

