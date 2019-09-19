Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A23C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535F721920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405444AbfISWJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:09:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:16405 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405428AbfISWJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:09:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 15:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,526,1559545200"; 
   d="scan'208";a="189747060"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 19 Sep 2019 15:09:28 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A4F4A3013C9; Thu, 19 Sep 2019 15:09:28 -0700 (PDT)
Date:   Thu, 19 Sep 2019 15:09:28 -0700
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
Subject: Re: [PATCH 3/5] perf vendor events: minor fixes to the README
Message-ID: <20190919220928.GH8537@tassilo.jf.intel.com>
References: <20190919204306.12598-1-kim.phillips@amd.com>
 <20190919204306.12598-3-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919204306.12598-3-kim.phillips@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all the patches except the last

Reviewed-by: Andi Kleen <ak@linux.intel.com>
