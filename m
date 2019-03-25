Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3E2C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C567F2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbfCYVZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:25:40 -0400
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:41490 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730626AbfCYVZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:25:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D7190182CED28;
        Mon, 25 Mar 2019 21:25:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: arch06_1041f47dfa43b
X-Filterd-Recvd-Size: 4042
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:25:11 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Bad file pattern in MAINTAINERS section 'ETHERNET PHY LIBRARY'
Date:   Mon, 25 Mar 2019 14:25:10 -0700
Message-Id: <20190325212510.26351-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	5836	ETHERNET PHY LIBRARY
	5837	M:	Andrew Lunn <andrew@lunn.ch>
	5838	M:	Florian Fainelli <f.fainelli@gmail.com>
	5839	M:	Heiner Kallweit <hkallweit1@gmail.com>
	5840	L:	netdev@vger.kernel.org
	5841	S:	Maintained
	5842	F:	Documentation/ABI/testing/sysfs-bus-mdio
	5843	F:	Documentation/devicetree/bindings/net/mdio*
-->	5844	F:	Documentation/networking/phy.txt
	5845	F:	drivers/net/phy/
	5846	F:	drivers/of/of_mdio.c
	5847	F:	drivers/of/of_net.c
	5848	F:	include/linux/*mdio*.h
	5849	F:	include/linux/of_net.h
	5850	F:	include/linux/phy.h
	5851	F:	include/linux/phy_fixed.h
	5852	F:	include/linux/platform_data/mdio-bcm-unimac.h
	5853	F:	include/linux/platform_data/mdio-gpio.h
	5854	F:	include/trace/events/mdio.h
	5855	F:	include/uapi/linux/mdio.h
	5856	F:	include/uapi/linux/mii.h

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'Documentation/networking/phy.txt':

commit 22f08ad9721d4d1a92061b60026144627a60d644
Author: Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue Feb 18 09:47:49 2014 -0800

    MAINTAINERS: add entry for the PHY library
    
    The PHY library has been subject to some changes, new drivers and DT
    interactions over the past few months. Add myself as a maintainer for
    the core PHY library parts and drivers. Make sure the PHY library entry
    also covers the Device Tree files which have a close interaction with
    the MDIO bus, PHY connection and Ethernet PHY mode parsing.
    
    CC: Grant Likely <grant.likely@linaro.org>
    CC: Shaohui Xie <shaohui.xie@freescale.com>
    CC: Andy Fleming <afleming@gmail.com>
    Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

3: ---------------------------------------------------------------------------

The last commit with a real presence of file pattern 'Documentation/networking/phy.txt':

commit 25fe02d00a1e9468e0ae995beedb99867ec6701b
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Sat Jan 26 11:25:37 2019 +0100

    Documentation: net: phy: switch documentation to rst format
    
    Switch phylib documentation to rst format.
    
    Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: David S. Miller <davem@davemloft.net>

 Documentation/networking/index.rst |   1 +
 Documentation/networking/phy.rst   | 447 +++++++++++++++++++++++++++++++++++++
 Documentation/networking/phy.txt   | 429 -----------------------------------
 3 files changed, 448 insertions(+), 429 deletions(-)
