Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B9C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279B221D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576066650;
	bh=1n4dRkvvdCKETj6YqGunEjOSbdyLrGPyEqXt3M6/6wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S0ma7o+XXVSvRL7MMY2CA2+7Y0VWmIhaXAbtktvfHiye7yFRVQ/DXNn0lXA3Meor8
	 KmcIrGgrztUFRkMTT0e3Zon4Ezfb9pwUr8H4LgEG1IVli+ac/ycIkIgFJog5BOZdXq
	 LF+pcuETxUKGt2k8uEN6VvzqTXw9KBaXO9vEF7yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfLKMR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:17:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbfLKMR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:17:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADEA214D8;
        Wed, 11 Dec 2019 12:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576066646;
        bh=1n4dRkvvdCKETj6YqGunEjOSbdyLrGPyEqXt3M6/6wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THftVLfHvoU6YrX83eDiFEHMqmQzvJgd5DeuwSKhX2F4lhHXMy+pikZZxyRETijp3
         kESWxqIVEK0BKR/gxeZZm9zuT6lD22QmeIKDUw9Cp0JkHxatXzo3qrCedCfutgWWAH
         IZpPzdBjNzNsHQheWPxZC3At7oJRHln1BdIH3CcA=
Date:   Wed, 11 Dec 2019 13:17:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Chng, Jack Ping" <jack.ping.chng@linux.intel.com>
Cc:     devel@driverdev.osuosl.org, cheol.yong.kim@intel.com,
        andriy.shevchenko@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mallikarjunax.reddy@linux.intel.com,
        davem@davemloft.net
Subject: Re: FW: [PATCH v2] staging: intel-gwdpa: gswip: Introduce Gigabit
 Ethernet Switch (GSWIP) device driver
Message-ID: <20191211121724.GA514307@kroah.com>
References: <5f85180573a3fb20238d6a340cdd990f140ed6f0.1576054234.git.jack.ping.chng@intel.com>
 <20191211092738.GA505511@kroah.com>
 <BYAPR11MB317606F8BE2B60C4BAD872F1DE5A0@BYAPR11MB3176.namprd11.prod.outlook.com>
 <c26e56cf-eb04-5992-252a-e66f6029d6ac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26e56cf-eb04-5992-252a-e66f6029d6ac@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:37:42PM +0800, Chng, Jack Ping wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, December 11, 2019 5:28 PM
> > To: Chng, Jack Ping <jack.ping.chng@intel.com>
> > Cc: devel@driverdev.osuosl.org; Kim, Cheol Yong <cheol.yong.kim@intel.com>; Shevchenko, Andriy <andriy.shevchenko@intel.com>; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>; davem@davemloft.net
> > Subject: Re: [PATCH v2] staging: intel-gwdpa: gswip: Introduce Gigabit Ethernet Switch (GSWIP) device driver
> > 
> > On Wed, Dec 11, 2019 at 04:57:28PM +0800, Jack Ping CHNG wrote:
> > > This driver enables the Intel's LGM SoC GSWIP block.
> > > GSWIP is a core module tailored for L2/L3/L4+ data plane and QoS functions.
> > > It allows CPUs and other accelerators connected to the SoC datapath to
> > > enqueue and dequeue packets through DMAs.
> > > Most configuration values are stored in tables such as Parsing and
> > > Classification Engine tables, Buffer Manager tables and Pseudo MAC
> > > tables.
> > Odd line wrapping :(
> > 
> > > Signed-off-by: Jack Ping CHNG <jack.ping.chng@intel.com>
> > > Signed-off-by: Amireddy Mallikarjuna reddy
> > > <mallikarjunax.reddy@linux.intel.com>
> > > ---
> > > Changes on v2:
> > > - Renamed intel-dpa to intel-gwdpa
> > > - Added intel-gwdpa.txt(Intel Gateway Datapath Architecture)
> > > - Added TODO (upstream plan)
> > 
> > > +Upstream plan
> > > +--------------
> > > +
> > > +      GSWIP  CQM  PP  DPM     DCDP
> > > +        |     |    |   |        |
> > > +        |     |    |   |        |
> > > +        V     V    V   V        V
> > > +        -------------------------------------( drivers/staging/intel-gwdpa/* )
> > > +                            |  (move to soc folder)
> > > +                            V
> > > +                    -------------------------(
> > > + drivers/soc/intel/gwdpa-*/* )
> > > +
> > > +                            Eth driver  Wireless/
> > > +                                |       WAN driver
> > > +                                |         |
> > > +                                V         V
> > > +                             ----------------( drivers/net/ethernet/intel )
> > > +                                             ( drivers/net/wireless )
> > > +                                             ( drivers/net/wan)
> > > +
> > > +* Each driver will have a TODO list.
> > Again, what kind of plan is this?  It's just a "these files need to be moved to this location" plan?
> > 
> > Why not do that today?
> > 
> > What is keeping this code from being accepted in the "correct" place today?  And why do you want it in staging?  You know it takes even more work to do things here, right?  Are you ready to sign up for that work (hint, you didn't add your names to the MAINTAINER file, so I worry about that...)
> 
> Thanks for the reply.
> 
> We are trying to upstream the datapath code for Intel new NoC gateway
> (please refer to intel-gwdpa.txt at the end of the patch). It consists of
> ethernet, WIFI and passive optics handling. Since the code is quite huge, we
> have broken it into parts for internal review.
> 
> As we have seen past upstream example such as fsl/dpaa, we thought that it
> is better for us to start the upstreaming of the driver into staging folder
> to get feedback from the community.
> 
> Is this the right approach? Or do we upstream all the drivers into
> drivers/soc folder when we have all the drivers ready?

Why is drivers/soc/ the place to put networking drivers?

Please please please work with the Intel Linux kernel developers who
know how to do this type of thing and do not require the kernel
community to teach you all the proper development model and methods
here.

thanks,

greg k-h
