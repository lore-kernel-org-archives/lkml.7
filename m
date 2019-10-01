Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B132ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7745421872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfJAQHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:07:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfJAQHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:07:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 63D0EA5A589137093EB3;
        Wed,  2 Oct 2019 00:07:45 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Wed, 2 Oct 2019 00:07:14 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <bhelgaas@google.com>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] hisi_lpc: Improve build test coverage
Date:   Wed, 2 Oct 2019 00:04:24 +0800
Message-ID: <1569945867-82243-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to improve the build test cover of the driver by
supporting building under COMPILE_TEST.

I also included "lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops
are set at registration" as it was never picked up for 5.4.

John Garry (3):
  lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
    registration
  logic_pio: Define PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO
  bus: hisi_lpc: Expand build test coverage

 drivers/bus/Kconfig       |  4 ++--
 include/linux/logic_pio.h |  4 ++--
 lib/logic_pio.c           | 14 ++++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.17.1

