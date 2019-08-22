Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3AEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E5C2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388553AbfHVSXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:23:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38588 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfHVSXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:23:30 -0400
Received: from wsip-184-188-36-2.sd.sd.cox.net ([184.188.36.2] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i0rjo-0001eW-0S; Thu, 22 Aug 2019 20:23:08 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     Manish Narani <MNARANI@xilinx.com>, Rob Herring <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "christoph.muellner@theobroma-systems.com" 
        <christoph.muellner@theobroma-systems.com>,
        "philipp.tomsich@theobroma-systems.com" 
        <philipp.tomsich@theobroma-systems.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "ayaka@soulik.info" <ayaka@soulik.info>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "tony.xie@rock-chips.com" <tony.xie@rock-chips.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation for SD Card Clock
Date:   Thu, 22 Aug 2019 20:23:01 +0200
Message-ID: <4911073.ucheZMAtV3@phil>
In-Reply-To: <CAPDyKFqdLE7d9uz_KcpO0CihM+QsFyKbNsoDMoNLT2Qy_TmNdw@mail.gmail.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com> <MN2PR02MB60299EB8B83C4EA68A0F2B33C1A80@MN2PR02MB6029.namprd02.prod.outlook.com> <CAPDyKFqdLE7d9uz_KcpO0CihM+QsFyKbNsoDMoNLT2Qy_TmNdw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 22. August 2019, 15:38:26 CEST schrieb Ulf Hansson:
> [...]
> 
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15
> > > ++++++++++-
> > > > > ----
> > > > > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > > > index 1edbb04..15c6397 100644
> > > > > > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > > > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > > > @@ -23,6 +23,10 @@ Required Properties:
> > > > > >    - reg: From mmc bindings: Register location and length.
> > > > > >    - clocks: From clock bindings: Handles to clock inputs.
> > > > > >    - clock-names: From clock bindings: Tuple including "clk_xin" and
> > > "clk_ahb"
> > > > > > +            Apart from these two there is one more optional clock which
> > > > > > +            is "clk_sdcard". This clock represents output clock from
> > > > > > +            controller and card. This must be specified when #clock-cells
> > > > > > +            is specified.
> > > > > >    - interrupts: Interrupt specifier
> > > > > >
> > > > > >  Required Properties for "arasan,sdhci-5.1":
> > > > > > @@ -36,9 +40,10 @@ Optional Properties:
> > > > > >    - clock-output-names: If specified, this will be the name of the card
> > > clock
> > > > > >      which will be exposed by this device.  Required if #clock-cells is
> > > > > >      specified.
> > > > > > -  - #clock-cells: If specified this should be the value <0>.  With this
> > > property
> > > > > > -    in place we will export a clock representing the Card Clock.  This clock
> > > > > > -    is expected to be consumed by our PHY.  You must also specify
> > > > > > +  - #clock-cells: If specified this should be the value <0>. With this
> > > > > > +    property in place we will export one clock representing the Card
> > > > > > +    Clock. This clock is expected to be consumed by our PHY. You must
> > > also
> > > > > > +    specify
> > > > >
> > > > > specify what?
> > > > I think this line was already there, I missed to correct it, Will update in v3.
> > > >
> > > > >
> > > > > The 3rd clock input I assume? This statement means any existing users
> > > > > with 2 clock inputs and #clock-cells are in error now. Is that correct?
> > > > Yes, this is correct. So far there was only one vendor using '#clock-cells'
> > > which is Rockchip. I have sent DT patch (02/11) for that also.
> > > > Here this is needed as earlier implementation isn't correct as suggested by
> > > Uffe. (https://lkml.org/lkml/2019/6/20/486) .
> > >
> > > I am not sure how big of a problem the backwards compatible thingy
> > > with DT is, in general we must not break it. What do you say Manish?
> >
> > Though I agree with Uffe on this, there is no other way from my understanding. Please suggest.
> >
> > >
> > > As a workaround, would it be possible to use
> > > of_clk_get_from_provider() somehow to address the compatibility issue?
> >
> > For this to be used we have to parse 'clkspec' from the DT node and pass the same as an argument to this function. In this case also the DT node needs to be updated, which is same as we have done in this series.
> 
> Alright. I guess breaking DTBs for Rockchip platforms isn't
> acceptable, especially if those are already widely deployed, which I
> have no idea of....

The arasan sdhci is part of the rk3399, so every SBC using that SoC, but
also the whole Gru series of ChromeOS devices (Samsung Chromebook Plus
among them) would be affected.

Heiko


