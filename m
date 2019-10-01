Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622C3C32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3536320815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfJACUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 22:20:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:33142 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfJACUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 22:20:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 19:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,569,1559545200"; 
   d="scan'208";a="194381692"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2019 19:20:06 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 466EA301B07; Mon, 30 Sep 2019 19:20:06 -0700 (PDT)
Date:   Mon, 30 Sep 2019 19:20:06 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/4] perf inject --jit: Remove //anon mmap events
Message-ID: <20191001022006.GG8560@tassilo.jf.intel.com>
References: <BN8PR21MB13625F8AD3E9C67C0918A750F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
 <20190929152721.GB16309@krava>
 <BN8PR21MB136251826C3C22C6BCCF17B5F7820@BN8PR21MB1362.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB136251826C3C22C6BCCF17B5F7820@BN8PR21MB1362.namprd21.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 08:49:00PM +0000, Steve MacLean wrote:
> SNIP
> 
> > I can't apply this one:
> 
> > patching file builtin-inject.c
> > Hunk #1 FAILED at 263.
> > 1 out of 1 hunk FAILED -- saving rejects to file builtin-inject.c.rej 
> 
> I assume this is because I based my patches on the wrong tip.
> 
> > patching file util/jitdump.c
> > patch: **** malformed patch at line 236: btree, node);
> 
> This doesn't make sense to me.  The patch doesn't try to inject near line 236. There aren't 236 lines in the e-mail....

Most likely your mail client did line wrap.

See Documentation/process/email-clients.rst

-Andi
