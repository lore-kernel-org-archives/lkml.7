Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69BFC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77807218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfDXCjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 22:39:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbfDXCjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 22:39:53 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C6D1D26988A878FF422D;
        Wed, 24 Apr 2019 10:39:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Wed, 24 Apr 2019 10:39:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] staging: kpc2000: remove duplicated include from kp2000_module.c
Date:   Wed, 24 Apr 2019 02:50:00 +0000
Message-ID: <20190424025000.93077-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/kpc2000/kpc2000/kp2000_module.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/kp2000_module.c b/drivers/staging/kpc2000/kpc2000/kp2000_module.c
index 661b0b74ed66..fa3bd266ba54 100644
--- a/drivers/staging/kpc2000/kpc2000/kp2000_module.c
+++ b/drivers/staging/kpc2000/kpc2000/kp2000_module.c
@@ -5,7 +5,6 @@
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/slab.h>
-#include <linux/pci.h>
 #include <asm/io.h>
 #include <linux/io.h>
 #include <linux/mfd/core.h>





