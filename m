Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5464AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E55C2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfCTQPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:15:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:62068 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfCTQPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:15:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 09:15:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="133232321"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga008.fm.intel.com with ESMTP; 20 Mar 2019 09:15:44 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h6dsV-0001w1-6G; Wed, 20 Mar 2019 18:15:43 +0200
Date:   Wed, 20 Mar 2019 18:15:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] x86/boot: Support nocfg parameter for earlyprintk
Message-ID: <20190320161543.GH9224@smile.fi.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
 <8742b0a2-de4e-9865-cb3e-dfda0dec6a0a@infradead.org>
 <20190320151715.GG9224@smile.fi.intel.com>
 <415863c9-8a06-f392-a558-bce694069d09@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415863c9-8a06-f392-a558-bce694069d09@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 08:19:46AM -0700, Randy Dunlap wrote:
> On 3/20/19 8:17 AM, Andy Shevchenko wrote:
> > On Wed, Mar 20, 2019 at 08:05:51AM -0700, Randy Dunlap wrote:
> >> On 3/19/19 11:43 AM, Andy Shevchenko wrote:

> >>> Add support of 'nocfg' parameter to earlyprintk.
> > 
> >> Please add "nocfg" to Documentation/admin-guide/kernel-parameters.txt.
> > 
> > I think it's not a time right now to do so. This only does it for boot stage.

> OK.   Is there somewhere else that it could be added to Documentation/[x86/]?

I don't see the proper place.

I think this is can be added when it would be recognized by next stage of
earlyprintk.

-- 
With Best Regards,
Andy Shevchenko


