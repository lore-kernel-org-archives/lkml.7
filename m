Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA8C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19B82082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfCEKl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:41:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:56855 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfCEKl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:41:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 02:41:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,443,1544515200"; 
   d="scan'208";a="138180359"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Mar 2019 02:41:25 -0800
Subject: Re: [PATCH v2 1/7] perf script python: remove mixed indentation
To:     Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-2-tonyj@suse.de>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c31ce5ee-8767-2ae2-17a5-9889c96e1047@intel.com>
Date:   Tue, 5 Mar 2019 12:39:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190302011903.2416-2-tonyj@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/03/19 3:18 AM, Tony Jones wrote:
> Remove mixed indentation in Python scripts.  Revert to either all 
> tabs (most common form) or all spaces (4 or 8) depending on what 
> was the intent of the original commit.  This is necessary to 
> complete Python3 support as it will flag an error if it encounters 
> mixed indentation.
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>

For intel-pt-events.py

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

