Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6B0C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D6121473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDHMjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:39:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:56328 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfDHMjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:39:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 05:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="138482167"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2019 05:39:16 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDTYR-0007hl-3z; Mon, 08 Apr 2019 15:39:15 +0300
Date:   Mon, 8 Apr 2019 15:39:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com
Subject: Re: [PATCH v3 2/4] mfd: cros_ec: instantiate properly CrOS ISH MCU
 device
Message-ID: <20190408123915.GP9224@smile.fi.intel.com>
References: <20190408094141.27858-1-enric.balletbo@collabora.com>
 <20190408094141.27858-3-enric.balletbo@collabora.com>
 <20190408102825.GJ9224@smile.fi.intel.com>
 <565c3640-97ab-4a8c-e5bd-fb47d3fd3dfb@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565c3640-97ab-4a8c-e5bd-fb47d3fd3dfb@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 12:39:48PM +0200, Enric Balletbo i Serra wrote:
> On 8/4/19 12:28, Andy Shevchenko wrote:
> > On Mon, Apr 08, 2019 at 11:41:39AM +0200, Enric Balletbo i Serra wrote:
> >> From: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
> >>
> >> Integrated Sensor Hub (ISH) is also a MCU running EC
> >> having feature bit EC_FEATURE_ISH. Instantiate it as
> >> a special CrOS EC device with device name 'cros_ish'.
> > 
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > 
> >> Changes in v3:
> >> - Fix Andy Shevchenko email.
> > 
> 
> The fix was s/andry/andriy/ For some reason I missed an 'i' in your name and the
> email obviously bounced for your address.
> 
> > I'm not sure what it means.
> > I'm using @linux.intel.com for OSS work.
> > 
> 
> Seems that you used andriy.shevchenko@intel.com instead, see:

Oh, that's my mistake. I guess, the original mail had my @intel.com instead of
@linux.intel.com and I blindly copied that.

> 
> https://lore.kernel.org/patchwork/patch/1047022/
> 
> The part that says:
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


