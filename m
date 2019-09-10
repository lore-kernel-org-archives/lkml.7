Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0397C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A918206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbfIJJBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:01:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725263AbfIJJBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:01:09 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 93ACF227333CCAA1672C;
        Tue, 10 Sep 2019 17:01:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 10 Sep 2019 17:00:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 0/7] net: hns3: add a feature & bugfixes & cleanups
Date:   Tue, 10 Sep 2019 16:58:21 +0800
Message-ID: <1568105908-60983-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set includes a VF feature, bugfixes and cleanups for the HNS3
ethernet controller driver.

[patch 01/07] adds ethtool_ops.set_channels support for HNS3 VF driver

[patch 02/07] adds a recovery for setting channel fail.

[patch 03/07] fixes an error related to shaper parameter algorithm.

[patch 04/07] fixes an error related to ksetting.

[patch 05/07] adds cleanups for some log pinting.

[patch 06/07] adds a NULL pointer check before function calling.

[patch 07/07] adds some debugging information for reset issue.

Guangbin Huang (4):
  net: hns3: add ethtool_ops.set_channels support for HNS3 VF driver
  net: hns3: fix port setting handle for fibre port
  net: hns3: modify some logs format
  net: hns3: check NULL pointer before use

Huazhong Tan (1):
  net: hns3: add some DFX info for reset issue

Peng Li (1):
  net: hns3: revert to old channel when setting new channel num fail

Yonglong Liu (1):
  net: hns3: fix shaper parameter algorithm

 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  7 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 54 ++++++++++----
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 16 ++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 32 +++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 13 ++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  | 11 +--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 87 ++++++++++++++++++++--
 9 files changed, 178 insertions(+), 46 deletions(-)

-- 
2.7.4

