Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAAAC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E90D208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfILJEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:04:15 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:36194 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730218AbfILJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:04:14 -0400
X-UUID: 68894de430da47989fae04bea9139ecb-20190912
X-UUID: 68894de430da47989fae04bea9139ecb-20190912
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2104157100; Thu, 12 Sep 2019 17:04:08 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 Sep
 2019 17:04:06 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Thu, 12 Sep 2019 17:04:05 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 0/3] add panel driver for innolux,p097pfg with ssd2825 bridge
Date:   Thu, 12 Sep 2019 17:04:01 +0800
Message-ID: <20190912090404.89822-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: 7750BE36942D4B8614D9DC6650D110B6A4CA3516067561C7C1C9FF4D7C3336762000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver to support panel innolux,p097pfg with bridge ssd2858.
SSD2858 can spilt dsi 4 lanes to 8 lanes.

Jitao Shi (3):
  drm/panel: panel-innolux: Allow 2 reset pins for panel
  dt-bindings: display: Add documentation for innolux,p097pfg_ssd2858
    panel
  drm/panel: panel-innolux: Add support for P097PFZ behind SSD2858

 .../display/panel/innolux,p097pfg_ssd2858.txt |  39 +++++
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 140 ++++++++++++++++--
 2 files changed, 164 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p097pfg_ssd2858.txt

-- 
2.21.0

