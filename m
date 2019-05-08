Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC05EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CCD21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfEHJjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:39:37 -0400
Received: from 60-251-196-230.HINET-IP.hinet.net ([60.251.196.230]:53324 "EHLO
        ironport.ite.com.tw" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726727AbfEHJjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:39:37 -0400
X-Greylist: delayed 6251 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 May 2019 05:39:35 EDT
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 08 May 2019 17:39:34 +0800
Received: from csbcas.internal.ite.com.tw (csbcas1.internal.ite.com.tw [192.168.65.46])
        by mse.ite.com.tw with ESMTP id x489dVGb055126;
        Wed, 8 May 2019 17:39:31 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from allen-VirtualBox.internal.ite.com.tw (192.168.70.14) by
 csbcas1.internal.ite.com.tw (192.168.65.45) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Wed, 8 May 2019 17:39:32 +0800
From:   allen <allen.chen@ite.com.tw>
To:     <allen.chen@ite.com.tw>
CC:     Pi-Hsun Shih <pihsun@chromium.org>,
        Amithash Prasad <amithash@fb.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 0/3] IT6505 cover letter
Date:   Wed, 8 May 2019 17:31:55 +0800
Message-ID: <1557307985-21228-1-git-send-email-allen.chen@ite.com.tw>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.70.14]
X-MAIL: mse.ite.com.tw x489dVGb055126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IT6505 is a high-performance DisplayPort 1.1a transmitter, fully compliant with DisplayPort 1.1a, HDCP 1.3 specifications. The IT6505 supports color depth of up to 36 bits (12 bits/color) and ensures robust transmission of high-quality uncompressed video content, along with uncompressed and compressed digital audio content.

This series contains document bindings, Kconfig to control the function enable or not.

Allen Chen (3):
  dt-bindings: Add binding for IT6505.
  drm/bridge: add it6505 driver
  drm/bridge: it6505 driver add char device feature.

 .../bindings/display/bridge/ite,it6505.txt         |   30 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/gpu/drm/bridge/Kconfig                     |   22 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/ite-it6505.c                | 2768 ++++++++++++++++++++
 5 files changed, 2822 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6505.txt
 create mode 100644 drivers/gpu/drm/bridge/ite-it6505.c

-- 
1.9.1

