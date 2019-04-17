Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F01C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565E321773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555494511;
	bh=mZhZggp0e3gSl7AatC3UqzpYQRau2SIgBCPfWDGg3As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ksls5bZ5ABUZIc+UJb2BGUpL4hI7ZkILVQ/ox1M70/+KYzvBrF5LKkBmsjZcJ4k4I
	 kFCw3Z4mL6CKu8tbaj5TZx6VWM2usvyuaMwGoShdOZ9ujvowL+Xxii0ynpM2VWtUpp
	 nOHGhP0SczFi6S5YXl1ODQOpe7lU2CTuw/eLsgHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbfDQJsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:48:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731683AbfDQJqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=usEtvPDaSFf99phOElHFCTpsFSNcxENwWCf3il6USvw=; b=Yhizq8TjeMfZLpXY7t8h8kMnBu
        8BlPo9RpRElzDuAnebIPnK0Ho0/zpXfOJ9EVywxAJ2YwhKBb8GxO6PVdmxsTv/78vDPo56gJgn1WA
        dJai3e1j+Ste9c9TtI6ZWi3dOS8tEde9cKziX3G29I087DWk1a3danYV/RXEEqM8mAK0IEdspw8Bp
        x4QXgtNhe2k9A/9vdGVAnt+PGGXr7GWhnYm9z6OPHuU5Zq5A0TQsXmpY5iUBnnMCvDU2wzIcpJnCl
        U1RTBOxk2VUzsF/jNPy/lAesFVExGocqa74DfXk78lgilAp/I7TfRw/z0DA30Q5g4WHDjOPbeZM2s
        B5jWEzqQ==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGh9G-0000aA-JZ; Wed, 17 Apr 2019 09:46:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGh9C-0003uC-QN; Wed, 17 Apr 2019 06:46:30 -0300
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
Subject: [PATCH v3 02/21] docs: hwmon: vexpress: convert to ReST format
Date:   Wed, 17 Apr 2019 06:46:10 -0300
Message-Id: <7f3e72d30c341b48d344110925a4f5fb3c92fe3c.1555494108.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555494108.git.mchehab+samsung@kernel.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert vexpress to ReST format, in order to allow it to
be parsed by Sphinx.

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

