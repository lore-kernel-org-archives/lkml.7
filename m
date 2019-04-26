Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2A6C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461552084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDZJnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:43:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbfDZJnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:43:08 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9CF1AC8CBCC1518CBFA7;
        Fri, 26 Apr 2019 17:43:05 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 26 Apr 2019 17:42:58 +0800
From:   Jian Shen <shenjian15@huawei.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH topic-hns-5.1 0/3] {topost} net: hns3: add support for mac autoneg and FEC enconding control
Date:   Fri, 26 Apr 2019 17:42:40 +0800
Message-ID: <1556271763-24142-1-git-send-email-shenjian15@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduce multiple media type, autoneg, FEC encoding control
for fibre port.

Jian Shen (3):
  {topost} net: hns3: add support for multiple media type
  {topost} net: hns3: add autoneg and change speed support for fibre
    port
  {topost} net: hns3: add support for FEC encoding control

 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  37 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 101 ++++++++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  30 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 233 +++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  11 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |   7 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  14 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   1 +
 8 files changed, 364 insertions(+), 70 deletions(-)

-- 
1.9.1

