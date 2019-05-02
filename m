Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8365C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B495321479
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556779494;
	bh=t0B0FuOVE7Lh7IadbKF9pKqOPoOYFk5qPf8OvxHkMEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A6smE4TkB10AVAfkceQR6MnofBwuzu+J1ksR1vKGywpLL87/qXWvLPJK8+i8nbyNA
	 Ke8BLlX2C1URHw7cJgHeENZMxWaFhqivzFHkBiuZxrDoRzWXLRo5+N5BiW3cmgdWzj
	 wtgxCO2poK/sylwP3jyRLbIpMAtVmcyyoPlTVGcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEBGox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 02:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfEBGox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:44:53 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83AC5208C4;
        Thu,  2 May 2019 06:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556779492;
        bh=t0B0FuOVE7Lh7IadbKF9pKqOPoOYFk5qPf8OvxHkMEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2qpWuJ26/iHz3DAWERdoRtev8O+uc7f55BIyH1gkalCRJDUmvhdoqct1XmKBowpYf
         q8krZ94SMaLjce49NkHH7G5wJ9+EW73lc3quUdoYV1WI5EV0gRHKTWjWctFplnDt+u
         TbaZ+ZB7B/D7ZD5tSgXKNNncES2J7vwiVmSGaqxw=
Date:   Thu, 2 May 2019 12:14:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 02/22] soundwire: fix SPDX license for header files
Message-ID: <20190502064438.GJ3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-3-pierre-louis.bossart@linux.intel.com>
 <20190502051440.GA3845@vkoul-mobl.Dlink>
 <20190502063139.GA14347@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502063139.GA14347@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-05-19, 08:31, Greg KH wrote:
> On Thu, May 02, 2019 at 10:46:49AM +0530, Vinod Koul wrote:
> > On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> > > No C++ comments in .h files
> > > 
> > > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > ---
> > >  drivers/soundwire/bus.h            | 4 ++--
> > >  drivers/soundwire/cadence_master.h | 4 ++--
> > >  drivers/soundwire/intel.h          | 4 ++--
> > 
> > As I said previously this touches subsystem header as well as driver
> > headers which is not ideal.
> 
> What?  Who knows that?  Who cares?

Well at least Pierre knows that very well :) He is designate Reviewer of
this subsystem.

> This is doing "one logical thing" to all of the needed files.  Your
> split of "this is a driver" vs. "this is a subsystem" split is _VERY_
> arbritary.
> 
> That's just too picky and assumes a subsystem-internal-knowledge much
> deeper than anyone submitting a normal cleanup patch would ever know.

Sure I do agree that this assumes internal knowledge but the contributor
knows the subsystem extremely well and he knows the different parts. For
drive by contributor I agree things would be not that picky :)

Even considering the patch series, some split was even file based and in
this case not done. All I ask is for consistency in the series proposed.

> I think you have swung too far to the "too picky" side, you might want
> to dial it back.

Sure given that this is code cleanup I will split them up and push.
Shouldn't take much of my time.

Thanks for the advise.
-- 
~Vinod
