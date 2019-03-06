Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BF3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E530420661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfCFJv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:51:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:25403 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729903AbfCFJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:50:55 -0500
X-UUID: 635ddb677a2a4055862b6107092c98ad-20190306
X-UUID: 635ddb677a2a4055862b6107092c98ad-20190306
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1204594779; Wed, 06 Mar 2019 17:50:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 17:50:37 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 17:50:37 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: [PATCH v2 00/10] support gce on mt8183 platform
Date:   Wed, 6 Mar 2019 17:50:25 +0800
Message-ID: <1551865835-50974-1-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
 - add prefix "cmdq" in the commit subject
 - add dt-binding document for get event and subsys function
 - add fix up tag in fixup patch
 - fix up some coding style (alignment)

MTK will support gce function on mt8183 platform.
	dt-binding: gce: add gce header file for mt8183
	soc: mediatek: cmdq: add mt8183 compatible name

Besides above patches, we refine gce driver on those patches.
	soc: mediatek: cmdq: move the CMDQ_IRQ_MASK into cmdq driver data
	soc: mediatek: cmdq: clear the event in cmdq initial flow

In ordet to enhance the convenience of gce usage, we add new helper
functions and refine the method of instruction combining. 
	dt-binding: gce: add binding for gce event property
	dt-binding: gce: add binding for gce subsys property
	soc: mediatek: cmdq: add packet encoder function
	soc: mediatek: cmdq: add polling function
	soc: mediatek: cmdq: add cmdq_dev_get_subsys function
	soc: mediatek: cmdq: add cmdq_dev_get_event function

Bibby Hsieh (10):
  dt-binding: gce: add gce header file for mt8183
  dt-binding: gce: add binding for gce event property
  dt-binding: gce: add binding for gce subsys property
  soc: mediatek: cmdq: add mt8183 compatible name
  soc: mediatek: cmdq: move the CMDQ_IRQ_MASK into cmdq driver data
  soc: mediatek: cmdq: clear the event in cmdq initial flow
  soc: mediatek: cmdq: add packet encoder function
  soc: mediatek: cmdq: add polling function
  soc: mediatek: cmdq: add cmdq_dev_get_subsys function
  soc: mediatek: cmdq: add cmdq_dev_get_event function

 .../devicetree/bindings/mailbox/mtk-gce.txt        |  33 +++-
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  18 +-
 drivers/soc/mediatek/mtk-cmdq-helper.c             | 202 +++++++++++++++++----
 include/dt-bindings/gce/mt8183-gce.h               | 177 ++++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h           |   5 +
 include/linux/soc/mediatek/mtk-cmdq.h              |  61 ++++++-
 6 files changed, 439 insertions(+), 57 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8183-gce.h

-- 
1.9.1

