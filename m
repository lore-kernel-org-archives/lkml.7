Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183EBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7108206E1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfLCDAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:00:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:2520 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfLCDAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:00:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 19:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,271,1571727600"; 
   d="scan'208";a="410674991"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga005.fm.intel.com with ESMTP; 02 Dec 2019 19:00:31 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 9C876300B57; Mon,  2 Dec 2019 19:00:31 -0800 (PST)
Date:   Mon, 2 Dec 2019 19:00:31 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     roman.sudarikov@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bgregg@netflix.com,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        alexander.antonov@intel.com
Subject: Re: [PATCH 1/6] perf x86: Infrastructure for exposing an Uncore unit
 to PMON mapping
Message-ID: <20191203030031.GP84886@tassilo.jf.intel.com>
References: <20191126163630.17300-1-roman.sudarikov@linux.intel.com>
 <20191126163630.17300-2-roman.sudarikov@linux.intel.com>
 <CABPqkBQ0Ukn3RXB2516Qpz3_hGEzOgUA-JcFwBcdDfPPj4bVNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQ0Ukn3RXB2516Qpz3_hGEzOgUA-JcFwBcdDfPPj4bVNQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You are just looking at one die (package). How does your enumeration
> help figure out
> is the iio_0 is on socket0 of socket1 and then figure out which
> bus/domain in on which
> socket.
> 
> And how does that help map actual devices (using the output of lspci)
> to the IIO?
> You need to show how you would do that, which is really what people
> want, with what you
> have in your patch right now.

See the rest of the patch series. It implements all of this in
the perf tool.

-Andi
