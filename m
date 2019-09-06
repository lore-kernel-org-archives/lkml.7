Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E0FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0687220838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393055AbfIFT0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:26:51 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:60420 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726931AbfIFT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:26:50 -0400
X-Greylist: delayed 2921 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Sep 2019 15:26:49 EDT
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6J7T-000Jjb-HO; Fri, 06 Sep 2019 20:38:03 +0200
Received: from 145-126.cable.senselan.ch ([83.222.145.126] helo=volery)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i6J7T-000Axi-Dk; Fri, 06 Sep 2019 20:38:03 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Date:   Fri, 6 Sep 2019 20:38:01 +0200
From:   volery <sandro@volery.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed parentheses malpractice in apex_driver.c
Message-ID: <20190906183801.GA2456@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were some parentheses at the end of lines, which I took care of.
This is my first patch.

Signed-off-by: Sandro Volery <sandro@volery.com>
---
 drivers/staging/gasket/apex_driver.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 464648ee2036..78ebd590f877 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -527,17 +527,20 @@ static ssize_t sysfs_show(struct device *device, struct device_attribute *attr,
 	switch (type) {
 	case ATTR_KERNEL_HIB_PAGE_TABLE_SIZE:
 		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
-				gasket_page_table_num_entries(
+				gasket_page_table_num_entries
+				(
 					gasket_dev->page_table[0]));
 		break;
 	case ATTR_KERNEL_HIB_SIMPLE_PAGE_TABLE_SIZE:
 		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
-				gasket_page_table_num_simple_entries(
+				gasket_page_table_num_simple_entries
+				(
 					gasket_dev->page_table[0]));
 		break;
 	case ATTR_KERNEL_HIB_NUM_ACTIVE_PAGES:
 		ret = scnprintf(buf, PAGE_SIZE, "%u\n",
-				gasket_page_table_num_active_pages(
+				gasket_page_table_num_active_pages
+				(
 					gasket_dev->page_table[0]));
 		break;
 	default:
-- 
2.23.0

