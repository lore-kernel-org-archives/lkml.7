Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF75ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09842089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439647AbfJQJw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:52:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:16329 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392771AbfJQJw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:52:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 02:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,307,1566889200"; 
   d="scan'208";a="371084872"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 17 Oct 2019 02:52:54 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iL2Sj-0002Cx-B3; Thu, 17 Oct 2019 12:52:53 +0300
Date:   Thu, 17 Oct 2019 12:52:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Tuowen Zhao <ztuowen@gmail.com>, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, acelan.kao@canonical.com,
        mcgrof@kernel.org, davem@davemloft.net
Subject: Re: [PATCH v5 0/4] Fix MTRR bug for intel-lpss-pci
Message-ID: <20191017095253.GF32742@smile.fi.intel.com>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
 <20191017071409.GC32742@smile.fi.intel.com>
 <20191017073116.GM4365@dell>
 <20191017080400.GE32742@smile.fi.intel.com>
 <20191017082201.GN4365@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017082201.GN4365@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 09:22:01AM +0100, Lee Jones wrote:
> On Thu, 17 Oct 2019, Andy Shevchenko wrote:
> > On Thu, Oct 17, 2019 at 08:31:16AM +0100, Lee Jones wrote:
> > > On Thu, 17 Oct 2019, Andy Shevchenko wrote:
> > > > On Wed, Oct 16, 2019 at 03:06:25PM -0600, Tuowen Zhao wrote:
> > > > > Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
> > > > > in MTRR. This will cause the system to hang during boot. If possible,
> > > > > this bug could be corrected with a firmware update.
> > > > > 
> > > > > Previous version: https://lkml.org/lkml/2019/10/14/575
> > > > > 
> > > > > Changes from previous version:
> > > > > 
> > > > >  * implement ioremap_uc for sparc64
> > > > >  * split docs changes to not CC stable (doc location moved since 5.3)
> > > > > 
> > > > 
> > > > It forgot to explicitly mention through which tree is supposed to go.
> > > > I think it's MFD one, correct?
> > > 
> > > To be fair, that's not really up to the submitter to decide.
> > 
> > Submitter still can share their view, no?
> 
> Preferences can be voiced, if held, and will always be taken into
> consideration.  The final decision will always be made by the people
> managing the trees.
> 
> The comment above implies a requirement to specify which tree is
> preferred, which is not the case.  In almost all cases, it's best not
> to specify.

In my practice I had been asked several times to specify and express my
understanding which subsystem should take series. It's not so unequivocally.

-- 
With Best Regards,
Andy Shevchenko


