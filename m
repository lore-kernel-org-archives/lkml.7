Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADF8C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD402171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407035AbfHINVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:21:07 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:63962
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406273AbfHINVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:21:07 -0400
X-IronPort-AV: E=Sophos;i="5.64,364,1559512800"; 
   d="scan'208";a="316018627"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:21:04 +0200
Date:   Fri, 9 Aug 2019 15:21:03 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
cc:     Mark Brown <broonie@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>, kbuild-all@01.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix odd_ptr_err.cocci warnings
In-Reply-To: <88ac4c79-5ce3-3f1a-5f6e-3928a30a1ef5@ti.com>
Message-ID: <alpine.DEB.2.21.1908091519400.2946@hadrien>
References: <alpine.DEB.2.21.1908091229140.2946@hadrien> <20190809123112.GC3963@sirena.co.uk> <88ac4c79-5ce3-3f1a-5f6e-3928a30a1ef5@ti.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Aug 2019, Peter Ujfalusi wrote:

>
>
> On 09/08/2019 15.31, Mark Brown wrote:
> > On Fri, Aug 09, 2019 at 12:30:46PM +0200, Julia Lawall wrote:
> >
> >> tree:   https://github.com/omap-audio/linux-audio peter/ti-linux-4.19.y/wip
> >> head:   62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a
> >> commit: 62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a [34/34] j721e new machine driver wip
> >> :::::: branch date: 20 hours ago
> >> :::::: commit date: 20 hours ago
> >>
> >>  j721e-evm.c |    4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> --- a/sound/soc/ti/j721e-evm.c
> >> +++ b/sound/soc/ti/j721e-evm.c
> >> @@ -283,7 +283,7 @@ static int j721e_get_clocks(struct platf
> >
> > This file isn't upstream, it's only in the TI BSP.
>
> Yes, it is not upstream, but the fix is valid.
>
> Julia: is it possible to direct these notifications only to me from
> https://github.com/omap-audio/linux-audio.git ?
>
> It mostly carries TI BSP stuff and my various for upstream branches nowdays.

Please discuss it with the kbuild people.  They should be able to set it
up as you want.

You can try lkp@intel.com

julia
