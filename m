Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9192CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A2021A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571943854;
	bh=BLF6bNI1LMtwSe4KBH8lI9gpwa1CAzLQZtAXBhg/Zeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QJYqS5pz9tqV39gAzu1pL0DkztXSrVmdYybqI0UEaS1F5Y1O5nHFCMryQQZgrZyMw
	 UkBe87mVn6uNdurFq9j4jm/GkACODdG42JebWoN7hFke3So7OtHG92BYxAlQAFfJX/
	 VnwPEMGglZSxuqIfq+9MZhRNkrhO5OkjV7i/zU8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504416AbfJXTEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392896AbfJXTEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:04:13 -0400
Received: from localhost (unknown [109.190.253.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B01A21A4A;
        Thu, 24 Oct 2019 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571943851;
        bh=BLF6bNI1LMtwSe4KBH8lI9gpwa1CAzLQZtAXBhg/Zeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkTv/uGKp2Ko24fnOFRYlxw3fOz+rJ/zpy+ay3PCdOr6dljJzXalGBW/IY3+Sh4hL
         ZHOWCerCbnV2Qh5nnsg5KeRQFfDkLn9qByozVmo20BVKP/rDjDFq0c/zH514KPQ7NO
         Cfb6oa5WQR+YTrQMDIs/O1AAzoZU+1E2jnQNot1E=
Date:   Thu, 24 Oct 2019 20:28:49 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v10 5/6] arm64: dts: allwinner: a64: Add MIPI DSI pipeline
Message-ID: <20191024182849.3oifqjl553twxwq4@hendrix>
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
 <20191005141913.22020-6-jagan@amarulasolutions.com>
 <20191007105708.raxavxk4n7bvxh7x@gilmour>
 <CAMty3ZCiwOGgwbsjTHvEZhwHGhsgb6_FeBs9hHgLai9=rV2_HQ@mail.gmail.com>
 <20191016080306.44pmo3rfmtnkgosq@gilmour>
 <CAMty3ZCTE=W+TNRvdowec-eYB625j97uG8F3fzVMtRFsKsqFFQ@mail.gmail.com>
 <20191017095225.ntx647ivegaldlyf@gilmour>
 <CAMty3ZDYcwJ4XMm45BLjXnvPXeu-rMAiN5v=CDhvuLsAm5tf=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZDYcwJ4XMm45BLjXnvPXeu-rMAiN5v=CDhvuLsAm5tf=Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 06:26:36PM +0530, Jagan Teki wrote:
> On Thu, Oct 17, 2019 at 3:22 PM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Wed, Oct 16, 2019 at 02:19:44PM +0530, Jagan Teki wrote:
> > > On Wed, Oct 16, 2019 at 1:33 PM Maxime Ripard <mripard@kernel.org> wrote:
> > > >
> > > > On Mon, Oct 14, 2019 at 05:37:50PM +0530, Jagan Teki wrote:
> > > > > On Mon, Oct 7, 2019 at 4:27 PM Maxime Ripard <mripard@kernel.org> wrote:
> > > > > >
> > > > > > On Sat, Oct 05, 2019 at 07:49:12PM +0530, Jagan Teki wrote:
> > > > > > > Add MIPI DSI pipeline for Allwinner A64.
> > > > > > >
> > > > > > > - dsi node, with A64 compatible since it doesn't support
> > > > > > >   DSI_SCLK gating unlike A33
> > > > > > > - dphy node, with A64 compatible with A33 fallback since
> > > > > > >   DPHY on A64 and A33 is similar
> > > > > > > - finally, attach the dsi_in to tcon0 for complete MIPI DSI
> > > > > > >
> > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 38 +++++++++++++++++++
> > > > > > >  1 file changed, 38 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > > > > index 69128a6dfc46..ad4170b8aee0 100644
> > > > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > > > > > @@ -382,6 +382,12 @@
> > > > > > >                                       #address-cells = <1>;
> > > > > > >                                       #size-cells = <0>;
> > > > > > >                                       reg = <1>;
> > > > > > > +
> > > > > > > +                                     tcon0_out_dsi: endpoint@1 {
> > > > > > > +                                             reg = <1>;
> > > > > > > +                                             remote-endpoint = <&dsi_in_tcon0>;
> > > > > > > +                                             allwinner,tcon-channel = <1>;
> > > > > > > +                                     };
> > > > > > >                               };
> > > > > > >                       };
> > > > > > >               };
> > > > > > > @@ -1003,6 +1009,38 @@
> > > > > > >                       status = "disabled";
> > > > > > >               };
> > > > > > >
> > > > > > > +             dsi: dsi@1ca0000 {
> > > > > > > +                     compatible = "allwinner,sun50i-a64-mipi-dsi";
> > > > > > > +                     reg = <0x01ca0000 0x1000>;
> > > > > > > +                     interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > +                     clocks = <&ccu CLK_BUS_MIPI_DSI>;
> > > > > > > +                     clock-names = "bus";
> > > > > >
> > > > > > This won't validate with the bindings you have either here, since it
> > > > > > still expects bus and mod.
> > > > > >
> > > > > > I guess in that cas, we can just drop clock-names, which will require
> > > > > > a bit of work on the driver side as well.
> > > > >
> > > > > Okay.
> > > > > mod clock is not required for a64, ie reason we have has_mod_clk quirk
> > > > > patch. Adjust the clock-names: on dt-bindings would make sense here,
> > > > > what do you think?
> > > >
> > > > I'm confused, what are you suggesting?
> > >
> > > Sorry for the confusion.
> > >
> > > The mod clock is not required for A64 and we have a patch for handling
> > > mod clock using has_mod_clk quirk(on the series), indeed the mod clock
> > > is available in A31 and not needed for A64. So, to satisfy this
> > > requirement the clock-names on dt-bindings can update to make mod
> > > clock-name is optional and bus clock is required.
> >
> > No, the bus clock name is not needed if there's only one clock.
>
> Looks like we need "bus" clock required since the
> devm_regmap_init_mmio_clk is created only if bus clock-names added in
> dt.

Yeah, hence why I said you'd need "a bit of work on the driver side"

Replacing the clock name by NULL should work.

Maxime
