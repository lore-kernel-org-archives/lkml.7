Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B86C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4E42077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfCMVCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:02:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:62745 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726551AbfCMVCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:02:10 -0400
X-UUID: a55305be4d78409083b06c7e38580593-20190314
X-UUID: a55305be4d78409083b06c7e38580593-20190314
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 956810082; Thu, 14 Mar 2019 05:02:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Mar 2019 05:02:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Mar 2019 05:02:02 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 0/3] add module_sdio_driver and enable a few users
Date:   Thu, 14 Mar 2019 05:01:57 +0800
Message-ID: <cover.1552510141.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add module_sdio_driver exactly like the function module_usb_drivear offers to
and enable a few users to eliminate a few lines of boilerplate code per SDIO
driver.

Sean Wang (3):
  mmc: sdio: Add helper macro for sdio_driver boilerplate
  Bluetooth: mediatek: Use module_sdio_driver helper
  Bluetooth: btsdio: Use module_sdio_driver helper

 drivers/bluetooth/btmtksdio.c | 15 +--------------
 drivers/bluetooth/btsdio.c    | 15 +--------------
 include/linux/mmc/sdio_func.h | 12 ++++++++++++
 3 files changed, 14 insertions(+), 28 deletions(-)

-- 
2.18.0

