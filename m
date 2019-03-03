Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA65C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 01:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9076B20449
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 01:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfCCBx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 20:53:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:2798 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726035AbfCCBx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 20:53:56 -0500
X-UUID: dfb258d18ccf4ec9b139f3e4e27d388d-20190303
X-UUID: dfb258d18ccf4ec9b139f3e4e27d388d-20190303
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2011129788; Sun, 03 Mar 2019 09:53:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 3 Mar 2019 09:53:45 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 3 Mar 2019 09:53:44 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <sean.wang@kernel.org>
CC:     <srv_heupstream@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <liguo.zhang@mediatek.com>, <eddie.huang@mediatek.com>,
        <hongkun.cao@mediatek.com>, <biao.huang@mediatek.com>,
        <hongzhou.yang@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <erin.lo@mediatek.com>, <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v2 0/1] PINCTRL: Mediatek pinctrl patch for mt8183 
Date:   Sun, 3 Mar 2019 09:53:40 +0800
Message-ID: <20190303015341.986-1-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 814B130D7E58A2800A4431E5255DAA75C3D5DF863EF39239C1A015F8C8E9978F2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes one patche:
1.Add drive for I2C related pins on MT8183.

Changes in patch v2:
1)add the details strength specification description of the I2C pin.
2)change "mt8183_pin_drv_en_dis_range" to "mt8183_pin_e1e0en_range".
3)change "mt8183_pin_drv_e0_range" to "mt8183_pin_e0_range".
4)change "mt8183_pin_drv_e1_range" to "mt8183_pin_drv_e1_range".

Zhiyong Tao (1):
  pinctrl: add drive for I2C related pins on MT8183

 drivers/pinctrl/mediatek/pinctrl-mt8183.c        | 50 ++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 45 +++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 13 ++++++
 drivers/pinctrl/mediatek/pinctrl-paris.c         | 20 ++++++++++
 4 files changed, 128 insertions(+)

--
2.12.5
