Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67301C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4D721783
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfEUI3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:29:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:47178 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEUI3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:29:23 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hT08z-0003cM-KX; Tue, 21 May 2019 11:29:09 +0300
Subject: Re: [PATCH v2 1/7] mm: Add process_vm_mmap() syscall declaration
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        andreyknvl@google.com, arunks@codeaurora.org, vbabka@suse.cz,
        cl@linux.com, riel@surriel.com, keescook@chromium.org,
        hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <155836080726.2441.11153759042802992469.stgit@localhost.localdomain>
 <20190521002827.GA30518@iweiny-DESK2.sc.intel.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <4c35e953-5f59-0202-3f75-f9ccf7df798f@virtuozzo.com>
Date:   Tue, 21 May 2019 11:29:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521002827.GA30518@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ira,

On 21.05.2019 03:28, Ira Weiny wrote:
> On Mon, May 20, 2019 at 05:00:07PM +0300, Kirill Tkhai wrote:
>> Similar to process_vm_readv() and process_vm_writev(),
>> add declarations of a new syscall, which will allow
>> to map memory from or to another process.
> 
> Shouldn't this be the last patch in the series so that the syscall is actually
> implemented first?

It looks like there is no dependencies in the last patch to declarations made
in the first patch, so we really can move it.

I'll make this after there are accumulated some commentaries about the logic
to reduce number of patch series.

[...]

Thanks,
Kirill
