Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CF5C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA104206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfF1HnB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:43:01 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:59717 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF1HnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:43:01 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6B4AEFF803;
        Fri, 28 Jun 2019 07:42:51 +0000 (UTC)
Date:   Fri, 28 Jun 2019 09:42:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        broonie@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, jianxin.pan@amlogic.com, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, paul@crapouillou.net, paul.burton@mips.com,
        richard@nod.at, stefan@agner.ch, vigneshr@ti.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: Document Macronix raw NAND
 controller bindings
Message-ID: <20190628094250.1fd84505@xps13>
In-Reply-To: <OFFBD1710A.54AC467B-ON48258427.0023FCA3-48258427.00255B71@mxic.com.tw>
References: <1561443056-13766-1-git-send-email-masonccyang@mxic.com.tw>
        <1561443056-13766-3-git-send-email-masonccyang@mxic.com.tw>
        <20190627192609.0965f6d5@xps13>
        <OFFBD1710A.54AC467B-ON48258427.0023FCA3-48258427.00255B71@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Please always Cc: Rob (robh+dt@kernel.org) when you send bindings
related patches.

masonccyang@mxic.com.tw wrote on Fri, 28 Jun 2019
14:48:02 +0800:

> Hi Miquel,
> 
> > > Document the bindings used by the Macronix raw NAND controller.
> > > 
> > > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > > ---
> > >  .../devicetree/bindings/mtd/mxic-nand.txt          | 26   
> ++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >  create mode 100644   
> Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/  
> > Documentation/devicetree/bindings/mtd/mxic-nand.txt  
> > > new file mode 100644
> > > index 0000000..3d198e4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > > @@ -0,0 +1,26 @@
> > > +Macronix Raw NAND Controller Device Tree Bindings
> > > +-------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible: should be "mxic,raw-nand-ctlr"  
> > 
> > I would prefer "macronix,nand-controller"  
> 
> okay, will patch it.
> 
> >   
> > > +- reg: should contain 1 entrie for the registers  
> > 
> >                            entry
> >   
> > > +- reg-names: should contain "regs"  
> > 
> > Not sure you need that?  
> 
> for a base address of ctlr registers.

Yes I know, I mean: you don't necessarily need the 'reg-names' property
as it is supposed that the only entry will be the IP registers (unless
there are more). I don't know what's Rob preference here but I would
either drop the reg-names property or enhance the name, "regs" is
terribly not descriptive.

> > > +- interrupts: interrupt line connected to this NAND controller
> > > +- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"
> > > +- clocks: should contain 3 entries for the "ps_clk", "send_clk" and
> > > +    "send_dly_clk" clocks  
> > 
> > s/entries/phandles/ ?  
> 
> ?
> as I know that kernel views the phandle values as device tree structure
> information instead of device tree data and thus does not store them as
> properties.

The bindings have nothing to do with the kernel views. They might
actually be merged in a different project, out of the kernel.


Thanks,
Miquèl
