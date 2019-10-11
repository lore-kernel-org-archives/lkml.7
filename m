Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39BCC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F64206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfJKQFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:05:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:10104 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfJKQFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:05:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 09:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="278166191"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 11 Oct 2019 09:05:42 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iIxQD-0001Rq-7i; Fri, 11 Oct 2019 19:05:41 +0300
Date:   Fri, 11 Oct 2019 19:05:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: Convert ipmi_debug_msg to pr_debug and use %*ph
Message-ID: <20191011160541.GG32742@smile.fi.intel.com>
References: <20191011145213.65082-1-andriy.shevchenko@linux.intel.com>
 <4eaca9a1bcbf9d87c1fb3c9135876c3ecb72a91b.camel@perches.com>
 <20191011151220.GB32742@smile.fi.intel.com>
 <e0b24ff49eb69a216b11f97db1fc26c5d3b971b4.camel@perches.com>
 <7831759661d9f3d47bd304b2e98e65e5d6c5d167.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7831759661d9f3d47bd304b2e98e65e5d6c5d167.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 08:46:41AM -0700, Joe Perches wrote:
> Using %*ph format to print small buffers as hex string reduces
> overall object size and allows the removal of the two variants
> of ipmi_debug_msg.
> 
> This also removes unnecessary duplicate colons from output when
> enabled by #DEBUG or newly possible CONFIG_DYNAMIC_DEBUG.

I have sent v2 with slightly better approach (no need to have %s).

-- 
With Best Regards,
Andy Shevchenko


