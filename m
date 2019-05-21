Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AF3C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B37520856
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfEUJcZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:32:25 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:37889 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEUJcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:32:25 -0400
Received: from xps13 (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2C2FE100015;
        Tue, 21 May 2019 09:32:14 +0000 (UTC)
Date:   Tue, 21 May 2019 11:32:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Richard Weinberger" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: brcmnand: Make
 nand-ecc-strength and nand-ecc-step-size optional
Message-ID: <20190521113214.35e1edd0@xps13>
In-Reply-To: <5986da5d-2a61-b98d-9d44-d972a19ab732@kontron.de>
References: <1558379144-28283-1-git-send-email-kdasu.kdev@gmail.com>
        <5986da5d-2a61-b98d-9d44-d972a19ab732@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Tue, 21 May
2019 09:31:04 +0000:

> Hi Kamal,
> 
> On 20.05.19 21:05, Kamal Dasu wrote:
> > nand-ecc-strength and nand-ecc-step-size can be made optional as
> > brcmnand driver can support using raw NAND layer detected values.
> > 
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > ---
> >   Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> > index bcda1df..29feaba 100644
> > --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> > +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
> > @@ -101,10 +101,10 @@ Required properties:
> >                                 number (e.g., 0, 1, 2, etc.)
> >   - #address-cells            : see partition.txt
> >   - #size-cells               : see partition.txt
> > -- nand-ecc-strength         : see nand.txt
> > -- nand-ecc-step-size        : must be 512 or 1024. See nand.txt
> >   
> >   Optional properties:
> > +- nand-ecc-strength         : see nand.txt
> > +- nand-ecc-step-size        : must be 512 or 1024. See nand.txt
> >   - nand-on-flash-bbt         : boolean, to enable the on-flash BBT for this
> >                                 chip-select. See nand.txt
> >   - brcm,nand-oob-sector-size : integer, to denote the spare area sector size  
> 
> I think you also need to change all references to nand.txt. This file 
> was recently moved to nand-controller.yaml.
> 

Oops, completely forgot about that *again*. Thanks for pointing it
Frieder!

Miquèl
