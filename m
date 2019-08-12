Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F770C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603AA206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfHLIRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:17:35 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:60661 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfHLIRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:17:35 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id DCC74100002;
        Mon, 12 Aug 2019 08:17:31 +0000 (UTC)
Date:   Mon, 12 Aug 2019 10:17:31 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Igor Russkikh <Igor.Russkikh@aquantia.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "sd@queasysnail.net" <sd@queasysnail.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "allan.nielsen@microchip.com" <allan.nielsen@microchip.com>,
        "camelia.groza@nxp.com" <camelia.groza@nxp.com>,
        Simon Edelhaus <Simon.Edelhaus@aquantia.com>,
        Pavel Belous <Pavel.Belous@aquantia.com>
Subject: Re: [PATCH net-next v2 2/9] net: macsec: move some definitions in a
 dedicated header
Message-ID: <20190812081731.GE3698@kwain>
References: <20190808140600.21477-1-antoine.tenart@bootlin.com>
 <20190808140600.21477-3-antoine.tenart@bootlin.com>
 <9f65de8e-bf62-f9b0-5aba-69c0f92df1ca@aquantia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f65de8e-bf62-f9b0-5aba-69c0f92df1ca@aquantia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Sat, Aug 10, 2019 at 12:19:36PM +0000, Igor Russkikh wrote:
> > +/**
> > + * struct macsec_tx_sa - transmit secure association
> > + * @active:
> > + * @next_pn: packet number to use for the next packet
> > + * @lock: protects next_pn manipulations
> > + * @key: key structure
> > + * @stats: per-SA stats
> > + */
> > +struct macsec_tx_sa {
> > +	struct macsec_key key;
> > +	spinlock_t lock;
> > +	u32 next_pn;
> > +	refcount_t refcnt;
> > +	bool active;
> > +	bool offloaded;
> 
> I don't see this `offloaded` field being used anywhere. Is this needed?

You're right it's not and was only used in previous versions of this
patchset. I'll remove it.

Thanks for spotting this!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
