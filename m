Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6C7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBEA208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552058949;
	bh=Cq7V0LT/yRgABFq3DFUFSfbbt9chhLfrnKULUxGommo=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=qJcKfy6M8I5XLYuYMXF2v3EiWkGhT+097Hq+S1nVja0jTcS2ql4fwF3xz7sy8GEBm
	 iCx1j+hiboHe80Zd+0ZABq/ZvQ/0bSYXUbAGm6gJzx4pbki+aqTrfJMXnvsUC1cJnU
	 sU9SUmWzL2w+a2IsWs2fRKV/0x9MofwbIMsWjG4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCHP3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:29:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfCHP3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:29:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88B35208E4;
        Fri,  8 Mar 2019 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552058946;
        bh=Cq7V0LT/yRgABFq3DFUFSfbbt9chhLfrnKULUxGommo=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=H9SaaHdDVIz4Un1/QSob90griwlhnRIQLBpzlm8fl5U+/a260UQWO4VRPAoCod/zx
         ZfNS7P1RR0iSxOfmaooGwlCW6AoUXDE59YuVhp3fPVtbNeyW8hLzp1FWk1Xv9MXXd3
         Vpb5NbnaYro2aQFnnvzQSYk4XU/N6d1uC5tdggR0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190306130941.dqf3swx66bchm5k2@fsr-ub1664-175>
References: <1551779342-2640-1-git-send-email-abel.vesa@nxp.com> <155181110921.20095.1641360339603928947@swboyd.mtv.corp.google.com> <20190306130941.dqf3swx66bchm5k2@fsr-ub1664-175>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: imx8mq: Fix numbering overlaps and gaps
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Patrick Wildt <patrick@blueri.se>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Message-ID: <155205894567.20095.2782332899458282059@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 08 Mar 2019 07:29:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-03-06 05:09:42)
> On 19-03-05 10:38:29, Stephen Boyd wrote:
> > Quoting Abel Vesa (2019-03-05 01:49:16)
> > > IMX8MQ_CLK_USB_PHY_REF changes from 163 to 153, this way removing the=
 gap.
> > > All the following clock ids are now decreased by 10 to keep the numbe=
ring
> > > right. Doing this, the IMX8MQ_CLK_CSI2_CORE is not overlapped with
> > > IMX8MQ_CLK_GPT1 anymore. IMX8MQ_CLK_GPT1_ROOT changes from 193 to 183=
 and
> > > all the following ids are updated accordingly.
> >=20
> > Why do the numbers need to be consecutive? This looks difficult to merge
> > given that the commit that's being "fixed" is in v5.0 and thus the
> > integer value of these defines is pretty much an ABI. So if there are
> > holes in the space, I suggest we leave them there unless something is
> > really wrong or unworkable with that solution.
> >=20
>=20
> I would've ignored it but there are a few overlaps.
>=20
> #define IMX8MQ_CLK_GPT1                        170
> overlaps with:
> #define IMX8MQ_CLK_CSI2_CORE           170
>=20
> #define IMX8MQ_CLK_CSI2_PHY_REF                181
> overlaps with:
> #define IMX8MQ_CLK_ECSPI3_ROOT                 181
>=20
> #define IMX8MQ_CLK_CSI2_ESC            182
> overlaps with:
> #define IMX8MQ_CLK_ENET1_ROOT                  182

Ok. Are any of the overlaps in use by dtbs right now?

>=20
> By removing the gaps, some of the overlaps are also removed.
>=20
> I can just get rid of the overlaps and keep the gaps if that makes it mor=
e ok
> for the stability of the ABI.

It's mostly about making sure that any existing dtbs don't have their
numbers shifted around. So hopefully any overlapping identifiers aren't
in use yet and then those ids can be changed while leaving the ones that
are in use how they are.

>=20
> > BTW, it would be great if the binding header was generated once and then
> > never changed again so that we don't have to spend time on these sorts
> > of patches in the future. Please try to fully describe each possible clk
> > that might be used with a particular binding instead of adding new clk
> > ids over time, especially if you have access to the silicon manufacturer
> > documentation and can easily figure out all the clks that are there
> > beforehand.
> >=20
>=20
> Here is an example of why this is not really doable: clk-sccg-pll.c.
> The original design was adding the intermediary clocks like:
>=20
> IMX8MQ_SYS1_PLL1_OUT       =20
> IMX8MQ_SYS1_PLL1_OUT_DIV   =20
> IMX8MQ_SYS1_PLL1_REF_DIV   =20
> IMX8MQ_SYS1_PLL2
> IMX8MQ_SYS1_PLL2_DIV =20
> IMX8MQ_SYS1_PLL2_OUT =20
>=20
> And these were just for SYS1_PLL. There are 2 more SYSx_PLL.
> Plus the DRAM_PLL, the VIDEO2_PLL and the AUDIO_PLL.
>=20
> Since the refactoring of clk-sccg-pll.c, these are not used anymore (or s=
hould
> not be used). So I would have to remove them, but as you said, it would b=
reak
> the ABI.

Why do you need to remove them? Why can't they just return an error if
some driver tries to get those clks after they shouldn't be use anymore?

> And this example goes even further with the fact that the PHY_27M
> and the mux between the PHY_27M and the OSC_27 are to be controlled by the
> display controller driver itself (at this point the PHY_27M is not yet up=
stream
> and I can't say for sure it will ever be). Basically, what this means is =
that=20
> the PHY_27M will have to be exposed as a standalone clock even if it is h=
idden
> behind a mux which has another clock that can provide the same rate. That
> is only because there is some difference in phase (AFAIU) between the OSC=
_27M
> and the PHY_27M, at the same rate. And this is just one example.

It sounds like these are two independent clks that could or couldn't be
exposed into the DT numberspace?

>=20
> Point being, there is no way of knowing beforehand what intermediary cloc=
ks
> are needed, even with the silicon manufacturer documentation, until the
> driver that makes use of a specific clock actually works.

I agree that we don't know what clks are needed beforehand, predicting
the future is hard, but that doesn't mean they can't be exposed into the
header file if they exist. It doesn't really matter if there are numbers
in there or not for clks that shouldn't be used. The provider and the
driver implementation need to make the decision to provide them or not
to the consumer drivers when they ask for them. It's perfectly valid for
new code to start failing those requests because "they shouldn't be
used". The header file (really the DT bindings) is the place that
decides what the numbers are and what they correspond to.
