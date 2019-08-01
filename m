Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E5EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20E7206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfHAJgm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:36:42 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:38127 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHAJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:36:41 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A37A2200003;
        Thu,  1 Aug 2019 09:36:32 +0000 (UTC)
Date:   Thu, 1 Aug 2019 11:36:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        juliensu@mxic.com.tw, lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, paul@crapouillou.net,
        paul.burton@mips.com, richard@nod.at, robh+dt@kernel.org,
        stefan@agner.ch, vigneshr@ti.com
Subject: Re: [PATCH v6 2/2] dt-bindings: mtd: Document Macronix raw NAND
 controller bindings
Message-ID: <20190801113631.0dcbbf2a@xps13>
In-Reply-To: <OF6FA21ABA.C0DF9C78-ON48258449.00331EB3-48258449.0034600D@mxic.com.tw>
References: <1564631710-30276-1-git-send-email-masonccyang@mxic.com.tw>
        <1564631710-30276-3-git-send-email-masonccyang@mxic.com.tw>
        <20190801091310.035bc824@xps13>
        <OF6FA21ABA.C0DF9C78-ON48258449.00331EB3-48258449.0034600D@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

masonccyang@mxic.com.tw wrote on Thu, 1 Aug 2019 17:32:04 +0800:

> Hi Miquel,
> 
> > > Document the bindings used by the Macronix raw NAND controller.
> > > 
> > > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > > ---
> > >  Documentation/devicetree/bindings/mtd/mxic-nand.txt | 19   
> +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >  create mode 100644   
> Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/  
> > Documentation/devicetree/bindings/mtd/mxic-nand.txt  
> > > new file mode 100644
> > > index 0000000..de37d60
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > > @@ -0,0 +1,19 @@
> > > +Macronix Raw NAND Controller Device Tree Bindings
> > > +-------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible: should be "mxicy,multi-itfc-v009-nand-morph"
> > > +- reg: should contain 1 entry for the registers
> > > +- interrupts: interrupt line connected to this raw NAND controller
> > > +- clock-names: should contain "ps", "send" and "send_dly"
> > > +- clocks: should contain 3 phandles for the "ps", "send" and
> > > +    "send_dly" clocks
> > > +
> > > +Example:
> > > +
> > > +   nand: nand-controller@43c30000 {
> > > +      compatible = "mxicy,multi-itfc-v009-nand-morph";  
> > 
> > "mxicy" looks strange to me, I know it has been used in the past and
> > cannot be removed, but I don't think it is wise to continue using it
> > while your use "mxic" in all your other contributions. I would update
> > the prefix to mxic here and fill-in the relevant doc.
> > 
> > Also, what is nand-morph? I thought we were okay for
> > the "-nand-controller" suffix.
> >   
> 
> I thought there is a node name "nand-controller@43c30000" and the
> "-nand-controller" suffix in compatible property seems repeated.

It is repeated because it won't be used the same way. The node name
will only be relevant in the DT itself (to reference a node for
instance). I will also appear in the sysfs.

The compatibles are listed in drivers and "given" to the kernel core so
that the device-driver association can take place.

> 
> In addition, I would like to indicate it's a multi function controller.
> 
> nand-morph means this multi interface controller (multi-itfc) works in
> raw NAND controller.

I think this is clear as you already put "multi-itfc" in the name. If
you want you can switch to "morph" in the prefix, but I want the suffix
to be "-nand-controller".

Thanks,
Miquèl
