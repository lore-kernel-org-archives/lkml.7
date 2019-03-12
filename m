Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3892C214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCLKSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:18:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:59573 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLKSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:18:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 03:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="154240944"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 12 Mar 2019 03:18:09 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: DRM-based Oops viewer
In-Reply-To: <20190311221223.GA3344@darwi-home-pc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190310013142.GA3376@darwi-home-pc> <87mum1lr3g.fsf@intel.com> <20190311221223.GA3344@darwi-home-pc>
Date:   Tue, 12 Mar 2019 12:20:01 +0200
Message-ID: <87wol4jsxa.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019, "Ahmed S. Darwish" <darwish.07@gmail.com> wrote:
> Hello Jani,
>
> On Mon, Mar 11, 2019 at 11:04:19AM +0200, Jani Nikula wrote:
>> On Sun, 10 Mar 2019, "Ahmed S. Darwish" <darwish.07@gmail.com> wrote:
>> Please first better define what you want to achieve.
>>
>
> Oh I thought this was clear..
>
> What I want to achieve is:
>
>   - for normal day-to-day x86 laptops users
>   - properly inform the user when a kernel panic happens during
>     a running graphical session (e.g. wayland/gnome/kde/...).

Thanks for the detailed reply. It always helps to start with the problem
you want to solve or end goal you want to reach.

BR,
Jani.



-- 
Jani Nikula, Intel Open Source Graphics Center
