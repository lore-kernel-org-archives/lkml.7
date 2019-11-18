Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08661C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18D5222A0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKRSXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:23:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:23548 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfKRSXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:23:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 10:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="204151190"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 18 Nov 2019 10:23:47 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1iWlgg-0006ND-VI; Mon, 18 Nov 2019 20:23:46 +0200
Date:   Mon, 18 Nov 2019 20:23:46 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Kammela, Gayatri" <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v3 0/7] x86/intel_pmc_core: Add Tiger Lake, Elkhart Lake
Message-ID: <20191118182346.GB32742@smile.fi.intel.com>
References: <cover.1573750525.git.gayatri.kammela@intel.com>
 <CAHp75Vfrd-BAZ7H_LuQfz32yaap1X3gEnqZ2-9EPQ+j_b0f93g@mail.gmail.com>
 <MN2PR11MB3711EDFC967C295689E109DEF24D0@MN2PR11MB3711.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR11MB3711EDFC967C295689E109DEF24D0@MN2PR11MB3711.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 06:11:16PM +0000, Kammela, Gayatri wrote:
> > > All the information regarding the PCH IPs and names of IPs will be
> > > available in Intel's Platform Controller Hub (PCH) External Design
> > > Specification (EDS) document expected to be released in 2020 before
> > > product launch.
> > 
> > Thanks, though you forgot to fix all prefixes in the mails. We have
> > platform/x86: $DRIVER_NAME: ...
> > 
> Hi Andy! Sorry I think I misunderstood your comment last time. Just to make sure, the prefix should the pattern in this case
> "platform/x86: intel_pmc_core: " and should be same for all the patches in the series right?

I didn't deeply check myself, but sounds right.

> > Also consider Mario's comment (I didn't hear back from you on it).
> Sorry about that. I am planning on sending it a single patch excluding it from the series since we received a request from Dell. Please let me know if you think this patch should be included in the series. 

I think we keep good relationship with Dell.

-- 
With Best Regards,
Andy Shevchenko


