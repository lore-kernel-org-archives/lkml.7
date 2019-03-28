Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AC3206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfC1OtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:49:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:24796 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfC1OtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:49:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 07:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="311171368"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2019 07:49:15 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9WLB-0003bV-TE; Thu, 28 Mar 2019 16:49:13 +0200
Date:   Thu, 28 Mar 2019 16:49:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Joe Perches <joe@perches.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] x86/boot: Split out parse_serial_port() helper
 for earlyprintk
Message-ID: <20190328144913.GG9224@smile.fi.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-4-andriy.shevchenko@linux.intel.com>
 <20190328123504.GF22720@zn.tnic>
 <20190328131557.GY9224@smile.fi.intel.com>
 <20190328133907.GI22720@zn.tnic>
 <20190328135015.GA9224@smile.fi.intel.com>
 <20190328140329.GK22720@zn.tnic>
 <20190328142302.GE9224@smile.fi.intel.com>
 <20190328143535.GO22720@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328143535.GO22720@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:35:35PM +0100, Borislav Petkov wrote:
> On Thu, Mar 28, 2019 at 04:23:02PM +0200, Andy Shevchenko wrote:
> > If it's strong opinion, I consider this rather as NAK.
> > Thank you for review.
> 
> Your call.

Yes, as I said I won't uglify code to pursue kstrtox() whim.
Thanks again!

-- 
With Best Regards,
Andy Shevchenko


