Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2114CC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 10:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7C120880
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 10:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfHKKk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 06:40:56 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:43394 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726510AbfHKKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 06:40:53 -0400
X-UUID: 7cb4b3d1ac4b46bd9043762f13ec7747-20190811
X-UUID: 7cb4b3d1ac4b46bd9043762f13ec7747-20190811
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2042052334; Sun, 11 Aug 2019 18:40:51 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 11 Aug
 2019 18:40:47 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sun, 11 Aug 2019 18:40:46 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        <linux-pwm@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>, <stonea168@163.com>
Subject: [PATCH v6 5/7] drm/mediatek: add mt8183 dsi driver support
Date:   Sun, 11 Aug 2019 18:40:06 +0800
Message-ID: <20190811104008.53372-6-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811104008.53372-1-jitao.shi@mediatek.com>
References: <20190811104008.53372-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: 115C68D5AFF523B862A455F59293ED2A25A28DC8FC53698C637F8CF8A72DF05D2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8183 dsi driver data. Enable size control and
reg commit control.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 68794edecf96..b3676426aeb5 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1227,11 +1227,19 @@ static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
 	.reg_cmdq_off = 0x180,
 };
 
+static const struct mtk_dsi_driver_data mt8183_dsi_driver_data = {
+	.reg_cmdq_off = 0x200,
+	.has_shadow_ctl = true,
+	.has_size_ctl = true,
+};
+
 static const struct of_device_id mtk_dsi_of_match[] = {
 	{ .compatible = "mediatek,mt2701-dsi",
 	  .data = &mt2701_dsi_driver_data },
 	{ .compatible = "mediatek,mt8173-dsi",
 	  .data = &mt8173_dsi_driver_data },
+	{ .compatible = "mediatek,mt8183-dsi",
+	  .data = &mt8183_dsi_driver_data },
 	{ },
 };
 
-- 
2.21.0

