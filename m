Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4FBC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19F520870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbfIEQTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:19:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733030AbfIEQSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:18:07 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BFCCC1B9BB529B7BE769;
        Fri,  6 Sep 2019 00:18:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Sep 2019 00:18:36 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mchehab@kernel.org>
CC:     <hansverk@cisco.com>, <daniel.vetter@ffwll.ch>,
        <zhongjiang@huawei.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] media: Use DIV_ROUND_CLOSEST directly
Date:   Fri, 6 Sep 2019 00:14:48 +0800
Message-ID: <1567700092-27769-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the following help of Coccinelle. I find out some place can be replaced.

-(((x) + ((__divisor) / 2)) / (__divisor))
+ DIV_ROUND_CLOSEST(x,__divisor)

zhong jiang (4):
  media: dvb-frontends: Use DIV_ROUND_CLOSEST directly to make it
    readable
  media: tuners/qm1d1c0042: Use DIV_ROUND_CLOSEST directly to make it
    readable
  media: uvcvideo: Use DIV_ROUND_CLOSEST directly to make it readable
  media: v4l2-dv-timings: Use DIV_ROUND_CLOSEST directly to make it
    readable

 drivers/media/dvb-frontends/mt312.c       | 2 +-
 drivers/media/tuners/qm1d1c0042.c         | 2 +-
 drivers/media/usb/uvc/uvc_ctrl.c          | 4 ++--
 drivers/media/v4l2-core/v4l2-dv-timings.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.12.4

