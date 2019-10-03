Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5ABC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9878218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfJCLCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:02:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:22028 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbfJCLCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:02:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 04:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,251,1566889200"; 
   d="scan'208";a="275678772"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by orsmga001.jf.intel.com with ESMTP; 03 Oct 2019 04:02:36 -0700
Subject: Re: [PATCH 0/6] perf scripts python: exported-sql-viewer.py: Add Time
 chart by CPU
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20190821083216.1340-1-adrian.hunter@intel.com>
 <6f55cdb7-a431-bd1b-8e7f-f8caf92399af@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ed9138ac-d035-1be7-9fbd-e82e7f9ca6d0@intel.com>
Date:   Thu, 3 Oct 2019 14:01:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6f55cdb7-a431-bd1b-8e7f-f8caf92399af@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/09/19 11:57 AM, Adrian Hunter wrote:
> On 21/08/19 11:32 AM, Adrian Hunter wrote:
>> Hi
>>
>> These patches to exported-sql-viewer.py, add a time chart based on context
>> switch information.  Context switch information was added to the database
>> export fairly recently, so the chart menu option will only appear if
>> context switch information is in the database.  Refer to the Exported SQL
>> Viewer Help option for more information about the chart.
>>
>>
>> Adrian Hunter (6):
>>       perf scripts python: exported-sql-viewer.py: Add LookupModel()
>>       perf scripts python: exported-sql-viewer.py: Add HBoxLayout and VBoxLayout
>>       perf scripts python: exported-sql-viewer.py: Add global time range calculations
>>       perf scripts python: exported-sql-viewer.py: Tidy up Call tree call_time
>>       perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time
>>       perf scripts python: exported-sql-viewer.py: Add Time chart by CPU
>>
>>  tools/perf/scripts/python/exported-sql-viewer.py | 1555 +++++++++++++++++++++-
>>  1 file changed, 1531 insertions(+), 24 deletions(-)
> 
> Any comments?
> 

ping

