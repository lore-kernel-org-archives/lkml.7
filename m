Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AABEC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F8120863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfCSP57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:57:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:51938 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfCSP56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:57:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 08:57:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,498,1544515200"; 
   d="scan'208";a="284000654"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga004.jf.intel.com with ESMTP; 19 Mar 2019 08:57:57 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9C08C301BB6; Tue, 19 Mar 2019 08:57:57 -0700 (PDT)
Date:   Tue, 19 Mar 2019 08:57:57 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 05/22] perf/x86: Support constraint ranges
Message-ID: <20190319155757.GV24002@tassilo.jf.intel.com>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-6-kan.liang@linux.intel.com>
 <20190319145309.GI5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319145309.GI5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  struct amd_nb {
> >  	int nb_id;  /* NorthBridge id */
> 
> That's all the code, how does that add up to 2k ?

Because the tables are bigger. There are much more tables than code.

In theory could use two kinds of tables, but that would complicate
the code quite a bit.

-Andi

