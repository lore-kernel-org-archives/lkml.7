Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6ADC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5D6222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfKMM3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:29:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:40152 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfKMM3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:29:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 04:29:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="207439062"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by orsmga003.jf.intel.com with ESMTP; 13 Nov 2019 04:29:20 -0800
Subject: Re: [PATCH] perf scripts python: exported-sql-viewer.py: Fix use of
 TRUE with SQLite
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20191113120206.26957-1-adrian.hunter@intel.com>
 <20191113121515.GC14646@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <41d1d659-9e66-7f63-9132-41d43a93ee42@intel.com>
Date:   Wed, 13 Nov 2019 14:28:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113121515.GC14646@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/19 2:15 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Nov 13, 2019 at 02:02:06PM +0200, Adrian Hunter escreveu:
>> Prior to version 3.23 SQLite does not support TRUE or FALSE, so always use
>> 1 and 0 for SQLite.
>>
>> Fixes: 26c11206f433 ("perf scripts python: exported-sql-viewer.py: Use new 'has_calls' column")
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: stable@vger.kernel.org
> 
> Thanks, applied and added the first tag with that fixed cset:
> 
> Cc: stable@vger.kernel.org # v5.3+

Thanks, but I just noticed it doesn't apply to 5.3 or 5.4-rc7, sorry :-(.
I guess the Fixes and stable tags should be dropped and I will send the
stable patch separately.
