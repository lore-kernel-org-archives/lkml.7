Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393F6C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1276F2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbfILCze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:55:34 -0400
Received: from smtprelay0112.hostedemail.com ([216.40.44.112]:49346 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729606AbfILCz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:55:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2630D8024DF6;
        Thu, 12 Sep 2019 02:55:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crown88_87045049b360a
X-Filterd-Recvd-Size: 1614
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 02:55:27 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] nvdimm: namespace_devs: Change progess typo to progress
Date:   Wed, 11 Sep 2019 19:54:42 -0700
Message-Id: <1ae8fe1a3644c23afd01db23a373dd5de897c99f.1568256708.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1568256705.git.joe@perches.com>
References: <cover.1568256705.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typing is hard.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/nvdimm/namespace_devs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 7a16340f9853..253f07d97b73 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1718,7 +1718,7 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 			return ERR_PTR(-ENODEV);
 
 		/*
-		 * Flush any in-progess probes / removals in the driver
+		 * Flush any in-progress probes / removals in the driver
 		 * for the raw personality of this namespace.
 		 */
 		nd_device_lock(&ndns->dev);
-- 
2.15.0

