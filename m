Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA33C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306B121874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbfIBJeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:34:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:29753 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731116AbfIBJeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:34:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 02:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="382747800"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 02 Sep 2019 02:34:07 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i4iis-0007xT-RM; Mon, 02 Sep 2019 12:34:06 +0300
Date:   Mon, 2 Sep 2019 12:34:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Divya Indi <divya.indi@oracle.com>
Subject: Re: [PATCH v1] tracing: Drop static keyword for exported
 ftrace_set_clr_event()
Message-ID: <20190902093406.GS2680@smile.fi.intel.com>
References: <20190830193228.65446-1-andriy.shevchenko@linux.intel.com>
 <20190830170424.40c4188a@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830170424.40c4188a@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 05:04:24PM -0400, Steven Rostedt wrote:
> On Fri, 30 Aug 2019 22:32:28 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > When we export something, it shan't be static.
> 
> I'm finally getting around to my patch queue (it's unfortunately much
> bigger than I should be). But my punishment is duplicate patches.
> 
> Someone beat you to it...
> 
>  http://lkml.kernel.org/r/20190704172110.27041-1-efremov@linux.com

Looking to the original patch and taking into account that there is no user for
it, I guess the best option to simple revert original one (it will clean up
export table).

-- 
With Best Regards,
Andy Shevchenko


