Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA42C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7FE21BF6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfGWD2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:28:13 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:20448 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfGWD2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:28:13 -0400
Received: from twhfmlp1.macronix.com (twhfm1p1.macronix.com [172.17.20.91])
        by TWHMLLG3.macronix.com with ESMTP id x6N3QSlo003193;
        Tue, 23 Jul 2019 11:26:28 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.mxic.com.tw [172.17.14.55])
        by Forcepoint Email with ESMTP id 1A5EFAD7BC06911158C9;
        Tue, 23 Jul 2019 11:26:28 +0800 (CST)
In-Reply-To: <20190722234614.GA11971@bogus>
References: <1562138144-2212-1-git-send-email-masonccyang@mxic.com.tw> <1562138144-2212-3-git-send-email-masonccyang@mxic.com.tw> <20190722234614.GA11971@bogus>
To:     "Rob Herring" <robh@kernel.org>
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        juliensu@mxic.com.tw, lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, paul@crapouillou.net,
        paul.burton@mips.com, richard@nod.at, stefan@agner.ch,
        vigneshr@ti.com
Subject: Re: [PATCH v5 2/2] dt-bindings: mtd: Document Macronix raw NAND controller
 bindings
MIME-Version: 1.0
X-KeepSent: 10139C27:59024E84-48258440:00113398;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF10139C27.59024E84-ON48258440.00113398-48258440.0012E6FA@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Tue, 23 Jul 2019 11:26:27 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/07/23 AM 11:26:28,
        Serialize complete at 2019/07/23 AM 11:26:28
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG3.macronix.com x6N3QSlo003193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,


> 
> Re: [PATCH v5 2/2] dt-bindings: mtd: Document Macronix raw NAND 
controller bindings
> 
> On Wed, Jul 03, 2019 at 03:15:44PM +0800, Mason Yang wrote:
> > Document the bindings used by the Macronix raw NAND controller.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  Documentation/devicetree/bindings/mtd/mxic-nand.txt | 20 
++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 
Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/
> Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > new file mode 100644
> > index 0000000..ddd7660
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> > @@ -0,0 +1,20 @@
> > +Macronix Raw NAND Controller Device Tree Bindings
> > +-------------------------------------------------
> > +
> > +Required properties:
> > +- compatible: should be "macronix,nand-controller"
> 
> That's not very specific. There's only 1 version of this h/w?

okay, will give it a apposite name.

> 
> > +- reg: should contain 1 entrie for the registers
> 
> s/entrie/entry/

will fix it.

> 
> > +- interrupts: interrupt line connected to this raw NAND controller
> > +- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"
> > +- clocks: should contain 3 phandles for the "ps_clk", "send_clk" and
> > +    "send_dly_clk" clocks
> 
> You can drop '_clk' as that is redundant.

okay, got it.

> 
> > +
> > +Example:
> > +
> > +   nand: mxic-nfc@43c30000 {
> > +      compatible = "macronix,nand-controller";
> > +      reg = <0x43c30000 0x10000>;
> > +      reg-names = "regs";
> 
> Not documented. You can drop as *-names is not generally useful when 
> there is only 1 entry.

okay, will fix it.

> 
> > +      clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
> > +      clock-names = "send_clk", "send_dly_clk", "ps_clk";
> > +   };
> > -- 
> > 1.9.1
> > 

thanks for your time & review.
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

