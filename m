Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14CBC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC6B206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403815AbfIZGmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:42:49 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36474 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730840AbfIZGms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 02:42:48 -0400
X-UUID: 87a7eb932c434a26b6a2752212b3a60c-20190926
X-UUID: 87a7eb932c434a26b6a2752212b3a60c-20190926
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1732559118; Thu, 26 Sep 2019 14:42:38 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 26 Sep
 2019 14:42:31 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 26 Sep 2019 14:42:31 +0800
Message-ID: <1569480152.32135.16.camel@mhfsdcap03>
Subject: Re: [PATCH 4/5] dt-bindings: usb: dwc3: of-simple: add compatible
 for HiSi
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     John Stultz <john.stultz@linaro.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yu Chen <chenyu56@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Date:   Thu, 26 Sep 2019 14:42:32 +0800
In-Reply-To: <CALAqxLX=csTtnqr2Hc9v_R8ex8zPj_P1JvSyjZXUKEqSaF=gPA@mail.gmail.com>
References: <20190925234224.95216-1-john.stultz@linaro.org>
         <20190925234224.95216-5-john.stultz@linaro.org>
         <1569461658.32135.12.camel@mhfsdcap03>
         <CALAqxLX=csTtnqr2Hc9v_R8ex8zPj_P1JvSyjZXUKEqSaF=gPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: E0897C00FF5A48C643B6E3A0CCD82EB91C0B8C7106D547DC0ED3E419E52155B12000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-25 at 21:06 -0700, John Stultz wrote:
> On Wed, Sep 25, 2019 at 6:34 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > On Wed, 2019-09-25 at 23:42 +0000, John Stultz wrote:
> > > +++ b/Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> > > @@ -0,0 +1,52 @@
> > > +HiSi SuperSpeed DWC3 USB SoC controller
> > > +
> > > +Required properties:
> > > +- compatible:                should contain "hisilicon,hi3660-dwc3" for HiSi SoC
> > > +- clocks:            A list of phandle + clock-specifier pairs for the
> > > +                     clocks listed in clock-names
> > > +- clock-names:               Should contain the following:
> > > +  "clk_usb3phy_ref"  Phy reference clk
> > It's not good idea to apply phy's clock in dwc3's node
> 
> Hey! Thanks for taking a look at this!
> 
> So first, my apologies, I'm not the driver author and I don't have any
> real specs on the hardware other then what's in the source tree I'm
> working on.  Not the ideal person to be documenting the binding, but I
> realized we still needed some binding documentation (although a few
> other dwc-of-simple compat entries are undocumented), so this is my
> rough stab at it. :/
> 
> Given the name clk_usb3phy_ref I'm assuming its a phy reference clock,
> but I honestly don't know if I'm getting that wrong.  It all seems to
> be leveraging the fact that the dwc-of-simple driver batch enables and
> disables all the clocks w/o really looking at the names.
> 
> Do you have a recommendation for what would be best here? I suspect
> it's necessary to enable/disable the clk in a similar path(though I'm
> unfortunately traveling this week so I can't validate that). Do I try
> to move the clk_usb3phy_ref clock enable/disable handling to somewhere
> else?
If it's phy clock, we should enable/disable it in phy driver, maybe we'd
better ask for help from Yu Chen

> 
> thanks
> -john


