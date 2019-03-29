Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2AFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFFE21871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553827539;
	bh=NhKqb7LAhcn7yuiQfzViWeTdXRAKGRz3BqSXfXWsFB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QuolwOUnaVLgrIOm0blinCelsUUBFiZqK7R5p9AitU87nl4HQ/9J9pjeadLmlN1vI
	 UaIMBwZU/y9Tb1Oud8l98sLLYFxjvC+FJg+8pnSatOoGXXQEn4IunHKYQb0l1+TKB5
	 +SFEYlLPJqg/vBJJ6Jhu5Me7Io0lqUHeWjBo65Bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbfC2Cpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfC2Cph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:45:37 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF9612183E;
        Fri, 29 Mar 2019 02:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553827536;
        bh=NhKqb7LAhcn7yuiQfzViWeTdXRAKGRz3BqSXfXWsFB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9JMz51+KKBfzBv5xG5mIh8KYNrTttJ/JlDh2v9nm5MqqVccnWNrdYomokIZkr4Bk
         2oy8HOetZUbYpnTIkD4oHuw6EOxM+4fns3yddJXev96k/EvJKhZF4wip9BHSMNMJRr
         KOpc+x5ynJzXk93VS2qIUvVGQu/2Sj+DB6WZ6g2Y=
Date:   Fri, 29 Mar 2019 10:44:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ARM: dts: imx50: Add Kobo Aura DTS
Message-ID: <20190329024449.GM12513@dragon>
References: <20190319152421.16179-1-j.neuschaefer@gmx.net>
 <20190319152421.16179-3-j.neuschaefer@gmx.net>
 <20190322013151.GR12513@dragon>
 <20190326162653.GD2095@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190326162653.GD2095@latitude>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:26:53PM +0100, Jonathan Neuschäfer wrote:
> Hi, thanks for your comments. I'll address them in v2.
> 
> On Fri, Mar 22, 2019 at 09:31:53AM +0800, Shawn Guo wrote:
> > On Tue, Mar 19, 2019 at 04:24:17PM +0100, Jonathan Neuschäfer wrote:
> > > The Kobo Aura is an e-book reader released in 2013.
> [...]
> > > +	sd2_pwrseq: pwrseq {
> > > +		compatible = "mmc-pwrseq-simple";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_sd2_reset>;
> > > +
> > 
> > Please do not have random newlines.
> 
> Does that apply to all empty lines between properties?

Yes, that's what we do for i.MX device trees.

> 
> > 
> > > +		reset-gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
> > > +	};
> > > +
> [...]
> > > +&iomuxc {
> > > +	pinctrl_uart2: uart2 {
> > > +		fsl,pins = <
> > > +			MX50_PAD_UART2_TXD__UART2_TXD_MUX	0x1e4
> > > +			MX50_PAD_UART2_RXD__UART2_RXD_MUX	0x1e4
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_i2c1: i2c1 {
> > 
> > Please sort these pinctrl nodes alphabetically.
> 
> It doesn't make a difference here, but should I generally sort by name
> or by label in cases like this one?

Keep using the naming schema below, and it always makes no difference
then.

	pinctrl_xxx: xxx

Shawn
