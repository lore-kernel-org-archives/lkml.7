Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84A2C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30412075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDCPOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:14:15 -0400
Received: from mailoutvs29.siol.net ([185.57.226.220]:52236 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725990AbfDCPOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:14:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A21945228C2;
        Wed,  3 Apr 2019 17:14:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qR1CkoV3zC6F; Wed,  3 Apr 2019 17:14:12 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 3E3E452298E;
        Wed,  3 Apr 2019 17:14:12 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id E19E25228C2;
        Wed,  3 Apr 2019 17:14:11 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, jernej.skrabec@siol.net
Subject: [PATCH v2 0/2] clk: sunxi-ng: H6 related clock fixes
Date:   Wed,  3 Apr 2019 17:14:02 +0200
Message-Id: <20190403151404.26542-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During linux-next testing on Allwinner H6, I found several issues with
clock driver. This patch series fixes them.

Patch 1 allows video and vpu related clocks to set parent rate.
Patch 2 adds a comment with short explanation why zero width check is
needed.

Please take a look.

Best regards,
Jernej

Changes from v1:
- removed already applied patches
- fixed commit message
- added new patch which adds comment with explanation why zero width
  check is needed

Jernej Skrabec (2):
  clk: sunxi-ng: h6: Allow video & vpu clocks to change parent rate
  clk: sunxi-ng: nkmp: Explain why zero width check is needed

 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 6 +++---
 drivers/clk/sunxi-ng/ccu_nkmp.c      | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

--=20
2.21.0

