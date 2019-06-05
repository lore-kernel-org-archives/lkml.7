Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693F7C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3408B206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfFELn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:43:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20858 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727624AbfFELn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:43:28 -0400
X-UUID: 51816b59e12a44a795963106a2bc9b79-20190605
X-UUID: 51816b59e12a44a795963106a2bc9b79-20190605
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1953206414; Wed, 05 Jun 2019 19:43:22 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Jun 2019 19:43:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Jun 2019 19:43:20 +0800
From:   <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v3, 00/27] add drm support for MT8183
Date:   Wed, 5 Jun 2019 19:42:39 +0800
Message-ID: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This series are based on 5.2-rc1 and provid 27 patch
to support mediatek SOC MT8183

Change since v2
- fix reviewed issue in v2
- add mutex node into dts file

Yongqiang Niu (27):
  dt-bindings: mediatek: add binding for mt8183 display
  dt-bindings: mediatek: add ovl_2l description for mt8183 display
  dt-bindings: mediatek: add ccorr description for mt8183 display
  dt-bindings: mediatek: add dither description for mt8183 display
  arm64: dts: add display nodes for mt8183
  drm/mediatek: add mutex mod into ddp private data
  drm/mediatek: add mutex mod register offset into ddp private data
  drm/mediatek: add mutex sof into ddp private data
  drm/mediatek: add mutex sof register offset into ddp private data
  drm/mediatek: split DISP_REG_CONFIG_DSI_SEL setting into another use
    case
  drm/mediatek: add mmsys private data for ddp path config
  drm/mediatek: move rdma sout from mtk_ddp_mout_en into
    mtk_ddp_sout_sel
  drm/mediatek: add ddp component CCORR
  drm/mediatek: add commponent OVL_2L0
  drm/mediatek: add component OVL_2L1
  drm/mediatek: add component DITHER
  drm/mediatek: add gmc_bits for ovl private data
  drm/medaitek: add layer_nr for ovl private data
  drm/mediatek: add function to background color input select for
    ovl/ovl_2l direct link
  drm/mediatek: add background color input select function for
    ovl/ovl_2l
  drm/mediatek: add ovl0/ovl_2l0 usecase
  drm/mediatek: distinguish ovl and ovl_2l by layer_nr
  drm/mediatek: add connection from ovl0 to ovl_2l0
  drm/mediatek: add connection from RDMA0 to COLOR0
  drm/mediatek: add connection from RDMA1 to DSI0
  drm/mediatek: add clock property check before get it
  drm/mediatek: add support for mediatek SOC MT8183

 .../bindings/display/mediatek/mediatek,disp.txt    |  37 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           | 114 ++++++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  80 +++-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |  12 +
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  42 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 429 ++++++++++++++++-----
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |   6 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  68 ++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  23 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  52 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   4 +
 11 files changed, 745 insertions(+), 122 deletions(-)

-- 
1.8.1.1.dirty

