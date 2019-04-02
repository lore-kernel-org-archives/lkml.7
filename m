Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B949C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AFA207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfDBJuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:50:24 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:46871 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDBJuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:50:23 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 9D8D4C000B;
        Tue,  2 Apr 2019 09:50:18 +0000 (UTC)
Date:   Tue, 2 Apr 2019 11:50:17 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next v3 1/2] net: phy: marvell10g: implement
 suspend/resume callbacks
Message-ID: <20190402095017.GA3354@kwain>
References: <20190326145302.9563-1-antoine.tenart@bootlin.com>
 <20190326145302.9563-2-antoine.tenart@bootlin.com>
 <fa54cca8-c5c9-4498-c905-8fd360178c39@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa54cca8-c5c9-4498-c905-8fd360178c39@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

Sorry for the late answer.

On Tue, Mar 26, 2019 at 07:43:27PM +0100, Heiner Kallweit wrote:
> On 26.03.2019 15:53, Antoine Tenart wrote:
> > This patch adds the suspend/resume callbacks for Marvell 10G PHYs. The
> > three PCS (base-t, base-r and 1000base-x) are set in low power (the PCS
> > are powered down) when the PHY isn't used.
> > 
> At least for the 3310 the datasheet mentions that via VEND2.f001.11
> the port can be powered down completely. As this would simplify the code,
> did you test this?

I just tested this, and it does simplify the code a lot. Thanks for
pointing out this bit.

I'll update and make a v2.

Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
