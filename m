Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD4C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC2321734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgABJuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:50:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:51088 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgABJup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:50:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 01:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,386,1571727600"; 
   d="scan'208";a="224734562"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 02 Jan 2020 01:50:40 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 02 Jan 2020 11:50:40 +0200
Date:   Thu, 2 Jan 2020 11:50:40 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/37] platform/x86: intel_pmc_ipc: Move under MFD
Message-ID: <20200102095040.GE465886@lahna.fi.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
 <20191223141716.13727-34-mika.westerberg@linux.intel.com>
 <20200102094126.GG22390@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102094126.GG22390@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 09:41:26AM +0000, Lee Jones wrote:
> On Mon, 23 Dec 2019, Mika Westerberg wrote:
> 
> > This driver only creates a bunch of platform devices sharing resources
> > belonging to the PMC device. This is pretty much what MFD subsystem is
> > for so move the driver there, renaming it to intel_pmc_bxt.c which
> > should be more clear what it is. We convert the driver to call MFD APIs
> > in subsequent patches.
> 
> Nope.  Not happening.
> 
> It's not appropriate to dump a 1000+ line source file into MFD without
> a thorough review.  For starters, the 100's of lines of code which
> support the bespoke IPC APIs should remain within the 'platform'
> domain.
> 
> It's okay to move the subordinate device registration into MFD, but it
> will need to be converted *whilst* transferring it, rather than the
> dump/edit method currently implemented.

OK, will do so in v2.
