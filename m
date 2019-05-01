Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9508EC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6733121670
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfEAOE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:04:27 -0400
Received: from muru.com ([72.249.23.125]:47702 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfEAOE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:04:27 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B144D805C;
        Wed,  1 May 2019 14:04:42 +0000 (UTC)
Date:   Wed, 1 May 2019 07:04:22 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        tglx@linutronix.de, jason@lakedaemon.net,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linus.walleij@linaro.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 00/14] Add support for TISCI Interrupt controller
 drivers
Message-ID: <20190501140422.GJ8007@atomide.com>
References: <20190430101230.21794-1-lokeshvutla@ti.com>
 <30f5c877-a4dc-8ad9-0ad0-c172a60dc853@arm.com>
 <7edd8582-ce51-60a0-24e1-c45fe6725705@ti.com>
 <86pnp29tlv.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86pnp29tlv.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Marc Zyngier <marc.zyngier@arm.com> [190501 13:45]:
> On Wed, 01 May 2019 14:23:41 +0100,
> Lokesh Vutla <lokeshvutla@ti.com> wrote:
> > 
> > Hi Marc,
> 
> [...]
> 
> > > Lokesh,
> > > 
> > > Thanks for having respun this quickly.
> > > 
> > > I've applied the first 13 patches to irqchip-next (after tidying up some
> > > of the commit messages). I've left the last patch for armsoc to take,
> > > unless you guys insist on me taking it.
> > 
> > I prefer if everything goes as a single bundle, unless arm-soc maintainers
> > object. Want to start posting DT nodes.
> 
> Santosh, Tony: what do you prefer? I don't care either way, but I need
> a word from either of you.

Best to keep the series together IMO, and it's a tiny patch unlikely
to conflict with anything. Here's an ack from me for patch 14 from me:

Acked-by: Tony Lindgren <tony@atomide.com>
