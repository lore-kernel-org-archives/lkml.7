Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FC2C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC7F2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393010AbfIFKDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:03:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:17260 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388537AbfIFKDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:03:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 03:03:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="177594355"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2019 03:03:30 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6B5V-0004c4-Bu; Fri, 06 Sep 2019 13:03:29 +0300
Date:   Fri, 6 Sep 2019 13:03:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 5/9] Remove unused %*pE[achnops] formats
Message-ID: <20190906100329.GM2680@smile.fi.intel.com>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <1567712673-1629-5-git-send-email-bfields@redhat.com>
 <20190906100141.GL2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906100141.GL2680@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 01:01:41PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 05, 2019 at 03:44:29PM -0400, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > The [achnops] are confusing, and in practice the only one anyone seems
> > to need is the bare %*pE.
> > 
> > I think some set of modifiers here might actually be useful, but the
> > ones we have are confusing and unused, so let's just toss these out and
> > then rethink what we might want to add back later.
> 
> Have you evaluated potential users of this API. Do they need anything of the
> existing functionality?
> 
> mangle_path()
> tomoyo_print_bprm()
> tomoyo_scan_bprm()
> tomoyo_environ()
> tomoyo_encode2()
> tomoyo_const_part_length()
> 
> Maybe there are more, I didn't check it carefully.

This is comment basically to the absent cover letter, means to the entire
series.

-- 
With Best Regards,
Andy Shevchenko


