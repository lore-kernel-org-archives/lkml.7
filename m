Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F37EC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB9120989
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfGFKGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:06:00 -0400
Received: from mailoutvs16.siol.net ([185.57.226.207]:33704 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725988AbfGFKGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:06:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 54332521F8D;
        Sat,  6 Jul 2019 12:05:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YchohIpvYd1s; Sat,  6 Jul 2019 12:05:56 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 1F8515211EF;
        Sat,  6 Jul 2019 12:05:55 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 78FC3521F78;
        Sat,  6 Jul 2019 12:05:53 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     wens@csie.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] regulator: axp20x: Fix bugs for AXP803/6
Date:   Sat,  6 Jul 2019 12:05:43 +0200
Message-Id: <20190706100545.22759-1-jernej.skrabec@siol.net>
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

Jernej Skrabec (2):
  regulator: axp20x: fix DCDCA and DCDCD for AXP806
  regulator: axp20x: fix DCDC6 for AXP803

 drivers/regulator/axp20x-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--=20
2.22.0

