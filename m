Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F8AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 09:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF8120675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 09:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfECJva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 05:51:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbfECJv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 05:51:29 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8D7247791ACCC68459D6;
        Fri,  3 May 2019 17:51:27 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 3 May 2019 17:51:18 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH V2 net-next 0/3] net: hns3: enhance capabilities for fibre port
Date:   Fri, 3 May 2019 17:50:36 +0800
Message-ID: <1556877039-1692-1-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

This patchset enhances more capabilities for fibre port,
include multipe media type identification, autoneg,
change port speed and FEC encoding.

Jian Shen (3):
  net: hns3: add support for multiple media type
  net: hns3: add autoneg and change speed support for fibre port
  net: hns3: add support for FEC encoding control

Change log:
V1->V2: fixes comments from Andrew Lunn.

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  34 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 180 ++++++++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  30 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 410 ++++++++++++++++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  16 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |   7 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  15 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   1 +
 8 files changed, 620 insertions(+), 73 deletions(-)

-- 
1.9.1

