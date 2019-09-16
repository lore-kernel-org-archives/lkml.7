Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA63FC4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC1F20890
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfIPI6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:58:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:49388 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbfIPI6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:58:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 01:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="211088513"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.66])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2019 01:57:58 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] perf record: Put a copy of kcore into the perf.data directory
Date:   Mon, 16 Sep 2019 11:56:44 +0300
Message-Id: <20190916085646.6199-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are 2 patches to add an option to 'perf record' to put a copy of kcore
into a directory with perf.data.  Refer to patch 2 for an example.


Adrian Hunter (2):
      perf tools: Support single perf.data file directory
      perf record: Put a copy of kcore into the perf.data directory

 tools/perf/Documentation/perf-record.txt |  3 ++
 tools/perf/builtin-record.c              | 54 +++++++++++++++++++++++-
 tools/perf/util/data.c                   | 70 +++++++++++++++++++++++++++-----
 tools/perf/util/data.h                   |  8 ++++
 tools/perf/util/header.h                 |  1 +
 tools/perf/util/record.h                 |  1 +
 tools/perf/util/session.c                |  6 ++-
 tools/perf/util/util.c                   | 18 ++++++++
 8 files changed, 149 insertions(+), 12 deletions(-)


Regards
Adrian
