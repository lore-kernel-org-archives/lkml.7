Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AF9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2EE20674
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbfIFKUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:20:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:24879 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbfIFKU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:20:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 03:20:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,472,1559545200"; 
   d="scan'208";a="188273170"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2019 03:20:28 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i6BLu-0004wy-Qh; Fri, 06 Sep 2019 13:20:26 +0300
Date:   Fri, 6 Sep 2019 13:20:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 9/9] Remove string_escape_mem_ascii
Message-ID: <20190906102026.GO2680@smile.fi.intel.com>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
 <1567712673-1629-9-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567712673-1629-9-git-send-email-bfields@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 03:44:33PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> It's easier to do this in string_escape_mem now.
> 
> Might also consider non-ascii and quote-mark sprintf modifiers and then
> we might make do with seq_printk.

No SoB :-)
Entire series forgot to include RFC prefix.

Nevertheless, this one I like independently on what we decide about flags.

> -	ret = string_escape_mem_ascii(src, isz, buf, size);
> +	ret = string_escape_mem(src, isz, buf, size, ESCAPE_NP|ESCAPE_NONASCII|
> +				ESCAPE_STYLE_SLASH|ESCAPE_STYLE_HEX, "\"\\");

Perhaps,

	unsigned int flags = FLAG1 | FLAG2 ...;

-- 
With Best Regards,
Andy Shevchenko


