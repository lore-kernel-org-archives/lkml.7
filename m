Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88917C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6255F20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfCDS7E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:59:04 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37403 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCDS7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:59:04 -0500
X-Originating-IP: 77.136.15.76
Received: from xps13 (76.15.136.77.rev.sfr.net [77.136.15.76])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B8CA7E0002;
        Mon,  4 Mar 2019 18:58:55 +0000 (UTC)
Date:   Mon, 4 Mar 2019 19:58:52 +0100
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
Subject: Re: [PATCH v4 2/9] dt-bindings: mtd: ingenic: Change 'BCH' to 'ECC'
 in documentation
Message-ID: <20190304195852.45c056f6@xps13>
In-Reply-To: <1551723830.4932.3@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190209192305.4434-2-paul@crapouillou.net>
        <20190304105014.0cceea0a@xps13>
        <1551723830.4932.3@crapouillou.net>
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

Paul Cercueil <paul@crapouillou.net> wrote on Mon, 04 Mar 2019 19:23:50
+0100:

> On Mon, Mar 4, 2019 at 10:50 AM, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > Hi Paul,
> > 
> > Paul Cercueil <paul@crapouillou.net <mailto:paul@crapouillou.net>> > wrote on Sat,  9 Feb 2019 16:22:58
> > -0300:
> >   
> >>  The JZ4740 ECC hardware is not BCH but Reed-Solomon, so it makes >> more
> >>  sense to use the more generic ECC term.  
> >> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net >> <mailto:paul@crapouillou.net>>  
> >>  ---  
> >> >>  Changes:
> >> >>  v3: New patch
> >> >>  v4: No change
> >> >>   .../devicetree/bindings/mtd/ingenic,jz4780-nand.txt    | 18 >> +++++++++---------  
> >>   1 file changed, 9 insertions(+), 9 deletions(-)  
> >> >>  diff --git >> a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt >> b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt  
> >>  index a5b940f18bf6..5a45cc54f46d 100644
> >>  --- a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
> >>  +++ b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
> >>  @@ -1,4 +1,4 @@
> >>  -* Ingenic JZ4780 NAND/BCH
> >>  +* Ingenic JZ4780 NAND/ECC  
> >> >>   This file documents the device tree bindings for NAND flash >> devices on the  
> >>   JZ4780. NAND devices are connected to the NEMC controller >> (described in
> >>  @@ -14,10 +14,10 @@ Required NAND controller device properties:
> >>     an offset of 0 and a size of 0x1000000 (i.e. the whole NEMC >> bank).  
> >> >>   Optional NAND controller device properties:  
> >>  -- ingenic,bch-controller: To make use of the hardware BCH >> controller, this
> >>  -  property must contain a phandle for the BCH controller node. The >> required
> >>  +- ingenic,bch-controller: To make use of the hardware ECC >> controller, this
> >>  +  property must contain a phandle for the ECC controller node. The >> required  
> > 
> > I think there is already a 'ecc-engine' property used by MTK and Atmel
> > NAND controllers to point to the ECC engine block. Please use this
> > property instead of the ingenic specific one.  
> 
> ingenic,bch-controller is already in the devicetree ABI. I can't change it now...

Oh, right...

Well, same thing as before, maybe you can change it and keep the driver
backward compatible? I don't want new DT to use this property because
it is not generic and we must have a way from the core to find the ECC
engine handle when the controller does not embed one itself (thus, the
ecc-engine property which is around for quite some time already).

Thanks,
Miquèl
