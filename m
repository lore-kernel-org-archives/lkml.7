Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57535C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0B9206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfGOMgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:36:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:38022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728933AbfGOMgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:36:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B99DAD14;
        Mon, 15 Jul 2019 12:36:38 +0000 (UTC)
Subject: Re: [PATCH 0/2] Remove 32-bit Xen PV guest support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alok Kataria <akataria@vmware.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20190715113739.17694-1-jgross@suse.com>
 <20190715123207.GE3419@hirez.programming.kicks-ass.net>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <83fd65e0-9b6f-39a0-4f10-4f535d523ac8@suse.com>
Date:   Mon, 15 Jul 2019 14:36:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715123207.GE3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.19 14:32, Peter Zijlstra wrote:
> On Mon, Jul 15, 2019 at 01:37:37PM +0200, Juergen Gross wrote:
>> The long term plan has been to replace Xen PV guests by PVH. The first
>> victim of that plan are now 32-bit PV guests, as those are used only
>> rather seldom these days. Xen on x86 requires 64-bit support and with
>> Grub2 now supporting PVH officially since version 2.04 there is no
>> need to keep 32-bit PV guest support alive in the Linux kernel.
>> Additionally Meltdown mitigation is not available in the kernel running
>> as 32-bit PV guest, so dropping this mode makes sense from security
>> point of view, too.
>>
>> Juergen Gross (2):
>>    x86/xen: remove 32-bit Xen PV guest support
>>    x86/paravirt: remove 32-bit support from PARAVIRT_XXL
> 
> Hooray!
> 

Always a pleasure to cheer the community up by sending Xen patches. :-D


Juergen
