Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4844CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19456213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfDADft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:35:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60239 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731389AbfDADft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 23:35:49 -0400
X-UUID: 8e813bea2063409d9ba0d2acd5cfc3df-20190401
X-UUID: 8e813bea2063409d9ba0d2acd5cfc3df-20190401
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 978732594; Mon, 01 Apr 2019 11:35:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Apr 2019 11:35:40 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Apr 2019 11:35:38 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <sean.wang@kernel.org>
CC:     <srv_heupstream@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <hui.liu@mediatek.com>, <eddie.huang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <biao.huang@mediatek.com>,
        <hongzhou.yang@mediatek.com>, <erin.lo@mediatek.com>,
        <sean.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v4 0/4] PINCTRL: Mediatek pinctrl patch on mt8183 
Date:   Mon, 1 Apr 2019 11:35:31 +0800
Message-ID: <20190401033535.16910-1-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DC64BED535830D267659E05F4DCF17E165132A3A96AA6A61A04D1A47E35AF0C52000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes 4 patches:
1.add pinctrl binding document on mt8183.
2.add pinctrl file on mt8183.
3.add pinctrl device node on mt8183.
4.add drive for I2C related pins on MT8183.

Changes in patch v4:
1)patch [1/4] is based on patch "https://patchwork.kernel.org/patch/10778511/".
2)patch [2/4] is based on patch "https://patchwork.kernel.org/patch/10814251/".
3)patch [3/4] is based on patch "https://patchwork.kernel.org/patch/10814239/".
4)modify correct title on patch [2/4] and patch [3/4].
5)add Reviewed-by on patch [1/4] and [2/4].
6)modify the function "mtk_pinconf_adv_pull_get" and "mtk_pinconf_adv_pull_set"
7)change "drive-strengt-adv" to "drive-strength-adv".
8)call "mtk_pinconf_adv_pull_get" in "mtk_pinconf_get".

Changes in patch v3:
1)add the patch "dt-bindings: pinctrl: mt8183: add binding document".
2)add the patch "arm64: dts: mt8183: add pintcrl file".
3)add the patch "arm64: dts: mt8183: add pintcrl device node".
4)add more datail information for the specific driving setup in commit message.
5)use "mediatek,drive-strength-adv" instead of
  "mediatek,drive-enable-adv" and "mediatek,drive-enable-disable".
6)change "PINCTRL_PIN_REG_DRV_EN_DIS" to "PINCTRL_PIN_REG_DRV_EN".
7)change the function "mtk_pinconf_adv_drive_set".

Changes in patch v2:
1)add the details strength specification of the I2c pins.
2)change "mt8183_pin_drv_en_dis_range" to "mt8183_pin_e1e0en_range".
3)change "mt8183_pin_drv_e0_range" to "mt8183_pin_e0_range".
4)change "mt8183_pin_drv_e1_range" to "mt8183_pin_e1_range".

Zhiyong Tao (4):
  dt-bindings: pinctrl: mt8183: add binding document
  arm64: dts: mt8183: add pinctrl file
  arm64: dts: mt8183: add pinctrl device node
  pinctrl: add drive for I2C related pins on MT8183

 .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt |  132 +++
 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h      | 1120 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   26 +-
 drivers/pinctrl/mediatek/pinctrl-mt8183.c          |   50 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c   |   49 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h   |   11 +
 drivers/pinctrl/mediatek/pinctrl-paris.c           |   21 +
 7 files changed, 1408 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h

--
2.12.5

