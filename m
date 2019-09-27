Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7B6C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B36120872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfI0Md2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:33:28 -0400
Received: from foss.arm.com ([217.140.110.172]:51040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfI0Md2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:33:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4492F1000;
        Fri, 27 Sep 2019 05:33:27 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24EDC3F67D;
        Fri, 27 Sep 2019 05:33:27 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id D747268295D; Fri, 27 Sep 2019 13:33:25 +0100 (BST)
Date:   Fri, 27 Sep 2019 13:33:25 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/komeda: Fix typos in komeda_splitter_validate
Message-ID: <20190927123325.zkyttahfysypl6mv@e110455-lin.cambridge.arm.com>
References: <20190920151117.22725-1-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190920151117.22725-1-mihail.atanassov@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 03:11:34PM +0000, Mihail Atanassov wrote:
> Fix both the string and the struct member being printed.
> 
> Fixes: 264b9436d23b ("drm/komeda: Enable writeback split support")
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index 950235af1e79..de64a6a9964e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -564,8 +564,8 @@ komeda_splitter_validate(struct komeda_splitter *splitter,
>  	}
>  
>  	if (!in_range(&splitter->vsize, dflow->in_h)) {
> -		DRM_DEBUG_ATOMIC("split in_in: %d exceed the acceptable range.\n",
> -				 dflow->in_w);
> +		DRM_DEBUG_ATOMIC("split in_h: %d exceed the acceptable range.\n",

Being pedandic: s/exceed/exceeds/.

Best regards,
Liviu

> +				 dflow->in_h);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.23.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
