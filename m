Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAB6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91397206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbfHAJXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:23:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35666 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbfHAJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:23:49 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8B66728C2ED;
        Thu,  1 Aug 2019 10:23:46 +0100 (BST)
Date:   Thu, 1 Aug 2019 11:23:43 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     masonccyang@mxic.com.tw
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        juliensu@mxic.com.tw, lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, paul@crapouillou.net,
        paul.burton@mips.com, richard@nod.at, robh+dt@kernel.org,
        stefan@agner.ch, vigneshr@ti.com
Subject: Re: [PATCH v6 2/2] dt-bindings: mtd: Document Macronix raw NAND
 controller bindings
Message-ID: <20190801112343.0b770da0@collabora.com>
In-Reply-To: <OF42C4D3EC.9549E8DC-ON48258449.003273A5-48258449.00330A06@mxic.com.tw>
References: <1564631710-30276-1-git-send-email-masonccyang@mxic.com.tw>
        <1564631710-30276-3-git-send-email-masonccyang@mxic.com.tw>
        <20190801075725.4f23e0f5@collabora.com>
        <OF42C4D3EC.9549E8DC-ON48258449.003273A5-48258449.00330A06@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2019 17:17:29 +0800
masonccyang@mxic.com.tw wrote:

> Hi Boris,
> 
> > On Thu,  1 Aug 2019 11:55:10 +0800
> > Mason Yang <masonccyang@mxic.com.tw> wrote:
> >   
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
> > > +      reg = <0x43c30000 0x10000>;
> > > +      clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
> > > +      clock-names = "send", "send_dly", "ps";  
> > 
> > You should have subnodes describing the NAND connected to the
> > controller (see [1]).
> > 
> > [1]  
> https://elixir.bootlin.com/linux/v5.3-rc2/source/Documentation/devicetree/
> > bindings/mtd/nand-controller.yaml#L131
> >   
> > > +   };  
> >   
> 
> Do you mean to add patternProperties ?
> 
>                  nand: nand-controller@43c30000 {
>                                  compatible = 
> "mxicy,multi-itfc-v009-nand-morph";
>                                  reg = <0x43c30000 0x10000>;
>                                  clocks = <&clkwizard 0>, <&clkwizard 1>, 
> <&clkc 15>;
>                                  clock-names = "send", "send_dly", "ps";
> 

				#address-cells = <1>;
				#size-cells = <0>;

> +                               nand@0 {
> +
					reg = <0>;
					/* nand props here */

> +                               };
>                  };
> 
> something like that.

Yes, something like that.
