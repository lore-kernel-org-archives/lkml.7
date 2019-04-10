Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BD6C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6578920850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894831;
	bh=6CHV2EONZTKOkSiNQB5G3Ok79D/ozsHqfCe+Y5+/IJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O7YnxmEWRhXGWa65QWjMRiuhQWfzfr40AC/xST4f0+D0Tdd7VJWc30O6HqXrr8XNB
	 j8cHswK9oS7L4R7m8Y29tNFJ9U9Qf0HUgZwU+ExmuYzL94kmIVNLWJlVH+7YnAoxsx
	 KSd1AZzv8KKD2VxnJSvzGjT3kbEybRxJGG0L8H6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbfDJLNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:13:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbfDJLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ROysOLrwt+sLIGiYX0wIeU68Huw/fU4cdQEL79qgER4=; b=u3SQtrfThG07SkHAtxJKmAChTl
        V/3u0pvEW2KmSkSYiJM2zHUOHlgp7JeyZ2/4QFen3I6sxN3tQJKGk3eRDX1RZA/4crLWs0ptf5DG+
        UrU7Nf5gAn/AQyJprikmZ0DGn8z4+LIgDUnUhea3S4ZwCzbZB5bjEXEShBZBD6Xs1PoXTqf94kzPg
        d4TPJR0/igYAvpop7vS9aGZFbP82nasWqgEEoQOaRixs1MTasiYPzm4m3bWDqT04Ratmfm3DafTAS
        vxr8eH7hket9VsAm+N738U6OW8jTR+n9EA2fNSSXAp78BsOjIqRPxqudx83/bxd1RHgfNjT9C9s9X
        dwD8bmfg==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEB9L-0006mz-LD; Wed, 10 Apr 2019 11:12:15 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEB9J-0007SR-8X; Wed, 10 Apr 2019 08:12:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/21] docs: hwmon: vexpress: convert to ReST format
Date:   Wed, 10 Apr 2019 08:11:52 -0300
Message-Id: <286af05e51900e6559342e94b2ee9273a0036dac.1554893882.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554893881.git.mchehab+samsung@kernel.org>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert vexpress to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/vexpress | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/vexpress b/Documentation/hwmon/vexpress
index 557d6d5ad90d..8c861c8151ac 100644
--- a/Documentation/hwmon/vexpress
+++ b/Documentation/hwmon/vexpress
@@ -2,14 +2,21 @@ Kernel driver vexpress
 ======================
 
 Supported systems:
+
   * ARM Ltd. Versatile Express platform
+
     Prefix: 'vexpress'
+
     Datasheets:
+
       * "Hardware Description" sections of the Technical Reference Manuals
-        for the Versatile Express boards:
-        http://infocenter.arm.com/help/topic/com.arm.doc.subset.boards.express/index.html
+	for the Versatile Express boards:
+
+	- http://infocenter.arm.com/help/topic/com.arm.doc.subset.boards.express/index.html
+
       * Section "4.4.14. System Configuration registers" of the V2M-P1 TRM:
-        http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0447-/index.html
+
+	- http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0447-/index.html
 
 Author: Pawel Moll
 
-- 
2.20.1

