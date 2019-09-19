Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E0DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7700F2196F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405192AbfISWGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:06:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:11226 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405162AbfISWGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:06:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 15:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,526,1559545200"; 
   d="scan'208";a="189746329"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 19 Sep 2019 15:06:15 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 351E23013C9; Thu, 19 Sep 2019 15:06:15 -0700 (PDT)
Date:   Thu, 19 Sep 2019 15:06:15 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@suse.de>, Martin Liska <mliska@suse.cz>,
        Luke Mujica <lukemujica@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/5] perf list: specify metrics are to be used with -M
Message-ID: <20190919220615.GG8537@tassilo.jf.intel.com>
References: <20190919204306.12598-1-kim.phillips@amd.com>
 <20190919204306.12598-5-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919204306.12598-5-kim.phillips@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This misleads the uninitiated user to try:
> 
>   $ perf stat -e C2_Pkg_Residency

Actually I guess we could just fix -e to support metrics too.
Would probably not be that difficult.

-Andi
