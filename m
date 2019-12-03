Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CF4C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B912070B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLCDJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:09:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726142AbfLCDIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:08:46 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 76D60534AC1FFA763A07;
        Tue,  3 Dec 2019 11:08:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Dec 2019 11:08:34 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net 0/3] net: hns3: fixes for -net
Date:   Tue, 3 Dec 2019 11:08:52 +0800
Message-ID: <1575342535-2981-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes misc fixes for the HNS3 ethernet driver.

[patch 1/3] fixes a TX queue not restarted problem.

[patch 2/3] fixes a use-after-free issue.

[patch 3/3] fixes a VF ID issue for setting VF VLAN.


Jian Shen (1):
  net: hns3: fix VF ID issue for setting VF VLAN

Yunsheng Lin (2):
  net: hns3: fix for TX queue not restarted problem
  net: hns3: fix a use after free problem in hns3_nic_maybe_stop_tx()

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 53 ++++++++++++----------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 18 +++-----
 2 files changed, 34 insertions(+), 37 deletions(-)

-- 
2.7.4

