Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F4EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A7921881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGCONA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:13:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:36428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfGCONA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:13:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DCE3BAF81;
        Wed,  3 Jul 2019 14:12:58 +0000 (UTC)
Subject: Re: [PATCH 1/3] x86/paravirt: Make read_cr2() CALLEE_SAVE
To:     root <peterz@infradead.org>, bp@alien8.de, rostedt@goodmis.org,
        luto@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org
Cc:     devel@etsukata.com, joel@joelfernandes.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        zhe.he@windriver.com, hpa@zytor.com
References: <20190703102731.236024951@infradead.org>
 <20190703102807.475869328@infradead.org>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <53806e4a-f905-a4db-f18c-f747a7ad0e81@suse.com>
Date:   Wed, 3 Jul 2019 16:12:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703102807.475869328@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.19 12:27, root wrote:
> The one paravirt read_cr2() implementation (Xen) is actually quite
> trivial and doesn't need to clobber anything other than the return
> register. By making read_cr2() CALLEE_SAVE we avoid all the PUSH/POP
> nonsense and allow more convenient use from assembly.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
