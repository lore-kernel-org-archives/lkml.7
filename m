Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DB2C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3CD21850
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556046888;
	bh=BfAAkvG4W/r5rmsZCLki5Q6nJ5+PUd/PE8Z0DdfcSzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RZ90B1jJp3ipnB5FftjRERGryfKz8hXKbYbvSUaV2CDvUwkyp5noA+vl4GPpK8PLF
	 vELOx53aRj6T0iNFVSrGQEjvIizI3A9gpy/24T1DmkXFILM42cEMFyir0wfHfQ8CK4
	 SVk4WO6C9Hz90YZxW4itjbcdZT0YUltyCgEvEMo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDWTOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWTOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:14:46 -0400
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net [107.207.74.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27A88217D9;
        Tue, 23 Apr 2019 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556046885;
        bh=BfAAkvG4W/r5rmsZCLki5Q6nJ5+PUd/PE8Z0DdfcSzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wYaSW1m7zc3iqKNW/DI4xraNw3xzdwfVX12Yy60qrNKR/vJv8S3V9VTf3RUFclIHF
         Lc4T49S2BpXQ/vxUgZbZLGC6/+odBg8us8kZZktQMNcl7X/K0PqkaDCp0olk0Atysw
         P2Om/Egh9KSfjddOcUv+EiJuw6qq+k0QKwn8irwg=
Date:   Tue, 23 Apr 2019 14:14:43 -0500
From:   Andy Gross <agross@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 00/13] qcom: dts: thermal cleanups
Message-ID: <20190423191443.GA8413@hector.attlocal.net>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
 <5583cae1-8fea-724a-24a4-59b38a205ac3@free.fr>
 <CAP245DUNo02QUkGDPFfzow9535GKO9x6ZusETRjEgTmnHL4D2g@mail.gmail.com>
 <842b06c6-15b2-7ba6-702e-c8b043d390a6@free.fr>
 <CAP245DVqGQ6MEfcYjr2PYnD=BR86vC=BsRMpZe0jsgbAc6jFGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP245DVqGQ6MEfcYjr2PYnD=BR86vC=BsRMpZe0jsgbAc6jFGg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 06:26:40PM +0530, Amit Kucheria wrote:
> On Tue, Apr 23, 2019 at 3:01 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> >
> > On 02/04/2019 20:46, Amit Kucheria wrote:
> >
> > > On Tue, Apr 2, 2019 at 8:58 PM Marc Gonzalez wrote:
> > >>
> > >> On 29/03/2019 11:12, Amit Kucheria wrote:
> > >>
> > >>> Changes since v1:
> > >>> - Devices that are not associated with cooling-maps use the 'hot' type
> > >>> - Remove critical trip from such devices too and restrict that type of CPUs
> > >>> - For 8916, add the sensor on the modem
> > >>>
> > >>> Description:
> > >>> - Expose all temperature sensors on msm8916, msm996, msm8998, sdm845
> > >>> - split up the register address map for msm8998
> > >>> - standardize names of the various thermal-zones across boards to make it
> > >>>   easy for test scripts to parse
> > >>
> > >> This is what I see on msm8998 with your patch series applied on top of
> > >> yesterday's next:
> > >>
> > >> # dmesg | grep of_parse_thermal_zones
> > >> of_parse_thermal_zones: build cpu0-thermal zone 0
> > >> of_parse_thermal_zones: build cpu1-thermal zone 0
> > >> of_parse_thermal_zones: build cpu2-thermal zone 0
> > >> of_parse_thermal_zones: build cpu3-thermal zone 0
> > >> of_parse_thermal_zones: build cpu4-thermal zone 0
> > >> of_parse_thermal_zones: build cpu5-thermal zone 0
> > >> of_parse_thermal_zones: build cpu6-thermal zone 0
> > >> of_parse_thermal_zones: build cpu7-thermal zone 0
> > >> of_parse_thermal_zones: build gpu-thermal-bottom zone 0
> > >> of_parse_thermal_zones: build gpu-thermal-top zone 0
> > >> of_parse_thermal_zones: build cluster0-mhm-thermal zone -22
> > >> of_parse_thermal_zones: build cluster1-mhm-thermal zone -22
> > >> of_parse_thermal_zones: build cluster1-l2-thermal zone 0
> > >> of_parse_thermal_zones: build modem-thermal zone 0
> > >> of_parse_thermal_zones: build mem-thermal zone 0
> > >> of_parse_thermal_zones: build wlan-thermal zone 0
> > >> of_parse_thermal_zones: build q6-dsp-thermal zone 0
> > >> of_parse_thermal_zones: build camera-thermal zone 0
> > >> of_parse_thermal_zones: build multimedia-thermal zone 0
> > >> of_parse_thermal_zones: build pm8998 zone 0
> > >> of_parse_thermal_zones: build battery-thermal zone 0
> > >> of_parse_thermal_zones: build skin-thermal zone 0
> > >>
> > >> NB: -EINVAL for cluster0-mhm-thermal and cluster1-mhm-thermal
> > >>
> > >>
> > >> # cat /sys/devices/virtual/thermal/thermal_zone*/temp
> > >> 35800
> > >> 35200
> > >> 34500
> > >> 34800
> > >> 34500
> > >> 34100
> > >> 34100
> > >> 33500
> > >> 33800
> > >> cat: /sys/devices/virtual/thermal/thermal_zone17/temp: Invalid argument
> > >> 36100
> > >> cat: /sys/devices/virtual/thermal/thermal_zone19/temp: Invalid argument
> > >> 35500
> > >> 36100
> > >> 35800
> > >> 35200
> > >> 35500
> > >> 36100
> > >> cat: /sys/devices/virtual/thermal/thermal_zone8/temp: Invalid argument
> > >> cat: /sys/devices/virtual/thermal/thermal_zone9/temp: Invalid argument
> > >>
> > >>
> > >> Are the failures expected?
> > >> (cluster*-mhm-thermal and thermal_zone*/temp)
> > >
> > > No they are not. Unfortunately, I didn't have HW to test, so
> > > appreciate the help with testing. I'll check the 8, 9, 17 and 19 again
> > > before resubmitting.
> >
> > Looks like Andy merged this series?
> 
> Argh! my bad, I completely forgot about the need to fix this up. I
> need to get me one of these boards.

Hey I have a second set being worked up.  If you get me the fixups I can add
them to that.  Or I can revert.  Let me know.

> We can either revert that one patch for the msm8998, but I think it
> might be better if I send a fixup patch that could fixup those 4 zones
> instead.

Sorry to miss the conversation.  I had these queued up on a branch for a while
now and totally missed the convo on this.  In any case, we can get it fixed up.


Andy
