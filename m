Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32011C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BBA208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfFUMpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:45:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35123 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFUMpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:45:52 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1heIvL-0001sG-Tt; Fri, 21 Jun 2019 14:45:47 +0200
Message-ID: <1561121145.3149.7.camel@pengutronix.de>
Subject: Re: linux-next: Fixes tags need some work in the drm-fixes tree
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>
Date:   Fri, 21 Jun 2019 14:45:45 +0200
In-Reply-To: <20190621214125.6fb68eee@canb.auug.org.au>
References: <20190621214125.6fb68eee@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-21 at 21:41 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   912bbf7e9ca4 ("gpu: ipu-v3: image-convert: Fix image downsize coefficients")
> 
> Fixes tag
> 
>   Fixes: 70b9b6b3bcb21 ("gpu: ipu-v3: image-convert: calculate per-tile
> 
> has these problem(s):
> 
>   - Please don't split Fixes tags across more than one line
> 
> In commit
> 
>   bca4d70cf1b8 ("gpu: ipu-v3: image-convert: Fix input bytesperline for packed formats")
> 
> Fixes tag
> 
>   Fixes: d966e23d61a2c ("gpu: ipu-v3: image-convert: fix bytesperline
> 
> has these problem(s):
> 
>   - Please don't split Fixes tags across more than one line
> 
> In commit
> 
>   ff391ecd65a1 ("gpu: ipu-v3: image-convert: Fix input bytesperline width/height align")
> 
> Fixes tag
> 
>   Fixes: d966e23d61a2c ("gpu: ipu-v3: image-convert: fix bytesperline
> 
> has these problem(s):
> 
>   - Please don't split Fixes tags across more than one line
> 

I was under the impression that dim would have found those, but I only
just realized that "dim checkpatch" doesn't actually do any additional
checks beyond scripts/checkpatch.pl. Fixes tags are checked only as a
part of "dim push". I wonder if this could be changed [1].

[1] https://gitlab.freedesktop.org/drm/maintainer-tools/merge_requests/5

regards
Philipp
