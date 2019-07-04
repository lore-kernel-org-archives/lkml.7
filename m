Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C74C46486
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AE52085A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfGDOGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:06:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbfGDOGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:06:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D3FF16D6AA4EF09BC1FA;
        Thu,  4 Jul 2019 22:06:21 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Thu, 4 Jul 2019 22:06:15 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 0/9] net: hns3: some cleanups & bugfixes
Date:   Thu, 4 Jul 2019 22:04:19 +0800
Message-ID: <1562249068-40176-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set includes cleanups and bugfixes for
the HNS3 ethernet controller driver.

[patch 1/9] fixes VF's broadcast promisc mode not enabled after
initializing.

[patch 2/9] adds hints for fibre port not support flow control.

[patch 3/9] fixes a port capbility updating issue.

[patch 4/9 - 9/9] adds some cleanups for HNS3 driver.

Jian Shen (3):
  net: hns3: enable broadcast promisc mode when initializing VF
  net: hns3: fix flow control configure issue for fibre port
  net: hns3: fix port capbility updating issue

Peng Li (4):
  net: hns3: add all IMP return code
  net: hns3: set default value for param "type" in
    hclgevf_bind_ring_to_vector
  net: hns3: add default value for tc_size and tc_offset
  net: hns3: set maximum length to resp_data_len for exceptional case

Weihang Li (1):
  net: hns3: check msg_data before memcpy in hclgevf_send_mbx_msg

Yonglong Liu (1):
  net: hns3: bitwise operator should use unsigned type

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  9 +--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 43 ++++++++++---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  8 +++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 74 ++++++++++++----------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  4 ++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   | 38 +++++++++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.h   | 14 +++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 19 ++++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c   |  3 +-
 10 files changed, 149 insertions(+), 65 deletions(-)

-- 
2.7.4

