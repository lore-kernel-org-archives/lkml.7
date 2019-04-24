Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1085BC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C9E2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfDXBLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:11:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50125 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726840AbfDXBLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:11:22 -0400
X-UUID: 222f0c07db1444ad9b77637cef47a9cb-20190424
X-UUID: 222f0c07db1444ad9b77637cef47a9cb-20190424
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1747827543; Wed, 24 Apr 2019 09:11:17 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 24 Apr 2019 09:11:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 24 Apr 2019 09:11:15 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <sean.wang@mediatek.com>,
        <erin.lo@mediatek.com>, <eddie.huang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: adc: mt8183: add binding document
Date:   Wed, 24 Apr 2019 09:11:11 +0800
Message-ID: <20190424011112.14283-2-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20190424011112.14283-1-zhiyong.tao@mediatek.com>
References: <20190424011112.14283-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit adds mt8183 compatible node in binding document.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
index 0df9befdaecc..936a0b4666da 100644
--- a/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt
@@ -15,6 +15,7 @@ Required properties:
     - "mediatek,mt2712-auxadc": For MT2712 family of SoCs
     - "mediatek,mt7622-auxadc": For MT7622 family of SoCs
     - "mediatek,mt8173-auxadc": For MT8173 family of SoCs
+    - "mediatek,mt8183-auxadc", "mediatek,mt8173-auxadc": For MT8183 family of SoCs
   - reg: Address range of the AUXADC unit.
   - clocks: Should contain a clock specifier for each entry in clock-names
   - clock-names: Should contain "main".
-- 
2.12.5

