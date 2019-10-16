Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48229ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A73721835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391492AbfJPIhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:37:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41909 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389188AbfJPIhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:37:32 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iKeoC-0001WI-RN; Wed, 16 Oct 2019 10:37:28 +0200
Message-ID: <0426ad33c45627627512f636c45e35481d2b77da.camel@pengutronix.de>
Subject: Re: [PATCH net-next 0/1] Add BASE-T1 PHY support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Christian Herber <christian.herber@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 16 Oct 2019 10:37:27 +0200
In-Reply-To: <8c15b855-6947-9930-c3df-71a64fbff33b@gmail.com>
References: <20190815153209.21529-1-christian.herber@nxp.com>
         <8c15b855-6947-9930-c3df-71a64fbff33b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2019-08-16 at 22:59 +0200, Heiner Kallweit wrote:
> On 15.08.2019 17:32, Christian Herber wrote:
> > This patch adds basic support for BASE-T1 PHYs in the framework.
> > BASE-T1 PHYs main area of application are automotive and industrial.
> > BASE-T1 is standardized in IEEE 802.3, namely
> > - IEEE 802.3bw: 100BASE-T1
> > - IEEE 802.3bp 1000BASE-T1
> > - IEEE 802.3cg: 10BASE-T1L and 10BASE-T1S
> > 
> > There are no products which contain BASE-T1 and consumer type PHYs like
> > 1000BASE-T. However, devices exist which combine 100BASE-T1 and 1000BASE-T1
> > PHYs with auto-negotiation.
> 
> Is this meant in a way that *currently* there are no PHY's combining Base-T1
> with normal Base-T modes? Or are there reasons why this isn't possible in
> general? I'm asking because we have PHY's combining copper and fiber, and e.g.
> the mentioned Aquantia PHY that combines NBase-T with 1000Base-T2.

There are PHYs combining both Base-T1 and other Base-T capabilities.
E.g. the Broadcom BCM54811 support both Base-T1, as well as 1000BASE-T
and 100BASE-TX.

Regards,
Lucas

