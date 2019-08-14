Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6C4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405FD2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 07:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfHNHRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 03:17:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfHNHRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 03:17:05 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4DDD918D36EF53D47457;
        Wed, 14 Aug 2019 15:17:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Wed, 14 Aug 2019 15:16:55 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Mao Wenan" <maowenan@huawei.com>
Subject: [PATCH v2 linux-next 0/2] change mux_configure32() to static
Date:   Wed, 14 Aug 2019 15:21:03 +0800
Message-ID: <20190814072105.144107-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch is to make mux_configure32() static to avoid sparse warning,
the second patch is to chage alignment of two functions.

v2: change subject from "drivers: dma: Fix sparse warning for mux_configure32"
to "drivers: dma: make mux_configure32 static", and cleanup the log. And add 
one patch to change alignment of two functions. 

Mao Wenan (2):
  drivers: dma: make mux_configure32 static
  drivers: dma: change alignment of mux_configure32 and
    fsl_edma_chan_mux

 drivers/dma/fsl-edma-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.20.1

