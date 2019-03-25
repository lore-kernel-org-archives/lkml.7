Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7611C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADFF20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCYEPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:15:34 -0400
Received: from mx.socionext.com ([202.248.49.38]:53579 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfCYEPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:15:34 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Mar 2019 13:15:32 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 893C4180085;
        Mon, 25 Mar 2019 13:15:32 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 25 Mar 2019 13:15:32 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 2F6BA1A15B7;
        Mon, 25 Mar 2019 13:15:32 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 0E341120487;
        Mon, 25 Mar 2019 13:15:32 +0900 (JST)
From:   Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kanematsu.shinji@socionext.com, jaswinder.singh@linaro.org,
        masami.hiramatsu@linaro.org, linux-kernel@vger.kernel.org,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Subject: [PATCH 0/2] Add support for AXI DMA controller on Milbeaut series
Date:   Mon, 25 Mar 2019 13:15:12 +0900
Message-Id: <1553487314-9185-1-git-send-email-kasai.kazuhiro@socionext.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series adds AXI DMA controller support on Milbeaut series.
This controller has only capable of memory to memory transfer.

Kazuhiro Kasai (2):
  dt-bindings: dmaengine: Add Milbeaut AXI DMA controller bindings
  dmaengine: milbeaut: Add Milbeaut AXI DMA controller

 .../devicetree/bindings/dma/xdmac-milbeaut.txt     |  24 ++
 drivers/dma/Kconfig                                |   8 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/xdmac-milbeaut.c                       | 353 +++++++++++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xdmac-milbeaut.txt
 create mode 100644 drivers/dma/xdmac-milbeaut.c

--
1.9.1

