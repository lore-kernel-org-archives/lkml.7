Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4074DC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143A82080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfD3IbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:31:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:22719 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfD3IbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:31:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 01:31:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,413,1549958400"; 
   d="scan'208";a="144800557"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by fmsmga008.fm.intel.com with ESMTP; 30 Apr 2019 01:31:03 -0700
Date:   Tue, 30 Apr 2019 16:35:05 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Eric W Biederman <ebiederm@xmission.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ying Huang <ying.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] latencytop lock usage improvement
Message-ID: <20190430083505.n5mozwybbnwydo3z@shbuild888>
References: <1556525011-28022-1-git-send-email-feng.tang@intel.com>
 <20190430080910.GI2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430080910.GI2623@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Apr 30, 2019 at 10:09:10AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 29, 2019 at 04:03:28PM +0800, Feng Tang wrote:
> > Hi All,
> > 
> > latencytop is a very nice tool for tracing system latency hotspots, and
> > we heavily use it in our LKP test suites.
> 
> What data does latency-top give that perf cannot give you? Ideally we'd
> remove latencytop entirely.

Thanks for the review. In 0day/LKP test service, we have many tools for
monitoring and analyzing the test results, perf is the most important
one, which has the most parts in our auto-generated comparing results.   
For example to identify spinlock contentions and system hotspots.

latencytop is another tool we used to find why systems go idle, like why
workload chose to sleep or waiting for something. 

Thanks,
Feng
