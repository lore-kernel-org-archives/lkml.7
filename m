Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE778C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86542082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbfFJIzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:55:36 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38659 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbfFJIzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:55:36 -0400
X-Originating-IP: 90.88.159.246
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-40-246.w90-88.abo.wanadoo.fr [90.88.159.246])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C5863FF80A;
        Mon, 10 Jun 2019 08:55:30 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 0/3] net: mvpp2: Add extra ethtool stats
Date:   Mon, 10 Jun 2019 10:55:26 +0200
Message-Id: <20190610085529.16803-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for more ethtool counters in PPv2 :
 - Per port counters, including one indicating the classifier drops
 - Per RXQ and per TXQ counters

The first 2 patches perform some light rework and renaming, and the 3rd
adds the extra counters.

Maxime Chevallier (3):
  net: mvpp2: Only clear the stat counters at port init
  net: mvpp2: Rename mvpp2_ethtool_counters to
    mvpp2_ethtool_mib_counters
  net: mvpp2: Add support for more ethtool counters

 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  18 +++
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 134 +++++++++++++++---
 2 files changed, 133 insertions(+), 19 deletions(-)

-- 
2.20.1

