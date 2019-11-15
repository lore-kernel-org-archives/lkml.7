Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3589AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E7820748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKOKEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:04:49 -0500
Received: from 60-251-196-230.HINET-IP.hinet.net ([60.251.196.230]:1398 "EHLO
        ironport.ite.com.tw" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727517AbfKOKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:04:47 -0500
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 15 Nov 2019 18:04:44 +0800
Received: from csbcas.internal.ite.com.tw (csbcas1.internal.ite.com.tw [192.168.65.46])
        by mse.ite.com.tw with ESMTP id xAFA4gwv031714;
        Fri, 15 Nov 2019 18:04:42 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from allen-VirtualBox.internal.ite.com.tw (192.168.70.14) by
 csbcas1.internal.ite.com.tw (192.168.65.45) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Fri, 15 Nov 2019 18:04:42 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Heiko Stuebner <heiko@sntech.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:DRM DRIVERS FOR NVIDIA TEGRA" 
        <linux-tegra@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v4 0/4] IT6505 cover letter
Date:   Fri, 15 Nov 2019 17:52:16 +0800
Message-ID: <1573811564-320-1-git-send-email-allen.chen@ite.com.tw>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.70.14]
X-MAIL: mse.ite.com.tw xAFA4gwv031714
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IT6505 is a high-performance DisplayPort 1.1a transmitter, fully compliant with DisplayPort 1.1a, HDCP 1.3 specifications. The IT6505 supports color depth of up to 36 bits (12 bits/color) and ensures robust transmission of high-quality uncompressed video content, along with uncompressed and compressed digital audio content.

This series contains document bindings, revert commit, add vendor prefix, Kconfig to control the function enable or not.

Allen Chen (2):
  dt-bindings: Add binding for IT6505.
  drm/bridge: add it6505 driver

allen (2):
  dt-bindings: Add vendor prefix for ITE Tech. Inc.
  Revert "drm/tegra: Move drm_dp_link helpers to Tegra DRM"

 .../bindings/display/bridge/ite,it6505.txt         |   28 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 drivers/gpu/drm/bridge/Kconfig                     |    7 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/ite-it6505.c                | 2697 ++++++++++++++++++++
 drivers/gpu/drm/drm_dp_helper.c                    |  128 +
 drivers/gpu/drm/tegra/Makefile                     |    1 -
 drivers/gpu/drm/tegra/dp.c                         |  876 -------
 drivers/gpu/drm/tegra/dp.h                         |  177 --
 drivers/gpu/drm/tegra/dpaux.c                      |    1 -
 drivers/gpu/drm/tegra/sor.c                        |    1 -
 include/drm/drm_dp_helper.h                        |   16 +
 12 files changed, 2879 insertions(+), 1056 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6505.txt
 create mode 100644 drivers/gpu/drm/bridge/ite-it6505.c
 delete mode 100644 drivers/gpu/drm/tegra/dp.c
 delete mode 100644 drivers/gpu/drm/tegra/dp.h

-- 
1.9.1

