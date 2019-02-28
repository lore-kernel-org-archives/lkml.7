Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669EAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C86D2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551336229;
	bh=wndOF3hxQ8k75sl5B2xgQsDmYmj22Q/zCD7HsxymWTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CFub36+jlPHirf1fvu2/CRr5DU62iX6rdiOceegU03p3ny8Qn7oJ8HTFT8+Yjp2RK
	 EBm47Jj3JVgjP4v8tKXsTJlX2hH5mGD0F2KmBYLyG2FDYMS8Wn01FPJ625zks2F9SZ
	 kT0BKqdEbTTpqqNlYE1reG2QYx1WA6bjO8NdH/j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfB1Gnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbfB1Gnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:43:47 -0500
Received: from dragon (unknown [139.162.86.229])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C9A92184A;
        Thu, 28 Feb 2019 06:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551336225;
        bh=wndOF3hxQ8k75sl5B2xgQsDmYmj22Q/zCD7HsxymWTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6+4/DmaXwRp143MJx/2ukgI+6a63LVSeNJxHWLPwUkeleIlgiFiyYLl6FmEMO8Xt
         uGscn9OeiNLeAipjNllRTDXhwbDXld6+vSeBd9OM1JisiL3L9/g6oLXmg33SI2NHHt
         aMgFfkHFx6zPEFQnfkx/q490cyyG4xPhCYF4zxHQ=
Date:   Thu, 28 Feb 2019 14:42:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V7 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Message-ID: <20190228064247.GI26041@dragon>
References: <1551157967-30925-1-git-send-email-Anson.Huang@nxp.com>
 <20190228031832.GH26041@dragon>
 <AM6PR0402MB3911278158F4980C83331B40F5750@AM6PR0402MB3911.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR0402MB3911278158F4980C83331B40F5750@AM6PR0402MB3911.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 06:18:30AM +0000, Anson Huang wrote:
> Hi, Shawn
> 
> Best Regards!
> Anson Huang
> 
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawnguo@kernel.org]
> > Sent: 2019年2月28日 11:19
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: robh+dt@kernel.org; mark.rutland@arm.com; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; mturquette@baylibre.com;
> > sboyd@kernel.org; Aisheng Dong <aisheng.dong@nxp.com>; Daniel Baluta
> > <daniel.baluta@nxp.com>; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > clk@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH V7 1/2] arm64: dts: freescale: imx8qxp: add cpu opp
> > table
> > 
> > On Tue, Feb 26, 2019 at 05:17:31AM +0000, Anson Huang wrote:
> > > Add i.MX8QXP CPU opp table to support cpufreq.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > Prefix 'arm64: dts: imx8qxp: ' would already be clear enough.  I dropped
> > 'freescale' from there and applied patch.
> > 
> > > ---
> > > No changes since V6.
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 30
> > > ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > index 4c3dd95..41bf0ce 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > @@ -34,6 +34,9 @@
> > >  			reg = <0x0 0x0>;
> > >  			enable-method = "psci";
> > >  			next-level-cache = <&A35_L2>;
> > > +			clocks = <&clk IMX_A35_CLK>;
> > > +			operating-points-v2 = <&a35_0_opp_table>;
> > > +			#cooling-cells = <2>;
> > >  		};
> > >
> > >  		A35_1: cpu@1 {
> > > @@ -42,6 +45,9 @@
> > >  			reg = <0x0 0x1>;
> > >  			enable-method = "psci";
> > >  			next-level-cache = <&A35_L2>;
> > > +			clocks = <&clk IMX_A35_CLK>;
> > > +			operating-points-v2 = <&a35_0_opp_table>;
> > > +			#cooling-cells = <2>;
> > >  		};
> > >
> > >  		A35_2: cpu@2 {
> > > @@ -50,6 +56,9 @@
> > >  			reg = <0x0 0x2>;
> > >  			enable-method = "psci";
> > >  			next-level-cache = <&A35_L2>;
> > > +			clocks = <&clk IMX_A35_CLK>;
> > > +			operating-points-v2 = <&a35_0_opp_table>;
> > > +			#cooling-cells = <2>;
> > >  		};
> > >
> > >  		A35_3: cpu@3 {
> > > @@ -58,6 +67,9 @@
> > >  			reg = <0x0 0x3>;
> > >  			enable-method = "psci";
> > >  			next-level-cache = <&A35_L2>;
> > > +			clocks = <&clk IMX_A35_CLK>;
> > > +			operating-points-v2 = <&a35_0_opp_table>;
> > > +			#cooling-cells = <2>;
> > >  		};
> > >
> > >  		A35_L2: l2-cache0 {
> > > @@ -65,6 +77,24 @@
> > >  		};
> > >  	};
> > >
> > > +	a35_0_opp_table: opp-table {
> > 
> > What does the '0' in the label mean?
> 
> Looks like the '0' in the label is NOT necessary, we can just use 'a35_opp_table',
> do you want me resend the patch to remove '0'?

No.  I just fixed it up and applied the patch.

Shawn
