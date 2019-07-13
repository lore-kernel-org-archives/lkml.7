Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDCBC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 09:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87FE2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 09:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfGMJH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 05:07:27 -0400
Received: from mailoutvs27.siol.net ([185.57.226.218]:37198 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726421AbfGMJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 05:07:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 9AC04521342;
        Sat, 13 Jul 2019 11:07:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id m-6CwcbiJgKp; Sat, 13 Jul 2019 11:07:24 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 5C9CD521385;
        Sat, 13 Jul 2019 11:07:24 +0200 (CEST)
Received: from localhost.localdomain (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id BE1CF521342;
        Sat, 13 Jul 2019 11:07:23 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     broonie@kernel.org, wens@csie.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 0/2] regulator: axp20x: Fix bugs for AXP803/6
Date:   Sat, 13 Jul 2019 11:07:15 +0200
Message-Id: <20190713090717.347-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver refactoring caused few bugs and most of them are already fixed.
However, some are still present, namely in AXP806 and AXP803 regulator
definitions.

This short patch series fix them.

Please take a look.

Best regards,
Jernej

Changes from v1:
- Expanded commit message
- Added fix for AXP803 DCDC5

Jernej Skrabec (2):
  regulator: axp20x: fix DCDCA and DCDCD for AXP806
  regulator: axp20x: fix DCDC5 and DCDC6 for AXP803

 drivers/regulator/axp20x-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--=20
2.22.0

