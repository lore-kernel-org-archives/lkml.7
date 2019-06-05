Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E2CC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC8F20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559714423;
	bh=su8k6bM1KzrD1rvDqDrPDiZKbk24uNLXNFln/Ozpo1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AFsotn5UQd/ecEsN1J51LdK4mb4RhbBbtWr2eIFahDSDIlP3El2h5Wi8cnCT8gKtl
	 8YGzTZTxmmRY5Xsg39qQbfgZrOWnCrTKdrlQtqZ+trjeVlVNdlS5tTkaB4sjfm6gYf
	 XE2bzdxP6edOnVi3RtyCSFqEJafYn/tMH6LOnlxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfFEGAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfFEGAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:00:22 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABB3F2075B;
        Wed,  5 Jun 2019 06:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559714421;
        bh=su8k6bM1KzrD1rvDqDrPDiZKbk24uNLXNFln/Ozpo1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXHukabfHuZjrkXdPv62iMvyXZv1uWJ520l8/EWOms4QMQ2e/n7ostXn3475SbRLP
         SSCxjYxJGlvRXmj5oKOkx9dRu/BPE7kYHnUhCASi7bXfYV213sJXcLXZaWX9jCTbMP
         btHR7IFw0S5FmRIBmPdSkwdAT+hL73VDPMDHUb/g=
Date:   Wed, 5 Jun 2019 14:00:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND V4 2/3] arm64: dts: imx8qxp: Move watchdog node
 into scu node
Message-ID: <20190605060000.GA29853@dragon>
References: <1557655528-12816-1-git-send-email-Anson.Huang@nxp.com>
 <1557655528-12816-2-git-send-email-Anson.Huang@nxp.com>
 <DB3PR0402MB39162F3811484D90546B4CC2F5150@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39162F3811484D90546B4CC2F5150@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 09:06:28AM +0000, Anson Huang wrote:
> Hi, Shawn
> 	The driver and binding doc are already reviewed and waiting for DT patch, will you help review this DT patch?

I'm fine with it.  Should I just pick this patch up, or is there any
dependency we need to handle?

Shawn

> 
> Thanks,
> Anson
> 
> > -----Original Message-----
> > From: Anson Huang
> > Sent: Sunday, May 12, 2019 6:11 PM
> > To: robh+dt@kernel.org; mark.rutland@arm.com; wim@linux-watchdog.org;
> > linux@roeck-us.net; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; Aisheng Dong
> > <aisheng.dong@nxp.com>; ulf.hansson@linaro.org; Daniel Baluta
> > <daniel.baluta@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > watchdog@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Cc: dl-linux-imx <linux-imx@nxp.com>
> > Subject: [PATCH RESEND V4 2/3] arm64: dts: imx8qxp: Move watchdog node
> > into scu node
> > 
> > i.MX system controller watchdog has pretimeout function which depends on
> > i.MX SCU driver, so it should be a subnode of SCU.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > No change, just resend patch with correct encoding.
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > index 0683ee2..b17c22e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -149,6 +149,11 @@
> >  		rtc: rtc {
> >  			compatible = "fsl,imx8qxp-sc-rtc";
> >  		};
> > +
> > +		watchdog {
> > +			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
> > +			timeout-sec = <60>;
> > +		};
> >  	};
> > 
> >  	timer {
> > @@ -517,9 +522,4 @@
> >  			power-domains = <&pd IMX_SC_R_GPIO_7>;
> >  		};
> >  	};
> > -
> > -	watchdog {
> > -		compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
> > -		timeout-sec = <60>;
> > -	};
> >  };
> > --
> > 2.7.4
> 
