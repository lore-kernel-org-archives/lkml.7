Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB0EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B707D22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfHTNWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:22:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:20738 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729810AbfHTNWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:22:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 06:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="169081732"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga007.jf.intel.com with ESMTP; 20 Aug 2019 06:22:15 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i045U-0003hc-0d; Tue, 20 Aug 2019 16:22:12 +0300
Date:   Tue, 20 Aug 2019 16:22:12 +0300
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "alan@linux.intel.com" <alan@linux.intel.com>,
        "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Tanwar, Rahul" <rahul.tanwar@intel.com>
Subject: Re: [PATCH v2 2/3] x86/cpu: Add new Intel Atom CPU model name
Message-ID: <20190820132212.GM30120@smile.fi.intel.com>
References: <cover.1565940653.git.rahul.tanwar@linux.intel.com>
 <83345984845d24b6ce97a32bef21cd0bbdffc86d.1565940653.git.rahul.tanwar@linux.intel.com>
 <20190820122233.GN2332@hirez.programming.kicks-ass.net>
 <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1D9AE27C-D412-412D-8FE8-51B625A7CC98@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:48:05PM +0300, Luck, Tony wrote:
> 
> >> +#define INTEL_FAM6_ATOM_AIRMONT_NP    0x75 /* Lightning Mountain */
> > 
> > What's _NP ?
> 
> Network Processor. But that is too narrow a descriptor. This is going to be used in
> other areas besides networking. 
> 
> I’m contemplating calling it AIRMONT2

We used to have something like that for Silvermont. It was confusing.

commit f2c4db1bd80720cd8cb2a5aa220d9bc9f374f04e
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Aug 7 10:17:27 2018 -0700

    x86/cpu: Sanitize FAM6_ATOM naming


What 2 or 3 or other number means?

-- 
With Best Regards,
Andy Shevchenko


