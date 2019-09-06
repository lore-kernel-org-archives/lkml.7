Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B18C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B59220854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404621AbfIFJic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:38:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:29299 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730623AbfIFJib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:38:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 02:38:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="334841754"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 06 Sep 2019 02:38:30 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6AhJ-0004N1-2z; Fri, 06 Sep 2019 12:38:29 +0300
Date:   Fri, 6 Sep 2019 12:38:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] rtl8192*: display ESSIDs using %pE
Message-ID: <20190906093829.GK2680@smile.fi.intel.com>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <201909051352.89D121A4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909051352.89D121A4@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 01:53:43PM -0700, Kees Cook wrote:
> On Thu, Sep 05, 2019 at 03:44:25PM -0400, J. Bruce Fields wrote:
> > From: "J. Bruce Fields" <bfields@redhat.com>
> > 
> > Everywhere else in the kernel ESSIDs are printed using %pE, and I can't
> > see why there should be an exception here.
> 
> I would expand this rationale slightly: using "n" here makes no sense
> because they are already NUL-terminated strings. The "n" modifier could
> only be used with string_escape_mem() which takes a "length" argument.

SSID may have NUL in any location in the name.

> > -	snprintf(escaped, sizeof(escaped), "%*pEn", essid_len, essid);
> > +	snprintf(escaped, sizeof(escaped), "%*pE", essid_len, essid);

> > -	snprintf(escaped, sizeof(escaped), "%*pEn", essid_len, essid);
> > +	snprintf(escaped, sizeof(escaped), "%*pE", essid_len, essid);

-- 
With Best Regards,
Andy Shevchenko


