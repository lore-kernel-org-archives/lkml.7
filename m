Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EFEC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B495C22CED
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfGZJtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:49:17 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:60016 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZJtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:49:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 66D6EFB04;
        Fri, 26 Jul 2019 11:49:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cdYBpbSNeu8W; Fri, 26 Jul 2019 11:49:13 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id EF5BC46AA1; Fri, 26 Jul 2019 11:49:12 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] drm/mxsfb: Read bus flags from bridge if present
Date:   Fri, 26 Jul 2019 11:49:11 +0200
Message-Id: <cover.1564134488.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bridge might have special requirmentes on the input bus. This
is e.g. used by the imx-nwl bridge.

Robert, maybe you can add this patch to your 'Improvements and fixes for mxsfb
DRM driver' since it depends on the first patch in this series anyway?

Tested with 'Improvements and fixes for mxsfb DRM driver'[0] and 'drm: bridge:
Add NWL MIPI DSI host controller support'[1] on next-20190725.

[0]: https://patchwork.freedesktop.org/series/62822/
[1]: https://patchwork.freedesktop.org/series/64185/

Guido Günther (1):
  drm/mxsfb: Read bus flags from bridge if present

 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.20.1

