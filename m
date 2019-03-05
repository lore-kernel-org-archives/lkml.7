Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0F0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C47206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfCEJ5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:57:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:33618 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfCEJ5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:57:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 01:57:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,443,1544515200"; 
   d="scan'208";a="138167920"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Mar 2019 01:57:20 -0800
Subject: Re: [PATCH v2 0/7] perf script python: add Python3 support
To:     Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Feng Tang <feng.tang@intel.com>,
        Tom Zanussi <tzanussi@gmail.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
References: <20190302011903.2416-1-tonyj@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ef75a243-cf15-b763-8aeb-387f105377c6@intel.com>
Date:   Tue, 5 Mar 2019 11:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190302011903.2416-1-tonyj@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/03/19 3:18 AM, Tony Jones wrote:
> This is v2 of my version of the patchset.  Incorporating the 
> previous feedback.  Some changes from v1 were already merged.
> 
> Patch 1/7 deals with the existing inconsistent indentation.
> Indentation is now consistent per file but varying styles (tabs,
> 4 spaces and 8 spaces).   
> I will followup at a later date with changes to checkpatch to ensure
> that the syntax per file is maintained.
> 
> Patches 2/7 through 5/7 were sent in v1,  they have been changed 
> to remove the previous indentation changes
> 
> Patch 6/7 was sent in v1.  I had previously *not* been able to test 
> export-to-postgresql.py.  I was able to do so this time and found
> that more changes were needed.    The author of the original code
> seems concerned about code-style so I would suggest you only merge 
> with his explicit ACK.
> 
> Patch 7/7 was not in v1, it cleans up some repeated use of date
> functions in the SQL exporters.  It is not mandatory for Python3
> support.  It is dependent on Patch#6.
> 
> I hope I've got everything correct, I've retested until I feel I 
> can't look at Python code anymore for a while :-). Hopefully I've 
> not made any more mistakes.  If I have, please LMK and I'll do v3.

perf tools link against python2 so have the scripts been tested with python3?

$ ldd tools/perf/perf | grep python
        libpython2.7.so.1.0 => /usr/lib/x86_64-linux-gnu/libpython2.7.so.1.0
(0x00007ff8a2de2000)
