Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6CBC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20EF2072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgAFNmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:42:12 -0500
Received: from foss.arm.com ([217.140.110.172]:44184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgAFNmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:42:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0C99328;
        Mon,  6 Jan 2020 05:42:11 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BC153F534;
        Mon,  6 Jan 2020 05:42:10 -0800 (PST)
Date:   Mon, 6 Jan 2020 13:42:07 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v2] ARM: dts: sun8i: R40: Add SPI controllers nodes and
 pinmuxes
Message-ID: <20200106134207.3088a74a@donnerap.cambridge.arm.com>
In-Reply-To: <CAGb2v65=iJzPJneUF=e9Xsqj_ufhuZtr5javN5YNKtaApGq2zA@mail.gmail.com>
References: <20200106003849.16666-1-andre.przywara@arm.com>
        <20200106085613.mxe33t7eklj3aeld@gilmour.lan>
        <CAGb2v65=iJzPJneUF=e9Xsqj_ufhuZtr5javN5YNKtaApGq2zA@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020 21:37:38 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

Hi,

> On Mon, Jan 6, 2020 at 4:56 PM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Mon, Jan 06, 2020 at 12:38:49AM +0000, Andre Przywara wrote:  
> > > The Allwinner R40 SoC contains four SPI controllers, using the newer
> > > sun6i design (but at the legacy addresses).
> > > The controller seems to be fully compatible to the A64 one, so no driver
> > > changes are necessary.
> > > The first three controllers can be used on two sets of pins, but SPI3 is
> > > only routed to one set on Port A.
> > > Only the pin groups for SPI0 on PortC and SPI1 on PortI are added here,
> > > because those seem to be the only one exposed on the Bananapi boards.
> > >
> > > Tested by connecting a SPI flash to a Bananapi M2 Berry SPI0 and SPI1
> > > header pins.
> > >
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>  
> >
> > Applied, thanks!
> > Maxime  
> 
> Looks like this patch doesn't build. The SPI device nodes reference
> a non-existent DMA node.

Argh, shoot, sorry for that. Looks like a rebase artefact (I originally had the DMA controller in, but then saw that this is actually not used by the SPI driver, so removed it).

Thanks for testing!

Maxime, shall I send a fixup or redo the patch?

Cheers,
Andre
