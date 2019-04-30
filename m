Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C88FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC06D21734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556633131;
	bh=9ZJWdF9SsTB6SA6IlPmBNvu9i4begnuPan4SVaTH7C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=seSS+9fOVhfX87bl9QuZzSjmUuCaZZNs7z43OMcka53ZnXuZ0fRF3EPIfSk6/EJLm
	 e43m694AszOaUoZ6YaMSOVWLQ2wyHPhaMjD6SAt57f5zfCgl1IPwxFM2N38nFiMvpE
	 5Qse1VRVvvbt9jNmmlXjvnAnWFt/czqCBzKsBkko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfD3OFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfD3OFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:05:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35E82087B;
        Tue, 30 Apr 2019 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556633129;
        bh=9ZJWdF9SsTB6SA6IlPmBNvu9i4begnuPan4SVaTH7C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XO/1XkYslcvewRRAsFHBIitR5RAe4LM+HHpRsmO27GfE3GZYiaPcKUMG+ox70Rofz
         gVbcZVG5JmRE0f1MhnwhpgkNULch9gSn5CX/EohFg8g2tDQaqctq3PS8Zz/0ud/UlK
         29eVTW66hFK0HQUALY9R7Ra5mkVuMkadA4QdDLuc=
Date:   Tue, 30 Apr 2019 16:05:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
Message-ID: <20190430140526.GB18986@kroah.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
 <20190430085153.GS3845@vkoul-mobl.Dlink>
 <9866ac8c-103d-22cd-a639-a71c39a685c2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9866ac8c-103d-22cd-a639-a71c39a685c2@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 08:38:01AM -0500, Pierre-Louis Bossart wrote:
> On 4/30/19 3:51 AM, Vinod Koul wrote:
> > On 15-04-19, 08:09, Pierre-Louis Bossart wrote:
> > > 
> > > > > 
> > > > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > > ---
> > > > >    drivers/soundwire/Kconfig          |   2 +-
> > > > >    drivers/soundwire/bus.c            |  87 ++++++++--------
> > > > >    drivers/soundwire/bus.h            |  16 +--
> > > > >    drivers/soundwire/bus_type.c       |   4 +-
> > > > >    drivers/soundwire/cadence_master.c |  87 ++++++++--------
> > > > >    drivers/soundwire/cadence_master.h |  22 ++--
> > > > >    drivers/soundwire/intel.c          |  87 ++++++++--------
> > > > >    drivers/soundwire/intel.h          |   4 +-
> > > > >    drivers/soundwire/intel_init.c     |  12 +--
> > > > >    drivers/soundwire/mipi_disco.c     | 116 +++++++++++----------
> > > > >    drivers/soundwire/slave.c          |  10 +-
> > > > >    drivers/soundwire/stream.c         | 161 +++++++++++++++--------------
> > > > 
> > > > I would prefer this to be a patch per module. It doesnt help to have a
> > > > single patch for all the files!
> > > > 
> > > > It would be great to have cleanup done per logical group, for example
> > > > typos in a patch, aligns in another etc...
> > > 
> > > You've got to be kidding. I've never seen people ask for this sort of
> > > detail.
> > 
> > Nope this is the way it should be. A patch is patch and which
> > should do one thing! Even if it is a cleanup one.
> > 
> > I dislike a patch which touches everything, core, modules, so please
> > split up. As a said in review it takes guesswork to find why a change
> > was done, was it whitespace fix, indentation or not, so please split up
> > based on type of fixes.
> 
> With all due respect, you are not helping here but rather slowing things
> down. I've done dozens of cleanups in the ALSA tree and I didn't go in this
> sort of details. The fact that the series was tagged as Reviewed by Takashi
> on April 11 and we are still discussing trivial changes tells me the
> integration model is broken. It's not just me, the patches related to
> runtime-pm from your own Linaro colleagues posted on March 28 went nowhere
> either.

My patch-bot would reject a patch that tried to do multiple types of
different cleanups on the same file(s).  Has done so for _years_, this
is not a new thing.

Remember, maintainer/reviewer time is scarce, engineer time is prolific,
we optimize for reviewers, not the people writing the patches.

thanks,

greg k-h
