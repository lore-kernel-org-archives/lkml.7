Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA42CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A616720823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfC1OXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:23:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:61110 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfC1OXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:23:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 07:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="159237906"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2019 07:23:03 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9Vvq-0003Ow-FN; Thu, 28 Mar 2019 16:23:02 +0200
Date:   Thu, 28 Mar 2019 16:23:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Joe Perches <joe@perches.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] x86/boot: Split out parse_serial_port() helper
 for earlyprintk
Message-ID: <20190328142302.GE9224@smile.fi.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-4-andriy.shevchenko@linux.intel.com>
 <20190328123504.GF22720@zn.tnic>
 <20190328131557.GY9224@smile.fi.intel.com>
 <20190328133907.GI22720@zn.tnic>
 <20190328135015.GA9224@smile.fi.intel.com>
 <20190328140329.GK22720@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328140329.GK22720@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:03:29PM +0100, Borislav Petkov wrote:
> On Thu, Mar 28, 2019 at 03:50:15PM +0200, Andy Shevchenko wrote:
> > Can, but with code uglifying to workaround kstrtox() restrictions.
> > simple_strtox() _just works_ as expected.
> 
> simple_strtox() also has its problems.

Yes! And point here: we do not care.

> > Requires buffer copying, finding digits there, making a proper termination. And
> 
> It needs a single kstrtoull() call to parse the port. 

No, it does not. It needs more as I described. Have you investigated a topic?
Have you seen all possible combinations of input here?

> And we have
> kstrtoull() available in the compressed stage so pls do the conversion
> ontop.

If it's strong opinion, I consider this rather as NAK.
Thank you for review.

-- 
With Best Regards,
Andy Shevchenko


