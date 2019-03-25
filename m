Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0108EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB922075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfCYPBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:01:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:20370 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfCYPBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:01:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 08:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="310255700"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga005.jf.intel.com with ESMTP; 25 Mar 2019 08:01:43 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h8R6c-0006xu-O5; Mon, 25 Mar 2019 17:01:42 +0200
Date:   Mon, 25 Mar 2019 17:01:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: acpi: Add an example for PRP0001
Message-ID: <20190325150142.GE9224@smile.fi.intel.com>
References: <20190322134705.27994-1-thomas.preston@codethink.co.uk>
 <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
 <20190325115118.GP9224@smile.fi.intel.com>
 <20190325130413.GT9224@smile.fi.intel.com>
 <d67bb260-863c-1131-1323-711c3d2e227d@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d67bb260-863c-1131-1323-711c3d2e227d@codethink.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 02:42:09PM +0000, Thomas Preston wrote:
> On 25/03/2019 13:04, Andy Shevchenko wrote:
> > On Mon, Mar 25, 2019 at 01:51:18PM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 25, 2019 at 10:31:13AM +0100, Rafael J. Wysocki wrote:

> > > Though one thing I would like to add (not directly related to the patch
> > > per se), i.e. it would be nice to keep such examples under meta-acpi [1]
> > > umbrella as a database for such excerpts.
> > > 
> > > Thomas, can you do that?
> > > 
> > > [1]: https://github.com/westeri/meta-acpi
> 
> I will :)

Thank you! I will take either GH PR, or you may send an email to maintainers,
i.e. Mika and me (PR is preferable because it would be seen publicly)

> > > > > +               Name (_HID, "TITMP75") /* _HID will appear in sysfs */
> > 
> > Sorry for not noticing earlier.
> > 
> > Is this an official ID for the chip? We discourage people to invent ACPI IDs on
> > their own.

> The device is a TI tmp75b temperature sensor [0]. The HID is completely
> made up, I'm afraid. It doesn't exist in the registry.

Thanks for clarification. In that case I would rather recommend to use simple
PRP0001 as a _HID.

> [0] http://www.ti.com/lit/ds/symlink/tmp75b.pdf

-- 
With Best Regards,
Andy Shevchenko


