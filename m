Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C1C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535E0206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HcmR7vDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfG3DgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:36:07 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46536 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfG3DgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DnRQYGUn98qmHApRiqr5In9coT/SMPR+4lxU8rq+yus=; b=HcmR7vDDBUMagJx/HRjSXqbrOw
        uUCCuhMLhgO+RgUejNlhQPDsGV0XIGJMdJ5BKY7w1pn4R4dNqnuSAdV6Cv8EoTOK7yDVYUbyDnkJS
        Yn3IGdfwOmH1sZGvil2Gup038de264kxZDwH9gyE4Vmg+9wX0JFyMMkTQ9FzseDrzdpg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hsIve-0005XU-Pz; Tue, 30 Jul 2019 05:35:58 +0200
Date:   Tue, 30 Jul 2019 05:35:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tao Ren <taoren@fb.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH net-next 1/2] net: phy: broadcom: set features explicitly
 for BCM54616S
Message-ID: <20190730033558.GB20628@lunn.ch>
References: <20190730002532.85509-1-taoren@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730002532.85509-1-taoren@fb.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 05:25:32PM -0700, Tao Ren wrote:
> BCM54616S feature "PHY_GBIT_FEATURES" was removed by commit dcdecdcfe1fc
> ("net: phy: switch drivers to use dynamic feature detection"). As dynamic
> feature detection doesn't work when BCM54616S is working in RGMII-Fiber
> mode (different sets of MII Control/Status registers being used), let's
> set "PHY_GBIT_FEATURES" for BCM54616S explicitly.

Hi Tao

What exactly does it get wrong?

     Thanks
	Andrew
