Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB5AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173D1206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfCMQLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:11:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:43972 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfCMQL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:11:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 09:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="154682159"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2019 09:11:26 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/ddi: Fix default eDP detection on port A
In-Reply-To: <87sgvyly1h.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190306200618.17405-1-thomas.preston@codethink.co.uk> <874l8fm72f.fsf@intel.com> <a1434319-daba-756f-34c7-3ea653a9d2eb@codethink.co.uk> <87va0vkm6e.fsf@intel.com> <1bc46e12-5cee-e3d0-83db-2feee4fe5210@codethink.co.uk> <87sgvyly1h.fsf@intel.com>
Date:   Wed, 13 Mar 2019 18:13:17 +0200
Message-ID: <87k1h2iwgy.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Mar 2019, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Thu, 07 Mar 2019, Thomas Preston <thomas.preston@codethink.co.uk> wrote:
>> Would you like me to resubmit with the suggested changes?
>
> Nah, we can tweak the commit message while applying.

Pushed to dinq, thanks for the patch.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
