Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B7EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8DC20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554924236;
	bh=t3CcOt2HDuc1gQ9AGA3HEhB+D7deMg2dE500Ev/kWPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vIBgMYR7rrC8na7uNS6XxIdQurQz+m5Rvhw9pb6jzPvHxowDyVPwCWxqOAO2tgvqt
	 L72X8HIZhw9bY0GtE9AnOicNf0XjB5cq1Ndb1+b0oTGa8wdyY0RjduEGNU7Fx+IT4V
	 nS3yc6zGgyrx3ysW6rWE0b4JnSKmNdXot3BLGia8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDJTXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:23:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfDJTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9LalUJPmuPDaMfLRWCl1lzBZDSX3p4v9Ob+a/oKrM1M=; b=BpdDsONmXWWkvhXKYTO47uuoYQ
        XR873UQ5fCOItZKkS5WiMie6AiqMwWcZjKsvtFCT24Aq0ghKCxqY+usHVc5cqFz8lrTNnDUnfc2JA
        Tb6MtmyQq9gaOxXzDI6mBzZMLs97pjBuUWjq/LT31gvADNRrkkHL5mPtP11qtxDyRDm5gbTei+Hs2
        X3YU3cD6cJHe0tiLatt65NYZOXfMjkJq8DPbZNAjldLRycwqNlTCugHdA0iL44JjUPMVgu7VmEPgU
        bhurev4i+yLpbDql01ju25XrdLbe+BJd5/gxRFiqtwYjAgO2tSdy/zu2PMI3Q5LcGSKACdOT83vwe
        JJKD2EiA==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEIoM-0003R6-Hk; Wed, 10 Apr 2019 19:23:06 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEIoJ-0000zO-3g; Wed, 10 Apr 2019 16:23:03 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 15/21] docs: hwmon: wm831x, wm8350: convert to ReST format
Date:   Wed, 10 Apr 2019 16:22:52 -0300
Message-Id: <85bfe2f80c68d67cb910bbccde3ff663255fe019.1554923967.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert wm831x and wm8350 to ReST format, in order to allow
them to be parsed by Sphinx.

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

