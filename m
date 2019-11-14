Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED434C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DB9206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 02:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKNCcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 21:32:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6657 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbfKNCcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 21:32:21 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B3A827862A61D44B8ED7;
        Thu, 14 Nov 2019 10:32:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Thu, 14 Nov 2019 10:32:10 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net 0/3] net: hns3: fixes for -net
Date:   Thu, 14 Nov 2019 10:32:38 +0800
Message-ID: <1573698761-25682-1-git-send-email-tanhuazhong@huawei.com>
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

[patch 1/3] adds a compatible handling for configuration of
MAC VLAN swithch parameter.

[patch 2/3] re-allocates SSU buffer when pfc_en changed.

[patch 3/3] fixes a bug for ETS bandwidth validation.

Guangbin Huang (1):
  net: hns3: add compatible handling for MAC VLAN switch parameter
    configuration

Yonglong Liu (1):
  net: hns3: fix ETS bandwidth validation bug

Yunsheng Lin (1):
  net: hns3: reallocate SSU' buffer size when pfc_en changes

 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c    | 19 +++++++++++++++++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 16 ++++++++++++++--
 2 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.7.4

