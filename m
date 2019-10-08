Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D54C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C00120673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfJHGFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:05:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:38069 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfJHGFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:05:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 23:05:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="206577319"
Received: from wpross-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.86])
  by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2019 23:05:09 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jiri Kosina <trivial@kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        nouveau <nouveau@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH TRIVIAL v2] gpu: Fix Kconfig indentation
In-Reply-To: <CAJKOXPeVFeSDpxPv-rDywCafWbN3mivtcM3UQX_+wZkyPcZwPQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191004144549.3567-1-krzk@kernel.org> <87sgo4hjii.fsf@intel.com> <CADnq5_MqGehpWwOAxYg0T2x3qXisqmae2uGG5dijQX+Aa4NsoQ@mail.gmail.com> <CAJKOXPeVFeSDpxPv-rDywCafWbN3mivtcM3UQX_+wZkyPcZwPQ@mail.gmail.com>
Date:   Tue, 08 Oct 2019 09:05:49 +0300
Message-ID: <87v9szdb5u.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Oct 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, 7 Oct 2019 at 18:09, Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Mon, Oct 7, 2019 at 7:39 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> >
>> > On Fri, 04 Oct 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > >  drivers/gpu/drm/i915/Kconfig             |  12 +-
>> > >  drivers/gpu/drm/i915/Kconfig.debug       | 144 +++++++++++------------
>> >
>> > Please split these out to a separate patch. Can't speak for others, but
>> > the patch looks like it'll be conflicts galore and a problem to manage
>> > if merged in one big lump.
>>
>> Yes, it would be nice to have the amd patch separate as well.
>
> I'll split the AMD and i915 although I am not sure if it is sense to
> split such trivial patch per each driver.

Thanks.

See MAINTAINERS, many of the drivers are maintained in the same drm-misc
repo, and it makes no difference to split those.

In general it's, well, trivial to split up patches like this per driver
or repo, but not splitting it up generates extra busywork in managing
conflicts until some common merge/backmerge happens. We just want to
apply the patch and forget about it, instead of dealing with a trivial
whitespace cleanup many times over.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
