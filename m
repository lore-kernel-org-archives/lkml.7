Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8145C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1C721773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfC1O2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:28:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:57199 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfC1O2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:28:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 07:27:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="156050992"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2019 07:27:57 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9W0a-0003RH-Cm; Thu, 28 Mar 2019 16:27:56 +0200
Date:   Thu, 28 Mar 2019 16:27:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] x86/boot: Support nocfg parameter for earlyprintk
Message-ID: <20190328142756.GF9224@smile.fi.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
 <20190328130317.GG22720@zn.tnic>
 <20190328132153.GZ9224@smile.fi.intel.com>
 <20190328134213.GJ22720@zn.tnic>
 <20190328140039.GC9224@smile.fi.intel.com>
 <20190328141307.GM22720@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328141307.GM22720@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:13:07PM +0100, Borislav Petkov wrote:
> On Thu, Mar 28, 2019 at 04:00:39PM +0200, Andy Shevchenko wrote:
> > If it's _non-standard_ serial interface (by meaning of I/O accessors and port
> > addresses), user may consider to use this options in case the interface to
> > communicate with kernel is serial one and its configuration is done by other
> > means (firmware / bootloader / EFI / etc).
> 
> And is this non-standard interface out there in the wild or only at
> Intel's labs?

Of course in the wild.

> Are there boxes like that out there?

One at hand now is called Intel Edison.

> If I go to the store and buy a box, how do I know whether that box would
> need "nocfg"? Do I look in the BIOS or how do I find out I need to supply
> "nocfg"?

By reading some technical documentation I suppose.
What is your point here? earlyprintk is a mechanism for _debugging_, I suppose
the user should have slightly more knowledge than user.

> > If by BIOS or by other means the serial port is configured
> 
> How do I find out that the serial port is configured?

If you _already_ connected via it and get firmware / bootloader messages.

-- 
With Best Regards,
Andy Shevchenko


