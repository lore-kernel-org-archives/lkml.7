Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A00AC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7232D22314
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfLSBqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:46:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfLSBqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:46:06 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B14AAB727CA01EDE59BB;
        Thu, 19 Dec 2019 09:46:03 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Dec 2019 09:45:55 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ma Feng <mafeng.ma@huawei.com>
Subject: [PATCH 2/3] power: supply: ab8500_charger: Remove unneeded semicolon
Date:   Thu, 19 Dec 2019 09:46:30 +0800
Message-ID: <1576719991-109247-2-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1576719991-109247-1-git-send-email-mafeng.ma@huawei.com>
References: <1576719991-109247-1-git-send-email-mafeng.ma@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/power/supply/ab8500_charger.c:1082:2-3: Unneeded semicolon
drivers/power/supply/ab8500_charger.c:792:2-3: Unneeded semicolon
drivers/power/supply/ab8500_charger.c:2430:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/power/supply/ab8500_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 8a0f9d7..f69550d 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -789,7 +789,7 @@ static int ab8500_charger_max_usb_curr(struct ab8500_charger *di,
 		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P05;
 		ret = -ENXIO;
 		break;
-	};
+	}
 
 	di->max_usb_in_curr.set_max = di->max_usb_in_curr.usb_type_max;
 	dev_dbg(di->dev, "USB Type - 0x%02x MaxCurr: %d",
@@ -1079,7 +1079,7 @@ static int ab8500_charger_get_usb_cur(struct ab8500_charger *di)
 		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P05;
 		ret = -EPERM;
 		break;
-	};
+	}
 	di->max_usb_in_curr.set_max = di->max_usb_in_curr.usb_type_max;
 	return ret;
 }
@@ -2427,7 +2427,7 @@ static void ab8500_charger_usb_state_changed_work(struct work_struct *work)
 
 	default:
 		break;
-	};
+	}
 }
 
 /**
-- 
2.6.2

