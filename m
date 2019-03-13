Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48566C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FF4214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfCMNJs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:09:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35882 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:09:48 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 540FB28018B;
        Wed, 13 Mar 2019 13:09:46 +0000 (GMT)
Date:   Wed, 13 Mar 2019 14:09:43 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
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
Message-ID: <20190313140943.01afcbdc@collabora.com>
In-Reply-To: <1552481734.2412.1@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
        <20190304104554.09be4cd4@xps13>
        <1551723742.4932.2@crapouillou.net>
        <20190304195149.7cca9c64@xps13>
        <1552481734.2412.1@crapouillou.net>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 09:55:34 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi,
> 
> Le lun. 4 mars 2019 à 15:51, Miquel Raynal <miquel.raynal@bootlin.com> 
> a écrit :
> > Hi Paul,
> >   
> >>  >>  ---   
> >> a/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt  
> >>  >>  +++   
> >> b/Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt  
> >>  >>  @@ -6,7 +6,10 @@ memory-controllers/ingenic,jz4780-nemc.txt),   
> >> and >> thus NAND device nodes must  
> >>  >>   be children of the NEMC node.  
> >>  >> >>   Required NAND controller device properties:  
> >>  >>  -- compatible: Should be set to "ingenic,jz4780-nand".
> >>  >>  +- compatible: Should be one of:
> >>  >>  +  * ingenic,jz4740-nand
> >>  >>  +  * ingenic,jz4725b-nand
> >>  >>  +  * ingenic,jz4780-nand  
> >>  >
> >>  > Wouldn't "-nand-controller" suffix be better? Of course in the   
> >> driver  
> >>  > you should still check for jz4780-nand.  
> >> 
> >>  So I would be compatible with:
> >>  * ingenic,jz4740-nand-controller
> >>  * ingenic,jz4725b-nand-controller
> >>  * ingenic,jz4780-nand
> >>  ?  
> > 
> > From a driver POV I would even prefer ingenic,jz4780-nand-controller. 
> > I
> > don't know what's best here. Maybe Boris or Rob can help?

Let's keep it consistent and have all compatibles follow the old
naming scheme (ingenic,<soc>-nand). But yes, for new drivers, I agree
that -nand-controller is better than just -nand.

