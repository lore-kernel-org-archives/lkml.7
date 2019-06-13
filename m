Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F986C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F272120851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbfFMPmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:42:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731845AbfFMJs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:48:27 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9A76D93F26544D6E4D33;
        Thu, 13 Jun 2019 17:48:22 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Jun 2019 17:48:14 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <luoshaokai@huawei.com>, <cloud.wangxiaoyun@huawei.com>,
        <xuechaojing@huawei.com>, <chiqijun@huawei.com>,
        <wulike1@huawei.com>
Subject: [PATCH net-next v3 0/2] hinic: add rss support and rss parameters configuration
Date:   Thu, 13 Jun 2019 01:58:00 +0000
Message-ID: <20190613015802.3916-1-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add rss support for HINIC driver and implement the ethtool
interface related to rss parameter configuration. user can use ethtool
configure rss parameters or show rss parameters.

Xue Chaojing (2):
  hinic: add rss support
  hinic: add support for rss parameters with ethtool

 drivers/net/ethernet/huawei/hinic/Makefile    |   2 +-
 drivers/net/ethernet/huawei/hinic/hinic_dev.h |  28 +
 .../net/ethernet/huawei/hinic/hinic_ethtool.c | 508 ++++++++++++++++++
 .../net/ethernet/huawei/hinic/hinic_hw_dev.c  |  10 +-
 .../net/ethernet/huawei/hinic/hinic_hw_dev.h  |  36 ++
 .../net/ethernet/huawei/hinic/hinic_hw_wqe.h  |  16 +
 .../net/ethernet/huawei/hinic/hinic_main.c    | 260 +++++----
 .../net/ethernet/huawei/hinic/hinic_port.c    | 389 ++++++++++++++
 .../net/ethernet/huawei/hinic/hinic_port.h    | 129 +++++
 9 files changed, 1236 insertions(+), 142 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c

-- 
2.17.1

