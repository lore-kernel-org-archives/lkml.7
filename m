Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57307C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFC92070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfDBNPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:15:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54779 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731137AbfDBNPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:15:15 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7C5C320011;
        Tue,  2 Apr 2019 13:15:11 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
Subject: [PATCH net-next v4 0/2] net: phy: marvell10g: implement suspend/resume callbacks
Date:   Tue,  2 Apr 2019 15:10:27 +0200
Message-Id: <20190402131029.26880-1-antoine.tenart@bootlin.com>
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

Since v3:
  - Use the new phy_set/clear_bits_mmd() instead of phy_modify_mmd().
  - Use VEND2.f001.11 to power down the port instead of the per-mode
    LPOWER.

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

 drivers/net/phy/marvell10g.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.20.1

