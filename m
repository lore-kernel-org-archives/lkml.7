Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D65DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0182E24BF6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfFDLd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:33:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:41793 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfFDLd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:33:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 04:33:28 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.198]) ([10.237.72.198])
  by orsmga006.jf.intel.com with ESMTP; 04 Jun 2019 04:33:26 -0700
Subject: Re: [PATCH 01/22] perf intel-pt: Fix itrace defaults for perf script
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20190520113728.14389-1-adrian.hunter@intel.com>
 <20190520113728.14389-2-adrian.hunter@intel.com>
 <20190520144516.GL8945@kernel.org> <20190531164547.GC20408@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7f73ed6e-7935-b325-14af-0b9e43144ed4@intel.com>
Date:   Tue, 4 Jun 2019 14:32:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190531164547.GC20408@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/19 7:45 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 20, 2019 at 11:45:16AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, May 20, 2019 at 02:37:07PM +0300, Adrian Hunter escreveu:
>>> Commit 4eb068157121 ("perf script: Make itrace script default to all
>>> calls") does not work because 'use_browser' is being used to determine
>>> whether to default to periodic sampling (i.e. better for perf report).
>>> The result is that nothing but CBR events display for perf script
>>> when no --itrace option is specified.
>>>
>>> Fix by using 'default_no_sample' and 'inject' instead.
>>
>> Applied 1-3 for now, concentrating on fixes, will process 4-22 later.
> 
> Tested the ones that affect sqlite databases an the GUI, all look good,
> added committer notes and text screenshots as committer notes, thanks!

Thanks for applying!  Are patches 11-22 in your tree?
