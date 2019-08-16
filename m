Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0C7C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A062171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfHPIMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:12:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50786 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfHPIMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:12:07 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 69CAC77673F27F850E45;
        Fri, 16 Aug 2019 16:11:58 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 16 Aug 2019 16:11:48 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 0/6] net: hns3: add some cleanups & bugfix
Date:   Fri, 16 Aug 2019 16:09:36 +0800
Message-ID: <1565942982-12105-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set includes cleanups and bugfix for the HNS3 ethernet
controller driver.

[patch 01/06 - 03/06] adds some cleanups.

[patch 04/06] changes the print level of RAS.

[patch 05/06] fixes a bug related to MAC TNL.

[patch 06/06] adds phy_attached_info().

Guojia Liao (3):
  net: hns3: add or modify comments
  net: hns3: modify redundant initialization of variable
  net: hns3: fix error and incorrect format

Huazhong Tan (1):
  net: hns3: prevent unnecessary MAC TNL interrupt

Xiaofei Tan (1):
  net: hns3: change print level of RAS error log from warning to error

Yonglong Liu (1):
  net: hns3: add phy_attached_info() to the hns3 driver

 drivers/net/ethernet/hisilicon/hns3/hnae3.c        |  9 +--
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        | 12 +--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  8 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  8 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  6 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |  3 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 90 +++++++++++-----------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 17 ++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  1 -
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |  2 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |  2 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 11 ++-
 14 files changed, 89 insertions(+), 84 deletions(-)

-- 
2.7.4

