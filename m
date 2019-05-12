Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27117C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E915B21019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfELHPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 03:15:31 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42528 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfELHPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 03:15:31 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A420E1A8D9F99BE6D38F;
        Sun, 12 May 2019 15:15:28 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sun, 12 May 2019
 15:15:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <Matt.Sickler@daktronics.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] staging: kpc2000: remove unused function kp2000_cdev_write
Date:   Sun, 12 May 2019 14:46:15 +0800
Message-ID: <20190512064615.7364-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no callers in tree, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/kpc2000/kpc2000/fileops.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/fileops.c b/drivers/staging/kpc2000/kpc2000/fileops.c
index b3b0b763fa1e..f8774d8f69b8 100644
--- a/drivers/staging/kpc2000/kpc2000/fileops.c
+++ b/drivers/staging/kpc2000/kpc2000/fileops.c
@@ -74,11 +74,6 @@ ssize_t  kp2000_cdev_read(struct file *filp, char __user *buf, size_t count, lof
 	return count;
 }
 
-ssize_t  kp2000_cdev_write(struct file *filp, const char __user *buf, size_t count, loff_t *f_pos)
-{
-	return -EINVAL;
-}
-
 long  kp2000_cdev_ioctl(struct file *filp, unsigned int ioctl_num, unsigned long ioctl_param)
 {
 	struct kp2000_device *pcard = filp->private_data;
@@ -122,9 +117,6 @@ struct file_operations  kp2000_fops = {
 	.open       = kp2000_cdev_open,
 	.release    = kp2000_cdev_close,
 	.read       = kp2000_cdev_read,
-	//.write      = kp2000_cdev_write,
-	//.poll       = kp2000_cdev_poll,
-	//.fasync     = kp2000_cdev_fasync,
 	.llseek     = noop_llseek,
 	.unlocked_ioctl = kp2000_cdev_ioctl,
 };
-- 
2.20.1


