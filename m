Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA10C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B80206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfCDSwA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:52:00 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46181 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCDSv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:51:59 -0500
X-Originating-IP: 77.136.15.76
Received: from xps13 (76.15.136.77.rev.sfr.net [77.136.15.76])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BC6AF1BF203;
        Mon,  4 Mar 2019 18:51:52 +0000 (UTC)
Date:   Mon, 4 Mar 2019 19:51:49 +0100
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
Subject: Re: [PATCH v4 1/9] dt-bindings: mtd: ingenic: Add compatible
 strings for JZ4740 and JZ4725B
Message-ID: <20190304195149.7cca9c64@xps13>
In-Reply-To: <1551723742.4932.2@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190304104554.09be4cd4@xps13>
        <1551723742.4932.2@crapouillou.net>
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

> >>  --- a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
> >>  +++ b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
> >>  @@ -6,7 +6,10 @@ memory-controllers/ingenic,jz4780-nemc.txt), and >> thus NAND device nodes must
> >>   be children of the NEMC node.  
> >> >>   Required NAND controller device properties:  
> >>  -- compatible: Should be set to "ingenic,jz4780-nand".
> >>  +- compatible: Should be one of:
> >>  +  * ingenic,jz4740-nand
> >>  +  * ingenic,jz4725b-nand
> >>  +  * ingenic,jz4780-nand  
> > 
> > Wouldn't "-nand-controller" suffix be better? Of course in the driver
> > you should still check for jz4780-nand.  
> 
> So I would be compatible with:
> * ingenic,jz4740-nand-controller
> * ingenic,jz4725b-nand-controller
> * ingenic,jz4780-nand
> ?

From a driver POV I would even prefer ingenic,jz4780-nand-controller. I
don't know what's best here. Maybe Boris or Rob can help?


Thanks,
Miquèl
