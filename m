Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F73CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA342173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfC1OAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:00:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:44289 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfC1OAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:00:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 07:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="126639493"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2019 07:00:40 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9VaB-00038X-6R; Thu, 28 Mar 2019 16:00:39 +0200
Date:   Thu, 28 Mar 2019 16:00:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] x86/boot: Support nocfg parameter for earlyprintk
Message-ID: <20190328140039.GC9224@smile.fi.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
 <20190328130317.GG22720@zn.tnic>
 <20190328132153.GZ9224@smile.fi.intel.com>
 <20190328134213.GJ22720@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328134213.GJ22720@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 02:42:13PM +0100, Borislav Petkov wrote:
> On Thu, Mar 28, 2019 at 03:21:53PM +0200, Andy Shevchenko wrote:
> > If the connection to the target is done via serial interface and
> > firmware and / or bootloader already did necessary configuration.
> 
> Again: how is the user supposed to know that?

How one knows that she is typing on keyboard right now and not on touch screen?
I really don't get this. User either knows this beforehand or doesn't care.
Maybe she needs to read documentation on hardware at some point?

> When a user sees "nocfg"'s
> documentation, how is the user supposed to decide whether she needs
> to supply nocfg or not?

The problem nocfg tries to solve is a hard coded default baud rate and
impossibility to know at this stage all parameters of the serial interface.

> Which exact setups will need to supply nocfg on the cmdline?

If it's _non-standard_ serial interface (by meaning of I/O accessors and port
addresses), user may consider to use this options in case the interface to
communicate with kernel is serial one and its configuration is done by other
means (firmware / bootloader / EFI / etc).

-- 
With Best Regards,
Andy Shevchenko


