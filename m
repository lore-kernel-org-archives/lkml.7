Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E84C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF60206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfCDSqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:46:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37506 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDSqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:46:10 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 84FD9147120FB;
        Mon,  4 Mar 2019 10:46:09 -0800 (PST)
Date:   Mon, 04 Mar 2019 10:46:08 -0800 (PST)
Message-Id: <20190304.104608.454889553821306700.davem@davemloft.net>
To:     antoine.tenart@bootlin.com
Cc:     linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 0/3] net: phy: marvell10g: implement
 suspend/resume callbacks
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190301110047.20257-1-antoine.tenart@bootlin.com>
References: <20190301110047.20257-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 Mar 2019 10:46:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Fri,  1 Mar 2019 12:00:44 +0100

> This series implements the suspend/resume callbacks in the marvell10g
> PHY driver:
> 
> - When the PHY isn't used, it is set in low power mode.
> - At boot time we might now know the PHY status (as it's depending on
>   the hardware configuration, or on what the previous stages
>   configured), it is forced in low power.
> 
> Doing this prevents a PHY which was initialized in a previous stage from
> negotiating with the link partner when a local port is down. If the PHY
> isn't shutdown when a port is not used, the link partner's PHY may
> report the link being up while it's not.

Looks like this needs some more discussion and Russell has some
concerns still.

So deferring to the next merge window, sorry.
