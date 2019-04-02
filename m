Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8D1C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A970C2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDBVGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:06:33 -0400
Received: from mailoutvs42.siol.net ([185.57.226.233]:37258 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725822AbfDBVGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:06:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 24B81521A96;
        Tue,  2 Apr 2019 23:06:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wmGqwf2fL-Ec; Tue,  2 Apr 2019 23:06:29 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id C4A76521A7A;
        Tue,  2 Apr 2019 23:06:29 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id DFFD7521A96;
        Tue,  2 Apr 2019 23:06:28 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, jernej.skrabec@siol.net
Subject: [PATCH 0/3] clk: sunxi-ng: H6 related clock fixes
Date:   Tue,  2 Apr 2019 23:06:20 +0200
Message-Id: <20190402210623.14988-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During linux-next testing on Allwinner H6, I found several issues with
clock driver. This patch series fixes them.

Patch 1 fixes masking of unused factors in nkmp clocks.
Patch 2 fixes H6 hdmi-cec clock.
Patch 3 allows video and vpu related clocks to set parent rate.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (3):
  clk: sunxi-ng: nkmp: Avoid GENMASK(-1, 0)
  clk: sunxi-ng: h6: Preset hdmi-cec clock parent
  clk: sunxi-ng: h6: Allow video & vpu clocks to change parent rate

 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 17 ++++++++++++++---
 drivers/clk/sunxi-ng/ccu_nkmp.c      | 18 +++++++++++++-----
 2 files changed, 27 insertions(+), 8 deletions(-)

--=20
2.21.0

