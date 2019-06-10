Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58810C468C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31360206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfFJKZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:25:24 -0400
Received: from foss.arm.com ([217.140.110.172]:40050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388734AbfFJKZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:25:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96ECC337;
        Mon, 10 Jun 2019 03:25:23 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 561B43F557;
        Mon, 10 Jun 2019 03:27:05 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 4193A682189; Mon, 10 Jun 2019 11:25:22 +0100 (BST)
Date:   Mon, 10 Jun 2019 11:25:22 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mali-dp tree
Message-ID: <20190610102522.GE4173@e110455-lin.cambridge.arm.com>
References: <20190608161335.444f3d27@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190608161335.444f3d27@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 04:13:35PM +1000, Stephen Rothwell wrote:
> Hi Liviu,

Hi Stephen,

> 
> Commits
> 
>   74332e53e41d ("drm/komeda: Add image enhancement support")
>   108ddcf9238f ("drm/komeda: Add engine clock requirement check for the downscaling")
>   e980ebbe5cee ("drm/komeda: Add writeback scaling support")
>   37bd61525f3a ("drm/komeda: Implement D71 scaler support")
>   50be77015da8 ("drm/komeda: Add the initial scaler support for CORE")
>   5bbab26c6a4a ("drm/komeda: Attach scaler to drm as private object")
>   0bb0d408280e ("drm/komeda: Potential error pointer dereference")
> 
> are missing a Signed-off-by from their committer.

Sorry about that, I have now fixed them.

Best regards,
Liviu

> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
