Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFA8C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213CA2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfD2H3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:29:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:41476 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfD2H3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:29:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 00:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="138322306"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga008.jf.intel.com with ESMTP; 29 Apr 2019 00:29:42 -0700
Subject: Re: [PATCH 0/8] perf scripts python: Support pyside2 and misc Intel
 PT
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20190412113830.4126-1-adrian.hunter@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <10798ccb-7da8-1f29-2a75-bf3aeeb29c96@intel.com>
Date:   Mon, 29 Apr 2019 10:28:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412113830.4126-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/19 2:38 PM, Adrian Hunter wrote:
> Hi
> 
> Here are patches to add support for pyside2 to the db-export scripts,
> and a couple of Intel PT patches.
> 
> 
> Adrian Hunter (8):
>       perf scripts python: exported-sql-viewer.py: Change python2 to python
>       perf scripts python: exported-sql-viewer.py: Use argparse module for argument parsing
>       perf scripts python: exported-sql-viewer.py: Add support for pyside2
>       perf scripts python: export-to-sqlite.py: Add support for pyside2
>       perf scripts python: export-to-postgresql.py: Add support for pyside2
>       perf tools: perf-with-kcore.sh: Always allow fix_buildid_cache_permissions
>       perf intel-pt: Improve sync_switch
>       perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid
> 
>  tools/perf/perf-with-kcore.sh                     |  5 ---
>  tools/perf/scripts/python/export-to-postgresql.py | 43 +++++++++++++++----
>  tools/perf/scripts/python/export-to-sqlite.py     | 44 ++++++++++++++++---
>  tools/perf/scripts/python/exported-sql-viewer.py  | 51 ++++++++++++++++-------
>  tools/perf/util/intel-pt.c                        | 44 +++++++++++++++++--
>  5 files changed, 150 insertions(+), 37 deletions(-)

Are these ok?

