Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9119DC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6C121848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfJIO7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:59:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729471AbfJIO7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:59:14 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 57B842A8682FA63FD9AB;
        Wed,  9 Oct 2019 22:59:11 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Wed, 9 Oct 2019 22:59:03 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mchehab@kernel.org>, <sean@mess.org>, <hansverk@cisco.com>,
        <daniel.vetter@ffwll.ch>
CC:     <linux-media@vger.kernel.org>, <zhongjiang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] media: Use DIV_ROUND_CLOSEST directly 
Date:   Wed, 9 Oct 2019 22:55:21 +0800
Message-ID: <1570632925-14926-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the help of Coccinelle. I find some place that DIV_ROUND_CLOSEST
can replace it directly.

v1->v2:
   patch 1: remove mt312_div() to use the DIV_ROUND_CLOSEST directly.

zhong jiang (4):
  media: dvb-frontends: Use DIV_ROUND_CLOSEST directly to make it
    readable
  media: tuners/qm1d1c0042: Use DIV_ROUND_CLOSEST directly to make it
    readable
  media: uvcvideo: Use DIV_ROUND_CLOSEST directly to make it readable
  media: v4l2-dv-timings: Use DIV_ROUND_CLOSEST directly to make it
    readable

 drivers/media/dvb-frontends/mt312.c       | 14 +++++---------
 drivers/media/tuners/qm1d1c0042.c         |  2 +-
 drivers/media/usb/uvc/uvc_ctrl.c          |  4 ++--
 drivers/media/v4l2-core/v4l2-dv-timings.c |  2 +-
 4 files changed, 9 insertions(+), 13 deletions(-)

-- 
1.7.12.4

