Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C666C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 06:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686E12465B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 06:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfLNGio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 01:38:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7241 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbfLNGio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 01:38:44 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 13477E9D23A12DEFDBE2;
        Sat, 14 Dec 2019 14:38:41 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Sat, 14 Dec 2019 14:38:31 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ma Feng <mafeng.ma@huawei.com>
Subject: [PATCH] usb: gadget: Remove unneeded semicolon
Date:   Sat, 14 Dec 2019 14:39:29 +0800
Message-ID: <1576305569-106590-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/usb/gadget/function/f_fs.c:2508:2-3: Unneeded semicolon
drivers/usb/gadget/udc/omap_udc.c:2579:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 drivers/usb/gadget/udc/omap_udc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 0bbccac..92f4645 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2505,7 +2505,7 @@ static int __ffs_data_got_descs(struct ffs_data *ffs,
 		os_descs_count = get_unaligned_le32(data);
 		data += 4;
 		len -= 4;
-	};
+	}

 	/* Read descriptors */
 	raw_descs = data;
diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index f36f073..6bb65f3 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2576,7 +2576,7 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 	case USB_ENDPOINT_XFER_INT:
 		ep->ep.caps.type_int = true;
 		break;
-	};
+	}

 	if (addr & USB_DIR_IN)
 		ep->ep.caps.dir_in = true;
--
2.6.2

