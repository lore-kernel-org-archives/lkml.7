Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E19C5B54D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5089320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561668870;
	bh=Z5QvOd8pHIoUG6s1AirGhc9EeMrk127DpjRm00Mhy6I=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=WKeCtjux/wNm/sUTtrJe1qE59C+SoobUynrZ91+oFUYTc8s095BaaKavtVl4zZhuY
	 cadLjW8UhAZ0DjrumxbkfYHI7cOByinS4uCS+Hl/theWsu/2PKd9JifVXMxieDA997
	 IifVSvAWJmplyuqF8N85NiZX95i3DPTN8eIQAKkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfF0Uy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfF0Uy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:54:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3482075E;
        Thu, 27 Jun 2019 20:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561668867;
        bh=Z5QvOd8pHIoUG6s1AirGhc9EeMrk127DpjRm00Mhy6I=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=Ux339EseDEG1zm6ub2l6+3BbhXcfiuwMj1t2rRtTs4cE6zE2CrXKO0Zdc38l8Scvt
         ia5++5ZaF7MzNbWgMk6OtSadeV51ZISQD4U7Lwznl4IkeIC3a+6eiwWCFlUE7+Vd4x
         XqrHjQpfE9bwP7aqGk+3SnZYwqAqgZB/P4DyT9f0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <61fae574-2cea-cbdc-bc8a-3cc34c681d01@topic.nl>
References: <20190424090216.18417-1-mike.looijmans@topic.nl> <155623344648.15276.18213024444708122458@swboyd.mtv.corp.google.com> <3ea2d720-f49b-586c-e402-07db289b39a8@topic.nl> <155632584222.168659.9675557812377718927@swboyd.mtv.corp.google.com> <cd52a35b-d289-24e1-70db-9d63fd9f6448@topic.nl> <155658342800.168659.4922821141203707564@swboyd.mtv.corp.google.com> <c7f5184f-f484-e8ad-33ae-36b0da061113@topic.nl> <20190626212409.9C0E6208E3@mail.kernel.org> <61fae574-2cea-cbdc-bc8a-3cc34c681d01@topic.nl>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: Add silabs,si5341
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 13:54:26 -0700
Message-Id: <20190627205427.5C3482075E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2019-06-27 04:38:16)
> On 26-06-19 23:24, Stephen Boyd wrote:
> > Sorry, I'm getting through my inbox pile and saw this one.
> >=20
> > Quoting Mike Looijmans (2019-04-30 22:46:55)
> >> On 30-04-19 02:17, Stephen Boyd wrote:
> >>>
> >>> Why can't that driver call clk_prepare_enable()? Is there some sort of
> >>> assumption that this clk will always be enabled and not have a driver
> >>> that configures the rate and gates/ungates it?
> >>
> >> Not only clk_prepare_enable(), but the driver could also call clk_set_=
rate()
> >> and clk_set_parent() and the likes, but it doesn't, so that's why ther=
e is
> >> "assigned-clocks" right?
> >>
> >> There are multiple scenario's, similar to why regulators also have pro=
perties
> >> like these.
> >>
> >> - The clock is related to hardware that the kernel is not aware of.
> >> - The clock is for a driver that isn't aware of its clock requirements=
. It
> >> might be an extra clock for an FPGA implemented controller that mimics
> >> existing hardware.
> >=20
> > Are these hypothetical scenarios or actual scenarios you need to
> > support?
>=20
> Actual scenario's.
>=20
> Clocks are required for FPGA logic, and a some of those do not involve=20
> software drivers at all.
>=20
> The GTR transceivers on the Xilinx ZynqMP chips use these clocks for SATA=
 and=20
> PCIe, but the driver implementation from Xilinx for these is far from mat=
ure,=20
> for example it passes the clock frequency as a PHY parameter and isn't ev=
en=20
> aware of the clk framework at the moment. Xilinx hasn't even attempted=20
> submitting this 3 year old driver to mainline.

I think they may have submitted the "fixed rate from PHY parameter"
support. I merged it because I suspected it would help in those rare
cases where an MMIO register is used to express information about the
configuration and the bootloader does nothing to help create a fixed
rate clk in DT.

> >=20
> > To put it another way, I'm looking to describe how the board is designed
> > and to indicate that certain clks are always enabled at power on or are
> > enabled by the bootloader. Configuration has it's place too, just that
> > configuration is a oneshot sort of thing that never needs to change at
> > runtime.
> >=20
>=20
> I can see where you going with this, and yes, we definitely should promot=
e=20
> that drivers should take care of their clock (enable) requirements.
>=20
> For the case of 'clock-critical', that would serve the purpose quite well=
=20
> indeed. It does add the risk of people sprinkling that all over the devic=
etree.
>=20
> Short term, I guess the best thing to do here is to remove the "always-on=
"=20
> property from my patch.

Ok. Will you resend or should I look at the latest binding patch and
remove always-on? I don't see it there so maybe everything is fine.

>=20
> I'll put the "clock-critical" idea on my list of generic clock patches to=
=20
> sneak in on other budgets, it'll be right behind "allow sub-1Hz or fracti=
onal=20
> clock rate accuracy" (yes I actually have a use case for that) and "allow=
=20
> frequencies over 4GHz" (the 14GHz clock in the Si5341 luckily isn't avail=
able=20
> on the outside so I can cheat)...

Ok. Good to know it's not as high a priority as these other things.

