Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DEAC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B197020880
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbfHFIqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:46:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:37884 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbfHFIqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:46:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 01:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="202738548"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.183])
  by fmsmga002.fm.intel.com with ESMTP; 06 Aug 2019 01:37:40 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v5 1/7] perf: Allow normal events to output AUX data
In-Reply-To: <20190806072433.26820-2-alexander.shishkin@linux.intel.com>
References: <20190806072433.26820-1-alexander.shishkin@linux.intel.com> <20190806072433.26820-2-alexander.shishkin@linux.intel.com>
Date:   Tue, 06 Aug 2019 11:37:40 +0300
Message-ID: <87v9va3d0r.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -246,6 +246,7 @@ struct perf_event;
>  #define PERF_PMU_CAP_ITRACE			0x20
>  #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
>  #define PERF_PMU_CAP_NO_EXCLUDE			0x80
> +#define PERF_PMU_CAP_AUX_SOURCE			0x100

Please disregard this series, this obviously needs to be AUX_OUTPUT
also.

Regards,
--
Alex
