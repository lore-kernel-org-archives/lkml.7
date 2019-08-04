Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E098C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5556820844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 20:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfHDURX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 16:17:23 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:46355 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbfHDURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 16:17:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1131D181D3368;
        Sun,  4 Aug 2019 20:17:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: book66_7a24adcc5af63
X-Filterd-Recvd-Size: 1902
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun,  4 Aug 2019 20:17:19 +0000 (UTC)
Message-ID: <15450f6ba169de8862e11bc2d20b3645958f4efd.camel@perches.com>
Subject: Re: [PATCH 1/1] block: Use bits.h macros to improve readability
From:   Joe Perches <joe@perches.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Sun, 04 Aug 2019 13:17:17 -0700
In-Reply-To: <a41b5530-f2e1-0932-1f39-0ce66ce902ae@kernel.dk>
References: <20190802000041.24513-1-leonardo@linux.ibm.com>
         <a41b5530-f2e1-0932-1f39-0ce66ce902ae@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-02 at 21:18 -0700, Jens Axboe wrote:
> On 8/1/19 6:00 PM, Leonardo Bras wrote:
> > Applies some bits.h macros in order to improve readability of
> > linux/blk_types.h.
[]
> I know precisely what that does, whereas I have to think about the other
> one, maybe even look it up to be sure. For instance, without looking
> now, I have no idea what the second argument is. Looking at the git log,
> I see numerous instances of:

While I'm not at all a proponent of GENMASK/GENMASK_ULL,
and so not a proponent of this patch, latent defects are
possible in both cases.

You'd likely have to look at SOME_SHIFT to see if it's 0
to verify the actual mask is what's really desired.

$ git grep -P '_SHIFT\s+\(?\s*0\s*\)?\b' | wc -l
11907

