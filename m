Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF3BC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC62206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfKTQPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:15:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:8039 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfKTQPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:15:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 08:15:27 -0800
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="209788059"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 08:15:11 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [Intel-gfx] linux-next: Tree for Nov 19 (i915)
In-Reply-To: <1d30acd4-9947-d228-967f-c4e76ebca832@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191119194658.39af50d0@canb.auug.org.au> <1d30acd4-9947-d228-967f-c4e76ebca832@infradead.org>
Date:   Wed, 20 Nov 2019 18:15:08 +0200
Message-ID: <87k17uwmlv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 11/19/19 12:46 AM, Stephen Rothwell wrote:
>> Hi all,
>> 
>> Changes since 20191118:
>
>
> on x86_64:
>
> ERROR: "pm_suspend_target_state" [drivers/gpu/drm/i915/i915.ko] undefined!
>
> # CONFIG_SUSPEND is not set

a70a9e998e8e ("drm/i915: Defer rc6 shutdown to suspend_late")

-- 
Jani Nikula, Intel Open Source Graphics Center
