Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEF6C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B302173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDFHoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:44:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfDFHoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 03:44:44 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4401D973928775B4F074;
        Sat,  6 Apr 2019 15:44:41 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Sat, 6 Apr 2019 15:44:34 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 00/12] code optimizations & bugfixes for HNS3 driver
Date:   Sat, 6 Apr 2019 15:43:24 +0800
Message-ID: <1554536616-24977-1-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes bugfixes and code optimizations for
the HNS3 ethernet controller driver.

Huazhong Tan (12):
  net: hns3: set vport alive state to default while resetting
  net: hns3: set up the vport alive state while reinitializing
  net: hns3: not reset vport who not alive when PF reset
  net: hns3: adjust the timing of hns3_client_stop when unloading
  net: hns3: deactive the reset timer when reset successfully
  net: hns3: ignore lower-level new coming reset
  net: hns3: do not request reset when hardware resetting
  net: hns3: handle pending reset while reset fail
  net: hns3: stop mailbox handling when command queue need re-init
  net: hns3: add error handler for initializing command queue
  net: hns3: remove resetting check in hclgevf_reset_task_schedule
  net: hns3: fix keep_alive_timer not stop problem

 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 12 ++++++++++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c | 11 ++++++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 22 +++++++++++++++++++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   | 11 ++++++++---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 17 ++++++++++++++---
 5 files changed, 59 insertions(+), 14 deletions(-)

-- 
2.7.4

