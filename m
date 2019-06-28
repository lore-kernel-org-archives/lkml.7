Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C9C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4193320644
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfF1GtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:49:24 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:44851 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfF1GtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:49:23 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x5S6m1Tv035815;
        Fri, 28 Jun 2019 14:48:01 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id C8B2B7E87EA3F2CAB608;
        Fri, 28 Jun 2019 14:48:01 +0800 (CST)
In-Reply-To: <20190627192609.0965f6d5@xps13>
References: <1561443056-13766-1-git-send-email-masonccyang@mxic.com.tw> <1561443056-13766-3-git-send-email-masonccyang@mxic.com.tw> <20190627192609.0965f6d5@xps13>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        broonie@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, jianxin.pan@amlogic.com, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, paul@crapouillou.net, paul.burton@mips.com,
        richard@nod.at, stefan@agner.ch, vigneshr@ti.com
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: Document Macronix raw NAND controller
 bindings
MIME-Version: 1.0
X-KeepSent: FBD1710A:54AC467B-48258427:0023FCA3;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OFFBD1710A.54AC467B-ON48258427.0023FCA3-48258427.00255B71@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Fri, 28 Jun 2019 14:48:02 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/06/28 PM 02:48:01,
        Serialize complete at 2019/06/28 PM 02:48:01
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x5S6m1Tv035815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Miquel,

> > Document the bindings used by the Macronix raw NAND controller.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  .../devicetree/bindings/mtd/mxic-nand.txt          | 26 
++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 
Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/
> Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > new file mode 100644
> > index 0000000..3d198e4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > @@ -0,0 +1,26 @@
> > +Macronix Raw NAND Controller Device Tree Bindings
> > +-------------------------------------------------
> > +
> > +Required properties:
> > +- compatible: should be "mxic,raw-nand-ctlr"
> 
> I would prefer "macronix,nand-controller"

okay, will patch it.

> 
> > +- reg: should contain 1 entrie for the registers
> 
>                            entry
> 
> > +- reg-names: should contain "regs"
> 
> Not sure you need that?

for a base address of ctlr registers.

> 
> > +- interrupts: interrupt line connected to this NAND controller
> > +- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"
> > +- clocks: should contain 3 entries for the "ps_clk", "send_clk" and
> > +    "send_dly_clk" clocks
> 
> s/entries/phandles/ ?

?
as I know that kernel views the phandle values as device tree structure
information instead of device tree data and thus does not store them as
properties.


> 
> > +
> > +Example:
> > +
> > +   nand: mxic-nfc@43c30000 {
> > +      compatible = "mxic,raw-nand-ctlr";
> > +      reg = <0x43c30000 0x10000>;
> > +      reg-names = "regs";
> > +      clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
> > +      clock-names = "send_clk", "send_dly_clk", "ps_clk";
> > +
> > +      nand-ecc-mode = "soft";
> > +      nand-ecc-algo = "bch";
> > +      nand-ecc-step-size = <512>;
> > +      nand-ecc-strength = <8>;
> 
> The last 4 lines are probably not needed.

okay, will remove them.

thanks for your review.
best regards,
Mason


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

