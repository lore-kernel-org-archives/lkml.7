Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5BEC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 13:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EECA222CF
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 13:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfJENJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 09:09:58 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:36248 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJENJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 09:09:58 -0400
Received: from ipservice-092-217-086-168.092.217.pools.vodafone-ip.de ([92.217.86.168] helo=reykholt.kaiser.cx)
        by viti.kaiser.cx with esmtpa (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1iGjoh-0003SB-QF; Sat, 05 Oct 2019 15:09:47 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexander Shiyan <shc_work@mail.ru>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/2] dt-bindings: display: fix native-mode setting
Date:   Sat,  5 Oct 2019 15:09:19 +0200
Message-Id: <20191005130921.12874-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190918193853.25689-1-martin@kaiser.cx>
References: <20190918193853.25689-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to
Documentation/devicetree/bindings/display/panel/display-timing.txt,
native-mode is a property of the display-timings node.

If it's located outside of display-timings, the native-mode setting is
ignored and the first display timing is used.

We've already fixed the board definitions which got this wrong. Fix the
examples in the device tree bindings as well.

Martin Kaiser (2):
  dt-bindings: display: imx: fix native-mode setting
  dt-bindings: display: clps711x-fb: fix native-mode setting

 Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt | 2 +-
 Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0

