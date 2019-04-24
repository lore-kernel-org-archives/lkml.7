Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E158CC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97BD218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfDXBL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:11:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:14867 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726840AbfDXBL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:11:26 -0400
X-UUID: 14edc94b179041a481f5c3f5bf425e46-20190424
X-UUID: 14edc94b179041a481f5c3f5bf425e46-20190424
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 11053773; Wed, 24 Apr 2019 09:11:17 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Apr 2019 09:11:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Apr 2019 09:11:14 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <sean.wang@mediatek.com>,
        <erin.lo@mediatek.com>, <eddie.huang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/2] AUXADC: Mediatek auxadc driver on MT8183 
Date:   Wed, 24 Apr 2019 09:11:10 +0800
Message-ID: <20190424011112.14283-1-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A304E827802CE986D7A6A40BB546CB4E7BFA85422814C7499F4E9870BF7BC4192000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes two patches:
1.Add mt8183 auxadc compatible node in binding document.
1.Add mt8183 auxadc device node.

Changes in patch v2:
1)change auxadc compatible node in binding document for mt8183.

Zhiyong Tao (2):
  dt-bindings: adc: mt8183: add binding document
  arm64: dts: mt8183: Add auxadc device node

 Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt |  1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts                 |  4 ++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                    | 10 ++++++++++
 3 files changed, 15 insertions(+)

--
2.12.5
