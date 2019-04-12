Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76065C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CB4206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfDLLju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:39:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:12704 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfDLLjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:39:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 04:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="336687233"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2019 04:39:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] perf scripts python: Support pyside2 and misc Intel PT
Date:   Fri, 12 Apr 2019 14:38:22 +0300
Message-Id: <20190412113830.4126-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are patches to add support for pyside2 to the db-export scripts,
and a couple of Intel PT patches.


Adrian Hunter (8):
      perf scripts python: exported-sql-viewer.py: Change python2 to python
      perf scripts python: exported-sql-viewer.py: Use argparse module for argument parsing
      perf scripts python: exported-sql-viewer.py: Add support for pyside2
      perf scripts python: export-to-sqlite.py: Add support for pyside2
      perf scripts python: export-to-postgresql.py: Add support for pyside2
      perf tools: perf-with-kcore.sh: Always allow fix_buildid_cache_permissions
      perf intel-pt: Improve sync_switch
      perf intel-pt: Rationalize intel_pt_sync_switch()'s use of next_tid

 tools/perf/perf-with-kcore.sh                     |  5 ---
 tools/perf/scripts/python/export-to-postgresql.py | 43 +++++++++++++++----
 tools/perf/scripts/python/export-to-sqlite.py     | 44 ++++++++++++++++---
 tools/perf/scripts/python/exported-sql-viewer.py  | 51 ++++++++++++++++-------
 tools/perf/util/intel-pt.c                        | 44 +++++++++++++++++--
 5 files changed, 150 insertions(+), 37 deletions(-)


Regards
Adrian
