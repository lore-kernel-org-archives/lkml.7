Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E231AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B379B20828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfCFJuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:50:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:21977 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729863AbfCFJuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:50:54 -0500
X-UUID: ce6a7fdbda6b4cae843161f54e138fe4-20190306
X-UUID: ce6a7fdbda6b4cae843161f54e138fe4-20190306
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1706351475; Wed, 06 Mar 2019 17:50:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 17:50:38 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 17:50:38 +0800
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
Subject: [PATCH v2 04/10] soc: mediatek: cmdq: add mt8183 compatible name
Date:   Wed, 6 Mar 2019 17:50:29 +0800
Message-ID: <1551865835-50974-5-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551865835-50974-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1551865835-50974-1-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F332B05AE3887809F258585BD9F4BD29A6063093C55A805B9237E2F8EAA50BD72000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add mt8183 compatible name

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 2281178..909eb23 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -536,6 +536,7 @@ static int cmdq_probe(struct platform_device *pdev)
 
 static const struct of_device_id cmdq_of_ids[] = {
 	{.compatible = "mediatek,mt8173-gce", .data = (void *)16},
+	{.compatible = "mediatek,mt8183-gce", .data = (void *)24},
 	{}
 };
 
-- 
1.9.1

