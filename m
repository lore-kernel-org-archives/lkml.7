Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EECAC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF75222CB
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894739;
	bh=O6ihXt7krjGAcrBTGdLBDcGT622bmbwXecQKMFCBs4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KoI1Sd+9nC/ESD0onwOIus5UtzrtUQCXE5DXZWjHrRrdITYXpkD1NAjSMjtsXcf2A
	 5CeNrbWg7bNJ6SPAUjnkPTRVXqtV0hUXYIueVUOgCg3kaoeDcPVHpPbYoZMxKyogUc
	 EDqggXWZIrLFCAPe/9JbEzVmNzxGR2L+ogHhUa4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbfDJLMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:12:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731101AbfDJLMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zdKJtS3Ll2T9dsl9yyaKaaeSYUGzNZu2Go4f4VJpk5U=; b=fGi4G95ImohcBHjc/Rfr4j9zAh
        eqb0PBoN4jxf6A5xoKhUrCIs8Lz3mWGR37XV85/MqobiUNUUlhA/XDnCLY1lPDnLWNVI8hhRBRmlA
        T5IBU9HeWI9mgDy40XwS28Do2LGZ65mM3d6M6yFZ4T1BwmymmsSJ+Y1QohQIil8c5xnl2pLvT4B2c
        mFEOc11tm6pbkiJv4rRlJwq1xcuePshzLuG8xufpMhxAYK3IF8V2Rm3RrdwVlGBtd5Cjvf3PWseFI
        RWm7PE8vx02RqV8/fA38uFfFutssJMi2/hnDHQq22EGklw7RBHkEtAe4LwD2cH5y6uTnuGf1fTDiT
        859gdHXg==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEB9L-0006n7-O5; Wed, 10 Apr 2019 11:12:15 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEB9J-0007TR-JL; Wed, 10 Apr 2019 08:12:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 15/21] docs: hwmon: wm831x, wm8350: convert to ReST format
Date:   Wed, 10 Apr 2019 08:12:05 -0300
Message-Id: <5d7dbd7dea4c35ba95d4cffbdc4a7614f6d12500.1554893882.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554893881.git.mchehab+samsung@kernel.org>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert wm831x and wm8350 to ReST format, in order to allow
them to be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/wm831x |  9 ++++++---
 Documentation/hwmon/wm8350 | 10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/wm831x b/Documentation/hwmon/wm831x
index 11446757c8c8..c56fb35a2fb3 100644
--- a/Documentation/hwmon/wm831x
+++ b/Documentation/hwmon/wm831x
@@ -3,11 +3,14 @@ Kernel driver wm831x-hwmon
 
 Supported chips:
   * Wolfson Microelectronics WM831x PMICs
+
     Prefix: 'wm831x'
+
     Datasheet:
-	http://www.wolfsonmicro.com/products/WM8310
-	http://www.wolfsonmicro.com/products/WM8311
-	http://www.wolfsonmicro.com/products/WM8312
+
+	- http://www.wolfsonmicro.com/products/WM8310
+	- http://www.wolfsonmicro.com/products/WM8311
+	- http://www.wolfsonmicro.com/products/WM8312
 
 Authors: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
diff --git a/Documentation/hwmon/wm8350 b/Documentation/hwmon/wm8350
index 98f923bd2e92..cec044ca5900 100644
--- a/Documentation/hwmon/wm8350
+++ b/Documentation/hwmon/wm8350
@@ -2,12 +2,16 @@ Kernel driver wm8350-hwmon
 ==========================
 
 Supported chips:
+
   * Wolfson Microelectronics WM835x PMICs
+
     Prefix: 'wm8350'
+
     Datasheet:
-	http://www.wolfsonmicro.com/products/WM8350
-	http://www.wolfsonmicro.com/products/WM8351
-	http://www.wolfsonmicro.com/products/WM8352
+
+	- http://www.wolfsonmicro.com/products/WM8350
+	- http://www.wolfsonmicro.com/products/WM8351
+	- http://www.wolfsonmicro.com/products/WM8352
 
 Authors: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
-- 
2.20.1

