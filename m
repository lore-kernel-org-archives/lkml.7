Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B752B20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfCGLbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:31:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:25301 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbfCGLbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:31:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 03:31:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="152865261"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2019 03:31:02 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/ddi: Fix default eDP detection on port A
In-Reply-To: <1bc46e12-5cee-e3d0-83db-2feee4fe5210@codethink.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190306200618.17405-1-thomas.preston@codethink.co.uk> <874l8fm72f.fsf@intel.com> <a1434319-daba-756f-34c7-3ea653a9d2eb@codethink.co.uk> <87va0vkm6e.fsf@intel.com> <1bc46e12-5cee-e3d0-83db-2feee4fe5210@codethink.co.uk>
Date:   Thu, 07 Mar 2019 13:32:58 +0200
Message-ID: <87sgvyly1h.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Mar 2019, Thomas Preston <thomas.preston@codethink.co.uk> wrote:
> Would you like me to resubmit with the suggested changes?

Nah, we can tweak the commit message while applying.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
