Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D731C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E47B21871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553069960;
	bh=nkM+KtRVPjQUt1pQmj9DalXM/7+xvh8bqtVNzoBCheQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j5UizZApbw/UsZ2hm2vQdz5tEq99bUO0BIOMvuuq51xgC8WgnQDs+tf6ZeVYD6WG5
	 7UL4OsSeqK+kLqdE+8Ubu7dKqhRnM18B32RHeWB3qQh7r9wjlbx3bxsk4m5Ijyfgcg
	 K0A76uh+TN4YzzERoG8jSqBDvsRnm4pxLHVfn3SM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfCTITT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCTITS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:19:18 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79C0C20657;
        Wed, 20 Mar 2019 08:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553069956;
        bh=nkM+KtRVPjQUt1pQmj9DalXM/7+xvh8bqtVNzoBCheQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGvogefzjixxnh/ZE1SX1tpWVM5SQdUinz9ZNVaSv/nueFt6jUWAxQRazzLhvrdkD
         sMkhl9hZScXnD0vj62XWuzVxxIwA9WfvDYX5G9NteR0DbiAObTqJPUQanU1LRcF/E+
         9J9BOeI9InyBCACqgfih9J2hqEugTLlYsy+UqBxQ=
Date:   Wed, 20 Mar 2019 16:18:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
Message-ID: <20190320081853.GE4980@dragon>
References: <20190304032111.21770-1-andy.tang@nxp.com>
 <20190304062115.GB26041@dragon>
 <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <dc94e884-f5eb-fe07-27ef-6a94c3174acb@linaro.org>
 <VI1PR04MB43330C6FAAD0D8EAE901C56FF34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <cb262e2c-7115-86a5-01ce-4a12d45ee019@linaro.org>
 <VI1PR04MB43338294C193D1AB4F577E92F34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB43338294C193D1AB4F577E92F34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 09:57:09AM +0000, Andy Tang wrote:
> 
> 
> > -----Original Message-----
> > From: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Sent: 2019年3月8日 17:28
> > To: Andy Tang <andy.tang@nxp.com>; Shawn Guo <shawnguo@kernel.org>
> > Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org; rui.zhang@intel.com;
> > edubezval@gmail.com
> > Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
> > 
> > On 08/03/2019 03:07, Andy Tang wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> > >> Sent: 2019年3月7日 17:15
> > >> To: Andy Tang <andy.tang@nxp.com>; Shawn Guo <shawnguo@kernel.org>
> > >> Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org;
> > >> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org;
> > >> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > >> linux-pm@vger.kernel.org; rui.zhang@intel.com; edubezval@gmail.com
> > >> Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal
> > >> zone node
> > >>
> > >>>>> PS: In order to keep consistency to the first thermal-zone node,
> > >>>>> there will be "WARNING: line over 80 characters" warnings.
> > >>>>>
> > >>>>>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   43
> > >>>> +++++++++++++++++++++--
> > >>>>>  1 files changed, 39 insertions(+), 4 deletions(-)
> > >>>>>
> > >>>>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > >>>>> b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > >>>>> index 661137f..9f52bc9 100644
> > >>>>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > >>>>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > >>>>> @@ -129,19 +129,19 @@
> > >>>>>  	};
> > >>>>>
> > >>>>>  	thermal-zones {
> > >>>>> -		cpu_thermal: cpu-thermal {
> > >>>>> +		ccu {
> > >>>>
> > >>>> Is this change really necessary?  What does 'ccu' stand for?
> > >>> I think so. ccu stands for core cluster unit. cpu is too general.
> > >>> On some platforms, there are more than one core clusters.
> > >>> At least we should change it to "core cluster" if short form is not
> > appropriate.
> > >>
> > >> If the sensor is a the cluster level, 'cluster' is enough. IMHO, no
> > >> need to give a description of what contains the cluster, otherwise
> > >> you will end up with a 'core-gpu-cluster-l2' name.
> > > If cluster is specific to core, we can use cluster instead. But I don't think so.
> > > Cluster may refer to "core cluster", "GPU cluster" etc.
> > > So, I think "core-cluster" is ok.
> > > If core was divided to several clusters, we can name it as "core-cluster1",
> > "core-cluster2" etc.
> > > If GPU was divided to several clusters we can name it as "gpu-cluster1",
> > "gpu-cluster2" etc.
> > 
> > 
> > Hi Andy,
> > 
> > I think there is a confusion around the 'cpu' term and 'cluster'.
> > 
> > ARM would like to see the 'cluster' word to disappear, so whenever possible we
> > should avoid it.
> > 
> > From the hardware side, 'CPU' is usually used to describe the physical chip
> > containing the cores+cache.
> > 
> > From the software side, 'CPU' is usually used to describe the logical process
> > unit, aka a core or a hyper-thread.
> > 
> > As we are in the DT, so describing the hardware, the CPU refers to the group
> > cores+caches.
> > 
> > From my POV, using 'cpu' for the group of cores and 'gpu' for the graphic
> > sounds ok, and so far that is what is used for the other platforms.
> > 
> > If you change the name, that may give the feeling there is something special
> > with those thermal zones.
> 
> Thanks Daniel for your detailed explanations.
> 
> But as you said 'CPU' is usually used to describe the physical chip.

Here is how I would understand Daniel's comments:

  CPU = cores + caches
  physical chip = SoC = CPU + GPU + peripherals ...

> So if we name it as CPU, it sounds like this temperature sensor is monitoring the whole chip.
> That's not true in our case.
> 
> Take ls2088a for example:
> In ls2088a SoC, there are 7 temperature sensors. Please note that they are all located in SoC.
> The placement of the temperature sensors are showed below:
> 
> Sensor ID		placement
> 1			DDR controller 1
> 2			DDR controller 2
> 3			DDR controller 3
> 4			core cluster 1
> 5 			core cluster 2
> 6 			core cluster 3
> 7 			core cluster 4
> 
> Apparently using CPU or CPU-cluster is not appropriate. Core-cluster is better.

So using CPU is appropriate for me, less confusing, more consistent with
other platforms.

Shawn
