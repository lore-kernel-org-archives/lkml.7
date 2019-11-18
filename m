Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD288C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFFF2192B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfKRRsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:48:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:13523 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfKRRsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:48:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 09:48:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="258471455"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2019 09:48:29 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iWl8W-0005wT-OC; Mon, 18 Nov 2019 19:48:28 +0200
Date:   Mon, 18 Nov 2019 19:48:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        prarit@redhat.com, rafael.j.wysocki@intel.co,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] admin guide/pm: Admin guide for intel-speed-select
Message-ID: <20191118174828.GY32742@smile.fi.intel.com>
References: <20191115204925.55181-1-srinivas.pandruvada@linux.intel.com>
 <20191118104105.11776f58@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191118104105.11776f58@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:41:05AM -0700, Jonathan Corbet wrote:
> On Fri, 15 Nov 2019 12:49:25 -0800
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> > Added documentation to configure servers to use Intel(R) Speed
> > Select Technology using intel-speed-select tool.

> > +=========================================================
> > +Intel® Speed Select Technology (Intel® SST) : User Guide
> > +=========================================================
> 
> People give me grief when I take docs patches adding non-ascii characters.
> Adding nearly 100 useless ® symbols seems likely to trigger that sort of
> unicode aversion.  Can I ask you, please, to take those out?  There are
> many occurrences of unadorned "Intel" in the kernel, and the world hasn't
> ended yet.

Side comment. It's really strange to hear above in 21st centure. We are living
in Unicode times. How harm unicode characters nowadays?

-- 
With Best Regards,
Andy Shevchenko


