Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2047C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB72208C4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556774220;
	bh=NcIdCG+D6Yk32Jv50BR8KU/NePdcnIFMxP+iYp+hIV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hykRLJrnq9aRODk28XNoDF44e/bJGZ64NGIv4l/EbzBoqvBT+iKVOl0J0AJzZxwKl
	 R3yjscAyGkw720uIfo+H+7mh12kx90MnaO1PeJyAcKedBxIhI6UzGrXO9BIU7WVfnp
	 QFXkiFHJe8UQZQmIx/fZj5SIIY9vQRgvx8xHDOPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfEBFQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfEBFQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:16:59 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A992C2081C;
        Thu,  2 May 2019 05:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556774218;
        bh=NcIdCG+D6Yk32Jv50BR8KU/NePdcnIFMxP+iYp+hIV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xlDqDv9XpmaUY4A3VeWHr2jKjO08rHnMjuGCzv0aA2AUgnYU8UhE0SzU2BpD3d5+D
         oQwCIV98B8XO55BGDrdnWwUtVEC0Gx/wHv/0VqV43+f96lLXhaeULpkXThpUNkELks
         XMlc+wmIIl4zsDMCKq70VqW/IUJa8OOe7CPKT1ic=
Date:   Thu, 2 May 2019 10:46:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v4 02/22] soundwire: fix SPDX license for header files
Message-ID: <20190502051440.GA3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501155745.21806-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> No C++ comments in .h files
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/bus.h            | 4 ++--
>  drivers/soundwire/cadence_master.h | 4 ++--
>  drivers/soundwire/intel.h          | 4 ++--

As I said previously this touches subsystem header as well as driver
headers which is not ideal. Also I agree with Greg, SPDX line format is
a requirement but not the copyright one but that is not a deal breaker
here.

>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index c77de05b8100..2f8436584e7f 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -1,5 +1,5 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> -// Copyright(c) 2015-17 Intel Corporation.
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/* Copyright(c) 2015-17 Intel Corporation. */
>  
>  #ifndef __SDW_BUS_H
>  #define __SDW_BUS_H
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index eb902b19c5a4..75f7412cfbbd 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -1,5 +1,5 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> -// Copyright(c) 2015-17 Intel Corporation.
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/* Copyright(c) 2015-17 Intel Corporation. */
>  #include <sound/soc.h>
>  
>  #ifndef __SDW_CADENCE_H
> diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
> index c1a5bac6212e..71050e5f643d 100644
> --- a/drivers/soundwire/intel.h
> +++ b/drivers/soundwire/intel.h
> @@ -1,5 +1,5 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> -// Copyright(c) 2015-17 Intel Corporation.
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/* Copyright(c) 2015-17 Intel Corporation. */
>  
>  #ifndef __SDW_INTEL_LOCAL_H
>  #define __SDW_INTEL_LOCAL_H
> -- 
> 2.17.1

-- 
~Vinod
