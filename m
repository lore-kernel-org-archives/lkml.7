Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA388C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C7F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438830AbfFLMUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:20:32 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:39734 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438796AbfFLMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:20:25 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id F038E25AEA9;
        Wed, 12 Jun 2019 22:20:22 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id E8276E21FE5; Wed, 12 Jun 2019 14:20:20 +0200 (CEST)
Date:   Wed, 12 Jun 2019 14:20:20 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH repost 0/5] Repost CAN and CANFD dt-bindings
Message-ID: <20190612122020.sgp5q427ilh6bbbg@verge.net.au>
References: <1557429622-31676-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB1770D2AAF2ED748575CA4CBFC0100@TY1PR01MB1770.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1770D2AAF2ED748575CA4CBFC0100@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

are you comfortable with me taking these patches
through the renesas tree? Or perhaps should they be reposted
to you for inclusion in net-next?

They have been stuck for a long time now.

On Fri, Jun 07, 2019 at 10:02:13AM +0000, Fabrizio Castro wrote:
> Dear All,
> 
> These patches have been around for a very long time now, is anybody willing to take them?
> 
> Cheers,
> Fab
> 
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Sent: 09 May 2019 20:20
> > Subject: [PATCH repost 0/5] Repost CAN and CANFD dt-bindings
> > 
> > Dear All,
> > 
> > I am reposting some CAN and CANFD related dt-bindings changes for
> > Renesas' R-Car and RZ/G devices that have been originally sent
> > end of last year and beginning of this year.
> > 
> > Thanks,
> > Fab
> > 
> > Fabrizio Castro (3):
> >   dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
> >   dt-bindings: can: rcar_can: Add r8a774c0 support
> >   dt-bindings: can: rcar_canfd: document r8a774c0 support
> > 
> > Marek Vasut (2):
> >   dt-bindings: can: rcar_canfd: document r8a77965 support
> >   dt-bindings: can: rcar_canfd: document r8a77990 support
> > 
> >  Documentation/devicetree/bindings/net/can/rcar_can.txt   | 13 ++++---------
> >  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 16 ++++++++++------
> >  2 files changed, 14 insertions(+), 15 deletions(-)
> > 
> > --
> > 2.7.4
> 
