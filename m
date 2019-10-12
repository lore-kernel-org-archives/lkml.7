Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD70CC47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B203E214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfJLDHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 23:07:41 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:53678 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726269AbfJLDHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 23:07:41 -0400
X-UUID: f4786114ad30410caee12130dced414c-20191012
X-UUID: f4786114ad30410caee12130dced414c-20191012
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 735632940; Sat, 12 Oct 2019 11:07:32 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 12 Oct
 2019 11:07:30 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sat, 12 Oct 2019 11:07:29 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v7 0/8] add driver for "boe, tv101wum-nl6", "boe, tv101wum-n53", "auo, kd101n80-45na" and "auo, b101uan08.3" panels
Date:   Sat, 12 Oct 2019 11:07:12 +0800
Message-ID: <20191012030720.27127-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: F7B07B99A81EF4E5D242E6BC593B327DF1589564B8DF92733C3F20695BD5F6C22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v6:
 - fix boe_panel_init err uninit.
 - adjust the delay of backlight on.

Changes since v5:
 - covert the documents to yaml
 - fine tune boe, tv101wum-n53 panel video timine

Changes since v4:
 - add auo,b101uan08.3 panel for this driver.
 - add boe,tv101wum-n53 panel for this driver.

Changes since v3:
 - remove check enable_gpio.
 - fine tune the auo,kd101n80-45na panel's power on timing.

Changes since v2:
 - correct the panel size
 - remove blank line in Kconfig
 - move auo,kd101n80-45na panel driver in this series.

Changes since v1:

 - update typo nl6 -> n16.
 - update new panel config and makefile are added in alphabetically order.
 - add the panel mode and panel info in driver data.
 - merge auo,kd101n80-45a and boe,tv101wum-nl6 in one driver

Jitao Shi (8):
  dt-bindings: display: panel: Add BOE tv101wum-n16 panel bindings
  drm/panel: support for BOE tv101wum-nl6 wuxga dsi video mode panel
  dt-bindings: display: panel: add auo kd101n80-45na panel bindings
  drm/panel: support for auo,kd101n80-45na wuxga dsi video mode panel
  dt-bindings: display: panel: add boe tv101wum-n53 panel documentation
  drm/panel: support for boe,tv101wum-n53 wuxga dsi video mode panel
  dt-bindings: display: panel: add AUO auo,b101uan08.3 panel
    documentation
  drm/panel: support for auo,b101uan08.3 wuxga dsi video mode panel

 .../display/panel/auo,b101uan08.3.yaml        |  67 ++
 .../display/panel/auo,kd101n80-45na.yaml      |  67 ++
 .../display/panel/boe,tv101wum-n53.yaml       |  67 ++
 .../display/panel/boe,tv101wum-nl6.yaml       |  67 ++
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 880 ++++++++++++++++++
 7 files changed, 1158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,kd101n80-45na.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-n53.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c

-- 
2.21.0

