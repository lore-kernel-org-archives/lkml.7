Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AB0ECE58C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BE521848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfJJBXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 21:23:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:61706 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731134AbfJJBXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 21:23:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 18:23:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="197089771"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga003.jf.intel.com with ESMTP; 09 Oct 2019 18:23:39 -0700
Date:   Thu, 10 Oct 2019 09:23:22 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] userfaultfd: remove set but not used variable 'h'
Message-ID: <20191010012322.GB2167@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191009122740.70517-1-yuehaibing@huawei.com>
 <a28da32b-5c26-21e9-4a08-722abf9fbeba@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28da32b-5c26-21e9-4a08-722abf9fbeba@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 05:45:57PM -0700, Mike Kravetz wrote:
>On 10/9/19 5:27 AM, YueHaibing wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>> 
>> mm/userfaultfd.c: In function '__mcopy_atomic_hugetlb':
>> mm/userfaultfd.c:217:17: warning:
>>  variable 'h' set but not used [-Wunused-but-set-variable]
>> 
>> It is not used since commit 78911d0e18ac ("userfaultfd: use vma_pagesize
>> for all huge page size calculation")
>> 
>
>Thanks!  That should have been removed with the recent cleanups.
>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
>Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

If I am correct, this is removed in a recent patch.

>-- 
>Mike Kravetz

-- 
Wei Yang
Help you, Help me
