Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6901C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D5F20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfCDTFz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:05:55 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:52345 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:05:55 -0500
Received: from xps13 (76.15.136.77.rev.sfr.net [77.136.15.76])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 77901200006;
        Mon,  4 Mar 2019 19:05:48 +0000 (UTC)
Date:   Mon, 4 Mar 2019 20:04:25 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] mtd: rawnand: ingenic: Separate top-level and
 SoC specific code
Message-ID: <20190304200129.4eefabba@xps13>
In-Reply-To: <1551723968.4932.4@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190209192305.4434-6-paul@crapouillou.net>
        <20190304112058.67cd5194@xps13>
        <1551723968.4932.4@crapouillou.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Paul Cercueil <paul@crapouillou.net> wrote on Mon, 04 Mar 2019 19:26:08
+0100:

> On Mon, Mar 4, 2019 at 11:20 AM, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > Hi Paul,
> > 
> > Paul Cercueil <paul@crapouillou.net <mailto:paul@crapouillou.net>> > wrote on Sat,  9 Feb 2019 16:23:02
> > -0300:
> >   
> >>  The ingenic-nand driver uses an API provided by the jz4780-bch >> driver.
> >>  This makes it difficult to support other SoCs in the jz4780-bch >> driver.
> >>  To work around this, we separate the API functions from the >> SoC-specific
> >>  code, so that these API functions are SoC-agnostic.  
> >> >   
> > I like the idea, actually I am working on this separation (see
> > [1]) and I would really appreciate that you try to implement the
> > interface when it will be available (v2 is coming this week, I think > v3
> > will be the one to test when raw NAND devices will be properly
> > supported). I will add you in Cc: if you want to follow/review.
> > 
> > [1] > <http://lists.infradead.org/pipermail/linux-mtd/2019-February/087815.html
> >  
> 
> Do you think this will be ready for 5.2?

Maybe, but I can't tell for sure. It will depend on how invasive the
raw NAND conversion is. I don't want to delay your work but maybe once
the interface will be ready to be implemented it would be a great
opportunity to do it with the Ingenic driver.

> 
> You can add me in Cc:.

Thanks!
Miquèl
