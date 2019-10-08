Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F57ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D534020835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfJHBWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:22:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52928 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729327AbfJHBWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:22:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3F403A937A1876992D9A;
        Tue,  8 Oct 2019 09:22:51 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 8 Oct 2019 09:22:42 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 0/6] net: hns3: add some new feature
Date:   Tue, 8 Oct 2019 09:20:03 +0800
Message-ID: <1570497609-36349-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set includes some new features for the HNS3 ethernet
controller driver.

[patch 01/06] adds support for configuring VF link status on the host.

[patch 02/06] adds support for configuring VF spoof check.

[patch 03/06] adds support for configuring VF trust.

[patch 04/06] adds support for configuring VF bandwidth on the host.

[patch 05/06] adds support for configuring VF MAC on the host.

[patch 06/06] adds support for tx-scatter-gather-fraglist.

Huazhong Tan (1):
  net: hns3: add support for configuring VF MAC from the host

Jian Shen (2):
  net: hns3: add support for spoof check setting
  net: hns3: add support for setting VF trust

Yonglong Liu (1):
  net: hns3: add support for configuring bandwidth of VF on the host

Yufeng Mo (1):
  net: hns3: add support for setting VF link status on the host

Yunsheng Lin (1):
  net: hns3: support tx-scatter-gather-fraglist feature

 drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h    |   1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  23 ++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 355 ++++++++++++-----
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  12 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   5 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  79 ++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 434 ++++++++++++++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  17 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  85 +++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  43 ++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   8 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  64 +--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   1 +
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  12 +
 14 files changed, 986 insertions(+), 153 deletions(-)

-- 
2.7.4

