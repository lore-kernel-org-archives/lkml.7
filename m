Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706FE2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894771;
	bh=YD/1NVVgUaBFfozagHbjIl+lQDc9k52Y2E+VTO1p7mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gf0DcS2xsDsgRbkQ/CNCifbPzFvIVodSdhmUNqYL79eN5P0+qOMv3r3CwCroFP6hl
	 WFLHfwtKc/MMGn49e6XlRP91ShaKBA1DaIqoVjQZUOUsZH2sqN8cDlj6C2+zIKG7Nn
	 xxeu1btFWZFcxHDE3AhdJz2A6LtSpUky+8+Z0PzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfDJLMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:12:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbfDJLMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sUBoYDDP2teggn5gBXVmINUIrUA2jEav/rR5Ebr7KCQ=; b=KAyfWPkF4Ad2ZPedkpaFTXC0Mm
        H9jD6WFcY7D/Y0h60JLKVhTqt8nBZ9Kh54SqMekYp+26bQk9wOMIdCTzRPqIra0L8JJ24+miYHRUn
        s3q/H4cHxP1N61LODT9bq/xZ40AY25glmMJt9lDsJNRJ0/3njAoLCfQqGbNbvm07SuEvYthksZzls
        KYCzH9ueFhnug0EcFFyjCLLHpJ2vgxdfzKSgMmtjgoeCI9kPRsZ+jEJYUaZoALYnoF8cMpCAW9WqY
        iayVgPQyIAIiPS3pfi3MwONN9asX+RchBsYYBvdXEEBc8YKavbLQG3r5WY0RDr3CYMnHYQx5E/AzI
        LpPCp+0Q==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEB9L-0006ms-Ix; Wed, 10 Apr 2019 11:12:15 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEB9J-0007SV-9L; Wed, 10 Apr 2019 08:12:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 03/21] docs: hwmon: menf21bmc: convert to ReST format
Date:   Wed, 10 Apr 2019 08:11:53 -0300
Message-Id: <5e2209814ab1b0a9d7ee1942ddff906f7261f393.1554893882.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554893881.git.mchehab+samsung@kernel.org>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert menf21bmc to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/menf21bmc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/hwmon/menf21bmc b/Documentation/hwmon/menf21bmc
index 2a273a065c5e..1f0c6b2235ab 100644
--- a/Documentation/hwmon/menf21bmc
+++ b/Documentation/hwmon/menf21bmc
@@ -2,8 +2,11 @@ Kernel driver menf21bmc_hwmon
 =============================
 
 Supported chips:
+
 	* MEN 14F021P00
+
 	  Prefix: 'menf21bmc_hwmon'
+
 	  Adresses scanned: -
 
 Author: Andreas Werner <andreas.werner@men.de>
@@ -34,6 +37,7 @@ Sysfs entries
 The following attributes are supported. All attributes are read only
 The Limits are read once by the driver.
 
+=============== ==========================
 in0_input	+3.3V input voltage
 in1_input	+5.0V input voltage
 in2_input	+12.0V input voltage
@@ -48,3 +52,4 @@ in1_label	"MON_5V"
 in2_label	"MON_12V"
 in3_label	"5V_STANDBY"
 in4_label	"VBAT"
+=============== ==========================
-- 
2.20.1

