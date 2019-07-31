Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42529C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176CF206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfGaIGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:06:17 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:56559 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725866AbfGaIGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:06:17 -0400
Received: from localhost.localdomain ([176.167.166.146])
        by mwinf5d75 with ME
        id jL6E2000e39qjAg03L6F0r; Wed, 31 Jul 2019 10:06:16 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 31 Jul 2019 10:06:16 +0200
X-ME-IP: 176.167.166.146
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jcliburn@gmail.com, davem@davemloft.net, chris.snook@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/2] net: ag71xx: 2 small patches for 'ag71xx_rings_init()'
Date:   Wed, 31 Jul 2019 10:06:20 +0200
Message-Id: <cover.1564560130.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET (2):
  net: ag71xx: Slighly simplify code in 'ag71xx_rings_init()'
  net: ag71xx: Use GFP_KERNEL instead of GFP_ATOMIC in
    'ag71xx_rings_init()'

 drivers/net/ethernet/atheros/ag71xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1

