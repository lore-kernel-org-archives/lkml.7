Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F12C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFA720856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfDAOam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:30:42 -0400
Received: from muru.com ([72.249.23.125]:43690 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfDAOal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:30:41 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 71FC580C0;
        Mon,  1 Apr 2019 14:30:54 +0000 (UTC)
Date:   Mon, 1 Apr 2019 07:30:37 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     s-anna@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org,
        t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, david@lechnology.com,
        woods.technical@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM: dts: dra7: add PRU-ICSS modules
Message-ID: <20190401143036.GF49658@atomide.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-4-git-send-email-rogerq@ti.com>
 <20190204180359.GM5720@atomide.com>
 <454fbfc1-e05b-494e-6e27-0945ebed0154@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454fbfc1-e05b-494e-6e27-0945ebed0154@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190329 14:02]:
> Hi Tony,
> 
> On 04/02/2019 20:03, Tony Lindgren wrote:
> > * Roger Quadros <rogerq@ti.com> [190204 15:54]:
> >> --- a/arch/arm/boot/dts/dra7.dtsi
> >> +++ b/arch/arm/boot/dts/dra7.dtsi
> >> @@ -167,6 +167,200 @@
> >>  		l4_per3: interconnect@48800000 {
> >>  		};
> >>  
> >> +		pru_icss1: target-module@4b200000 {
> > 
> > I suggest you add these into dra7-pruss.dtsi as they
> > have internal interconnects. And eventually some of
> > the *pruss.dtsi files might become shared :) And we
> > avoid moving these around when we define the l3
> > interconnects and avoid a lot of extra long dtsi
> > line lengths with the added nestedness later on.
> 
> PRUSS is only present on AM57x variants.
> I will move this to am57x-pruss.dtsi.
> 
> This means all AM57x boards will have to include it.
> 
> Is this OK?

Sure sounds good to me.

Regards,

Tony
