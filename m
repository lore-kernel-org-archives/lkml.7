Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A08C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D10320705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgAHRRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:17:09 -0500
Received: from ale.deltatee.com ([207.54.116.67]:44074 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgAHRRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:17:09 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ipEwl-0004HY-1g; Wed, 08 Jan 2020 10:16:44 -0700
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>
References: <20200107205959.7575-1-logang@deltatee.com>
 <20200107205959.7575-3-logang@deltatee.com>
 <3e432695-e3a9-2aae-e9f5-1b6454886c06@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <eef4ec73-8823-9f20-93ed-5c09f18c437a@deltatee.com>
Date:   Wed, 8 Jan 2020 10:16:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <3e432695-e3a9-2aae-e9f5-1b6454886c06@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: ebadger@gigaio.com, peterz@infradead.org, luto@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, benh@kernel.crashing.org, will@kernel.org, catalin.marinas@arm.com, hch@lst.de, akpm@linux-foundation.org, mhocko@kernel.org, dan.j.williams@intel.com, linux-mm@kvack.org, platform-driver-x86@vger.kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, david@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 2/8] mm/memory_hotplug: Rename mhp_restrictions to
 mhp_modifiers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-01-08 5:28 a.m., David Hildenbrand wrote:
> On 07.01.20 21:59, Logan Gunthorpe wrote:
>> The mhp_restrictions struct really doesn't specify anything resembling
>> a restriction anymore so rename it to be mhp_modifiers.
> 
> I wonder if something like "mhp_params" would be even better. It's
> essentially just a way to avoid changing call chains rough-out all archs
> whenever we want to add a new parameter.

Sure, that does sound a bit nicer to me. I can change it for v3.

Logan
