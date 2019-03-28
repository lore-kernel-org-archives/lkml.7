Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C1A21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfC1KEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:04:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:33774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfC1KEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:04:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD106B160;
        Thu, 28 Mar 2019 10:04:12 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 6E67AE1404; Thu, 28 Mar 2019 11:04:12 +0100 (CET)
Date:   Thu, 28 Mar 2019 11:04:12 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 16/22] ethtool: provide link settings and
 link modes in GET_SETTINGS request
Message-ID: <20190328100412.GD26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <0ae3153e1816aea673f2ec8b4bd3898638aa07f7.1553532199.git.mkubecek@suse.cz>
 <8fe118a8-2a51-5740-de68-300f52a81861@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fe118a8-2a51-5740-de68-300f52a81861@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 08:44:58PM -0700, Florian Fainelli wrote:
> 
> 
> On 3/25/2019 10:08 AM, Michal Kubecek wrote:
> > Implement GET_SETTINGS netlink request to get link settings and link mode
> > information provided by ETHTOOL_GLINKSETTINGS ioctl command.
> > 
> > The information in SET_SETTINGS message sent as reply is divided into two
> > parts: autonegotiation, speed, duplex and supported, advertised and peer
> > advertised link modes when ETH_SETTINGS_IM_LINKMODES flag is set in the
> > request and other settings when ETH_SETTINGS_IM_LINKINFO is set.
> > 
> > Send notification in the same format as the reply message when relevant
> > fields are modified using the ioctl interface (ETHTOOL_SLINKSETTINGS or
> > ETHTOOL_SSET command).
> > 
> > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> > ---
> 
> [snip]
> 
> > +    ETHA_SETTINGS_DEV		(nested)	device identification
> > +    ETHA_SETTINGS_LINK_INFO	(nested)	link settings
> > +        ETHA_LINKINFO_PORT		(u8)		physical port
> > +        ETHA_LINKINFO_PHYADDR		(u8)		MDIO address of phy
> > +        ETHA_LINKINFO_TP_MDIX		(u8)		MDI(-X) status
> > +        ETHA_LINKINFO_TP_MDIX_CTRL	(u8)		MDI(-X) control
> > +        ETHA_LINKINFO_TRANSCEIVER	(u8)		transceiver
> > +    ETHA_SETTINGS_LINK_MODES	(nested)	link modes
> > +        ETHA_LINKMODES_AUTONEG		(u8)		autoneotiation status
> 
> Typo: auto-negotiation status.

Will fix, thanks.

Michal
