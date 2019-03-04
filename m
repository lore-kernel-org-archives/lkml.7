Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9CAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB01B2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551682449;
	bh=6VuAjyAddotNq2EYZx+fOq8K4a8Mvh/0OZ3+vmq28q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TI6drEkPVKRFpLqx+ngHT0CXtC+1EyqfkbLBc1pSU4YUKX/jmJDMo8gqQljHkHDgZ
	 2OoaOyLxgKwEE/FTvjcWIcKXue2xTAsdOQ58NGf52ypzxTyuXSiBYeRaB1d2YYqAVq
	 lrOqN3Y1inlDQCv6XfCMGMUbKlj82cAnIT5UI1ZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfCDGyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:54:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfCDGyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:54:07 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88A3A21019;
        Mon,  4 Mar 2019 06:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551682446;
        bh=6VuAjyAddotNq2EYZx+fOq8K4a8Mvh/0OZ3+vmq28q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGNaDuIZrzn8JSBn5hZopIHxQgqmB0y4sHpRnbYReTDUG3tQACtvejPaBjf97ydYc
         VG8fNr4eRr+BFYGYtDhIxoe6QxVfk1vsGk+5h7tPkx3WNFsfJmRndwo5ULif2t19Xw
         JYGNLL2vlrWEhURkCxb/UIRqZYZioZ1j9QAr2OhQ=
Date:   Mon, 4 Mar 2019 14:53:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Message-ID: <20190304065302.GD26041@dragon>
References: <20190304032111.21770-1-andy.tang@nxp.com>
 <20190304062115.GB26041@dragon>
 <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 06:46:32AM +0000, Andy Tang wrote:
> 
> 
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: 2019年3月4日 14:21
> > To: Andy Tang <andy.tang@nxp.com>
> > Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org;
> > daniel.lezcano@linaro.org; rui.zhang@intel.com; edubezval@gmail.com
> > Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
> > 
> > On Mon, Mar 04, 2019 at 11:21:11AM +0800, Yuantian Tang wrote:
> > > Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core
> > > cluster sensor is used to monitor the temperature of core and SoC
> > > platform is for platform. The current dts only support the first sensor.
> > > This patch adds the second sensor node to dts to enable it.
> > >
> > > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> > > ---
> > > v2:
> > > 	- Add more information about sensors to description
> > > PS: In order to keep consistency to the first thermal-zone node, there
> > > will be "WARNING: line over 80 characters" warnings.
> > >
> > >  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   43
> > +++++++++++++++++++++--
> > >  1 files changed, 39 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > index 661137f..9f52bc9 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > > @@ -129,19 +129,19 @@
> > >  	};
> > >
> > >  	thermal-zones {
> > > -		cpu_thermal: cpu-thermal {
> > > +		ccu {
> > 
> > Is this change really necessary?  What does 'ccu' stand for?
> I think so. ccu stands for core cluster unit. cpu is too general.
> On some platforms, there are more than one core clusters.
> At least we should change it to "core cluster" if short form is not appropriate.

Yes, please give it a more descriptive name.

Shawn
