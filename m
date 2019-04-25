Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3796C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD776214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfDYHlp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:41:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:29011 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfDYHlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:41:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 00:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; 
   d="scan'208";a="340645474"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 25 Apr 2019 00:41:43 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 00:41:43 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 25 Apr 2019 00:41:42 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.92]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.153]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 15:41:41 +0800
From:   "Du, Fan" <fan.du@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>
Subject: RE: [RFC PATCH 0/5] New fallback workflow for heterogeneous memory
 system
Thread-Topic: [RFC PATCH 0/5] New fallback workflow for heterogeneous memory
 system
Thread-Index: AQHU+wguqC0/BskpLkaHU1TotE//DKZL5oWAgACMEvA=
Date:   Thu, 25 Apr 2019 07:41:40 +0000
Message-ID: <5A90DA2E42F8AE43BC4A093BF067884825785EE8@SHSMSX104.ccr.corp.intel.com>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
 <20190425063727.GJ12751@dhcp22.suse.cz>
In-Reply-To: <20190425063727.GJ12751@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTAwMTA2OGUtZjhlYy00ZDA5LWE0MWQtZWI5ZTMyOWQ3ZWY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYTdHdVZlWVhvblh5XC9BV0FNcFZEd2RJZElMUEFwbERINElTOVdaK0FTRHBGK01PcWpLZ3hCN3J3SHNaZngxS2cifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Michal Hocko [mailto:mhocko@kernel.org]
>Sent: Thursday, April 25, 2019 2:37 PM
>To: Du, Fan <fan.du@intel.com>
>Cc: akpm@linux-foundation.org; Wu, Fengguang <fengguang.wu@intel.com>;
>Williams, Dan J <dan.j.williams@intel.com>; Hansen, Dave
><dave.hansen@intel.com>; xishi.qiuxishi@alibaba-inc.com; Huang, Ying
><ying.huang@intel.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org
>Subject: Re: [RFC PATCH 0/5] New fallback workflow for heterogeneous
>memory system
>
>On Thu 25-04-19 09:21:30, Fan Du wrote:
>[...]
>> However PMEM has different characteristics from DRAM,
>> the more reasonable or desirable fallback style would be:
>> DRAM node 0 -> DRAM node 1 -> PMEM node 2 -> PMEM node 3.
>> When DRAM is exhausted, try PMEM then.
>
>Why and who does care? NUMA is fundamentally about memory nodes with
>different access characteristics so why is PMEM any special?

Michal, thanks for your comments!

The "different" lies in the local or remote access, usually the underlying
memory is the same type, i.e. DRAM.

By "special", PMEM is usually in gigantic capacity than DRAM per dimm, 
while with different read/write access latency than DRAM. Iow PMEM
sits right under DRAM in the memory tier hierarchy.

This makes PMEM to be far memory, or second class memory.
So we give first class DRAM page to user, fallback to PMEM when
necessary.

The Cloud Service Provider can use DRAM + PMEM in their system,
Leveraging method [1] to keep hot page in DRAM and warm or cold
Page in PMEM, achieve optimal performance and reduce total cost
of ownership at the same time.

[1]:
https://github.com/fengguang/memory-optimizer

>--
>Michal Hocko
>SUSE Labs
