Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7344C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5300216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfEHXJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 19:09:34 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:41968 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHXJd (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 8 May 2019 19:09:33 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 09 May 2019 01:09:31 +0200
Received: from [192.168.1.138] (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Thu, 09 May 2019 00:09:14 +0100
Message-ID: <1557356938.3028.35.camel@suse.com>
Subject: Re: [PATCH v2 5/8] mm/memory_hotplug: Drop MHP_MEMBLOCK_API
From:   osalvador <osalvador@suse.com>
To:     David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Date:   Thu, 09 May 2019 01:08:58 +0200
In-Reply-To: <edd762a1-c012-fe05-a72e-2505cd98188a@redhat.com>
References: <20190507183804.5512-1-david@redhat.com>
         <20190507183804.5512-6-david@redhat.com>
         <CAPcyv4ge1pSOopfHof4USn=7Skc-UV4Xhd_s=h+M9VXSp_p1XQ@mail.gmail.com>
         <d83fec16-ceff-2f6f-72e1-48996187d5ba@redhat.com>
         <CAPcyv4iRQteuT9yESvbUyhp3KVVgTXDiGAo+TwPCM_4f0CzBgg@mail.gmail.com>
         <edd762a1-c012-fe05-a72e-2505cd98188a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 09:39 +0200, David Hildenbrand wrote:
> However I haven't really thought it through yet, smalles like that
> could
> as well just be handled by the caller of
> arch_add_memory()/arch_remove_memory() eventually, passing it via
> something like the altmap parameter.
> 
> Let's leave it in place for now, we can talk about that once we have
> new
> patches from Oscar.
Hi David,

I plan to send a new patchset once this is and Dan's are merged,
otherwise I will have a mayhem with the conflicts.

I also plan/want to review this patchset, but time is tight this week.

