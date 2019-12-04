Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC8DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632552073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575424968;
	bh=6JGhp6hKDiAgsLbhCIIDGicEe/fmHWv0q/ZPw2vNp+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fco/hhGwC/xQoKxCfkJVTEqz2rBGs6Oje90Abk8iJg/E172TzsZNGpyAJN4QAauRn
	 9tUBiy0RFH2m9Lt9giW6rdi1yV8xdTgWa3ZmdHRqhekvq4sEW2KfEjSq+Y6sY8gnP/
	 cnuFzUV7aGVnw73+JDqbBRs1WoiKaOmARj26uwPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLDCCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:02:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfLDCCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:02:47 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741A12073B;
        Wed,  4 Dec 2019 02:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575424966;
        bh=6JGhp6hKDiAgsLbhCIIDGicEe/fmHWv0q/ZPw2vNp+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FVULFVOJUSyS1NR+SsbcWjV/cv/rpuOIfNNYzZ1AqVWzoEQ0JkJnLjeIWr9IERPD1
         dyI50ic2/u/Yfe/DBB/sqpLyva1fXVdKr96EhJesB8b51fHFzm4vyZS0uku63DKfmF
         Xeg2R4CQpaZTRrc/a2kLPqoV95VFdaO7p5fJrqPo=
Date:   Wed, 4 Dec 2019 10:02:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: dts: imx7ulp: Add cpu clock-frequency property
Message-ID: <20191204020236.GK9767@dragon>
References: <1572918578-13544-1-git-send-email-Anson.Huang@nxp.com>
 <20191202134748.GB21897@dragon>
 <DB3PR0402MB39164DF380E6B13558E758E7F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39164DF380E6B13558E758E7F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Vincent

On Tue, Dec 03, 2019 at 01:09:22AM +0000, Anson Huang wrote:
> 
> > Subject: Re: [PATCH] ARM: dts: imx7ulp: Add cpu clock-frequency property
> > 
> > On Tue, Nov 05, 2019 at 09:49:38AM +0800, Anson Huang wrote:
> > > Add "clock-frequency" property to avoid below warning on i.MX7ULP:
> > >
> > > [    0.011762] /cpus/cpu@0 missing clock-frequency property
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  arch/arm/boot/dts/imx7ulp.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm/boot/dts/imx7ulp.dtsi
> > > b/arch/arm/boot/dts/imx7ulp.dtsi index d37a192..87b2237 100644
> > > --- a/arch/arm/boot/dts/imx7ulp.dtsi
> > > +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> > > @@ -41,6 +41,7 @@
> > >  			compatible = "arm,cortex-a7";
> > >  			device_type = "cpu";
> > >  			reg = <0>;
> > > +			clock-frequency = <500210526>;
> > 
> > I cannot find the binding doc for this property.  What is the definition of it,
> > the maximum frequency that the cpu could possibly run at?
> 
> 
> The code is as below, maybe the property is missing from the beginning of this code,
> this property should mean the current frequency of CPU running at I think:
> 
> arch/arm/kernel/topology.c
> 
> 122                 rate = of_get_property(cn, "clock-frequency", &len);
> 123                 if (!rate || len != 4) {
> 124                         pr_err("%pOF missing clock-frequency property\n", cn);
> 125                         continue;
> 126                 }

Yes, I can find the code, but not bindings for it.  Considering
frequency of a CPU can be scaled in a quite wide range, we need
a clear understanding on this property.  IIUIC, the property is used to
calculate the capacity of CPU, it should be the maximum frequency the
CPU could possibly scale to?

Shawn
