Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42D0C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B775F2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfJIHlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:41:10 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:28011 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbfJIHlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:41:09 -0400
X-UUID: 1c0ef69487f141ad80e3b5c84a2adce7-20191009
X-UUID: 1c0ef69487f141ad80e3b5c84a2adce7-20191009
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 397385473; Wed, 09 Oct 2019 15:41:03 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 15:41:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 15:40:58 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v3 01/11] dt-bindings: phy-mtk-tphy: add two optional properties for u2phy
Date:   Wed, 9 Oct 2019 15:40:24 +0800
Message-ID: <1570606834-5644-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D92F16B9EE319C5ADF5B71546DF82E0BFA49E37F44BEABF32811ABA90F90DB2B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two optional properties, one for tuning J-K voltage by INTR,
another for disconnect threshold, both of them are related with
connect detection

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: change commit log

v2: change description
---
 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
index a5f7a4f0dbc1..ce6abfbdfbe1 100644
--- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
@@ -52,6 +52,8 @@ Optional properties (PHY_TYPE_USB2 port (child) node):
 - mediatek,eye-vrt	: u32, the selection of VRT reference voltage
 - mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage
 - mediatek,bc12	: bool, enable BC12 of u2phy if support it
+- mediatek,discth	: u32, the selection of disconnect threshold
+- mediatek,intr	: u32, the selection of internal R (resistance)
 
 Example:
 
-- 
2.23.0

