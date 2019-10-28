Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10DACA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9532086D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbfJ1MNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:13:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37090 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728512AbfJ1MNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:13:16 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1B0FC1EFA278FF25D08D;
        Mon, 28 Oct 2019 20:13:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 28 Oct 2019 20:13:04 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/5] hisi_lpc: Improve build test coverage
Date:   Mon, 28 Oct 2019 20:10:00 +0800
Message-ID: <1572264605-172363-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to improve the build test cover of the driver by
supporting building under COMPILE_TEST.

I also included "lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops
are set at registration" as it was never picked up for 5.4.

Two new patches are also included since v1:
- clean issues detected by sparse
- build logic_pio.o into /lib library

John Garry (5):
  lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
    registration
  logic_pio: Define PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO
  bus: hisi_lpc: Clean some types
  bus: hisi_lpc: Expand build test coverage
  logic_pio: Build into a library

 drivers/bus/Kconfig       |  4 ++--
 drivers/bus/hisi_lpc.c    |  9 ++++-----
 include/linux/logic_pio.h |  4 ++--
 lib/Makefile              |  2 +-
 lib/logic_pio.c           | 14 ++++++++------
 5 files changed, 17 insertions(+), 16 deletions(-)

-- 
2.17.1

