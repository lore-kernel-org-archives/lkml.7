Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4F5C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A5321773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfEUNCO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:02:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:10098 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbfEUNCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:02:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 May 2019 06:02:13 -0700
X-ExtLoop1: 1
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.252.2.137])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2019 06:02:10 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     DRI <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20190520221526.0e103916@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
References: <20190520221526.0e103916@canb.auug.org.au>
Message-ID: <155844372974.15761.3182313807995451625@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.7
Subject: Re: linux-next: Fixes tag needs some work in the drm-intel tree
Date:   Tue, 21 May 2019 16:02:09 +0300
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2019-05-20 15:15:38)
> Hi all,
> 
> In commit
> 
>   0d90ccb70211 ("drm/i915: Delay semaphore submission until the start of the signaler")
> 
> Fixes tag
> 
>   Fixes: e88619646971 ("drm/i915: Use HW semaphores for inter-engine synchroni
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please don't split Fixes tags across more than one line.

Thanks for the report.

This was a copy'n paste mishap, detected by our tooling (and fixed by
me) at the time of creating a PR. Unfortunately the check was not being
enforced by tooling at commit time. We'll fix that.

Regards, Joonas
