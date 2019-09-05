Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE09C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18D92070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfIENeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:34:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727809AbfIENeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:34:11 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B893CF2FDD83EBBE30A6;
        Thu,  5 Sep 2019 21:34:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Sep 2019 21:34:02 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 0/7] net: hns3: add some bugfixes and cleanups
Date:   Thu, 5 Sep 2019 21:31:35 +0800
Message-ID: <1567690302-16648-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set includes bugfixes and cleanups for the HNS3
ethernet controller driver.

[patch 01/07] fixes an error when setting VLAN offload.

[patch 02/07] fixes an double free issue when setting ringparam.

[patch 03/07] fixes a mis-assignment of hdev->reset_level.

[patch 04/07] adds a checking for client's validity.

[patch 05/07] simplifies bool variable's assignment.

[patch 06/07] disables loopback when initializing.

[patch 07/07] makes internal function to static.

Change log:
V1->V2: fixes comment from Sergei Shtylyov.

Guojia Liao (2):
  net: hns3: remove explicit conversion to bool
  net: hns3: make hclge_dbg_get_m7_stats_info static

Huazhong Tan (2):
  net: hns3: fix double free bug when setting ringparam
  net: hns3: fix mis-assignment to hdev->reset_level in hclge_reset

Jian Shen (1):
  net: hns3: fix error VF index when setting VLAN offload

Peng Li (1):
  net: hns3: add client node validity judgment

Yufeng Mo (1):
  net: hns3: disable loopback setting in hclge_mac_init

 drivers/net/ethernet/hisilicon/hns3/hnae3.c        | 16 ++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 59 ++++++++++++++++++----
 4 files changed, 69 insertions(+), 12 deletions(-)

-- 
2.7.4

