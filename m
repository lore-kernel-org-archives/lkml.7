Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD4BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D8C2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfCTPRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:17:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:28672 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbfCTPRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:17:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 08:17:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,249,1549958400"; 
   d="scan'208";a="154098705"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 20 Mar 2019 08:17:16 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h6cxv-0001Ip-Ns; Wed, 20 Mar 2019 17:17:15 +0200
Date:   Wed, 20 Mar 2019 17:17:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] x86/boot: Support nocfg parameter for earlyprintk
Message-ID: <20190320151715.GG9224@smile.fi.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
 <8742b0a2-de4e-9865-cb3e-dfda0dec6a0a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8742b0a2-de4e-9865-cb3e-dfda0dec6a0a@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 08:05:51AM -0700, Randy Dunlap wrote:
> On 3/19/19 11:43 AM, Andy Shevchenko wrote:
> > If by BIOS or by other means the serial port is configured
> > user might want to skip reconfiguration in the boot code.
> > 
> > Add support of 'nocfg' parameter to earlyprintk.

> Please add "nocfg" to Documentation/admin-guide/kernel-parameters.txt.

I think it's not a time right now to do so. This only does it for boot stage.


-- 
With Best Regards,
Andy Shevchenko


