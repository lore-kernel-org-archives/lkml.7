Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0415C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963102087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbfCZOzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:55:14 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54479 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731896AbfCZOzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:55:13 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0330FE0009;
        Tue, 26 Mar 2019 14:55:08 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
Subject: [PATCH net-next v3 0/2] net: phy: marvell10g: implement suspend/resume callbacks
Date:   Tue, 26 Mar 2019 15:53:00 +0100
Message-Id: <20190326145302.9563-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series implements the suspend/resume callbacks in the marvell10g
PHY driver.

Thanks,
Antoine

Since v2:
  - Removed the third patch, setting the PHY in low power by default, as
    the change was controversial.
  - Rebased on the latest net-next.

Since v1:
  - Fixed a mix up in the patches where two implementations of the
    suspend/resume callbacks were kept in the driver.
  - Rebased on the latest net-next.

Antoine Tenart (2):
  net: phy: marvell10g: implement suspend/resume callbacks
  net: phy: marvell10g: add the suspend/resume callbacks for the 88x2210

 drivers/net/phy/marvell10g.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.20.1

