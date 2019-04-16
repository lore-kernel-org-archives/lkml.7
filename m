Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E28C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921AC20651
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfDPJ2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:28:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25215 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728949AbfDPJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:28:03 -0400
X-UUID: 4652a8162aea4cb6ac0c9f4fe939afe2-20190416
X-UUID: 4652a8162aea4cb6ac0c9f4fe939afe2-20190416
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 613959203; Tue, 16 Apr 2019 17:27:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 17:27:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 17:27:46 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, CK Hu <ck.hu@mediatek.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v2 00/15] Add mediatek mipicsi driver for Mediatek SOC MT2712
Date:   Tue, 16 Apr 2019 17:27:28 +0800
Message-ID: <1555406863-18069-1-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 805393A14045F2617856A5F8F8516F8511D55088F052C0F85FFAA0CFA9C41AE22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mediatek mipicsi driver for Mediatek SOC MT2712

Change in v2:
- Add the dt-binding document for mediatek mipicsi driver
- Modify the logic about "is_support" function in patch
  "[media] mtk-mipicsi: add color format support for mt2712"

Stu Hsieh (15):
  dt-bindings: media: Add binding for MT2712 MIPI-CSI2
  [media] mtk-mipicsi: add mediatek mipicsi driver for mt2712
  [media] mtk-mipicsi: add pm function
  [media] mtk-mipicsi: add color format support for mt2712
  [media] mtk-mipicsi: get the w/h/bytepwerline for mtk_mipicsi
  [media] mtk-mipicsi: add function to support SerDes for link number
  [media] mtk-mipicsi: add mipicsi reg setting for mt2712
  [media] mtk-mipicsi: enable/disable ana clk
  [media] mtk-mipicsi: enable/disable cmos for mt2712
  [media] mtk-mipicsi: add ISR for writing the data to buffer
  [media] mtk-mipicsi: set the output address in HW reg
  [media] mtk-mipicsi: add function to get the format
  [media] mtk-mipicsi: add the function for Get/Set PARM for application
  [media] mtk-mipicsi: add debug message for mipicsi driver
  [media] mtk-mipicsi: add debugfs for mipicsi driver

 .../bindings/media/mediatek-mipicsi-camsv.txt |   53 +
 .../media/mediatek-mipicsi-common.txt         |   19 +
 .../bindings/media/mediatek-mipicsi.txt       |   54 +
 drivers/media/platform/mtk-mipicsi/Makefile   |    4 +
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 1686 +++++++++++++++++
 5 files changed, 1816 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-mipicsi-camsv.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-mipicsi-common.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-mipicsi.txt
 create mode 100644 drivers/media/platform/mtk-mipicsi/Makefile
 create mode 100644 drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c

-- 
2.18.0

