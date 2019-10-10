Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB70AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5F2208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbfJJDbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:31:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:38880 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfJJDbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:31:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 20:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="187824635"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 09 Oct 2019 20:31:02 -0700
Date:   Thu, 10 Oct 2019 11:30:45 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] userfaultfd: remove set but not used variable 'h'
Message-ID: <20191010033045.GA5927@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191009122740.70517-1-yuehaibing@huawei.com>
 <a28da32b-5c26-21e9-4a08-722abf9fbeba@oracle.com>
 <20191010012322.GB2167@richard>
 <ba62cc8f-da4d-a316-c968-80871551c863@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba62cc8f-da4d-a316-c968-80871551c863@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 07:25:18PM -0700, Mike Kravetz wrote:
>On 10/9/19 6:23 PM, Wei Yang wrote:
>> On Wed, Oct 09, 2019 at 05:45:57PM -0700, Mike Kravetz wrote:
>>> On 10/9/19 5:27 AM, YueHaibing wrote:
>>>> Fixes gcc '-Wunused-but-set-variable' warning:
>>>>
>>>> mm/userfaultfd.c: In function '__mcopy_atomic_hugetlb':
>>>> mm/userfaultfd.c:217:17: warning:
>>>>  variable 'h' set but not used [-Wunused-but-set-variable]
>>>>
>>>> It is not used since commit 78911d0e18ac ("userfaultfd: use vma_pagesize
>>>> for all huge page size calculation")
>>>>
>>>
>>> Thanks!  That should have been removed with the recent cleanups.
>>>
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>
>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>> 
>> If I am correct, this is removed in a recent patch.
>
>I'm having a hard time figuring out what is actually in the latest mmotm
>tree.  Andrew added a build fixup patch ab169389eb5 in linux-next which
>adds the reference to h.  Is there a patch after that to remove the reference?
>

I checked linux-next tree, this commit removes the reference.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=add4eaeef3766b7491d70d473c48c0b6d6ca5cb7

>-- 
>Mike Kravetz

-- 
Wei Yang
Help you, Help me
