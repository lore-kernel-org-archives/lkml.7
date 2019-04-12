Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F08C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07392083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfDLC3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 22:29:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34321 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfDLC3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 22:29:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44gMK95Sd0z9s7T;
        Fri, 12 Apr 2019 12:29:01 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations=' cmdline options
In-Reply-To: <alpine.DEB.2.21.1904101408580.3479@nanos.tec.linutronix.de>
References: <cover.1554396090.git.jpoimboe@redhat.com> <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com> <20190405131211.GE23348@zn.tnic> <20190405142048.burthk2jnpcvi2om@treble> <20190405152059.GG23348@zn.tnic> <20190405160136.GI23348@zn.tnic> <20190405161852.nmpk22omgiety4df@treble> <87sguqwgu7.fsf@concordia.ellerman.id.au> <alpine.DEB.2.21.1904101408580.3479@nanos.tec.linutronix.de>
Date:   Fri, 12 Apr 2019 12:29:01 +1000
Message-ID: <87bm1cufbm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> On Wed, 10 Apr 2019, Michael Ellerman wrote:
>> Josh Poimboeuf <jpoimboe@redhat.com> writes:
>> 
>> > On Fri, Apr 05, 2019 at 06:01:36PM +0200, Borislav Petkov wrote:
>> >> Thinking about this more, we can shave off the first 4 chars and have it
>> >> be:
>> >> 
>> >> spec_mitigations=
>> >> 
>> >> I think it is painfully clear which speculation mitigations we mean. And
>> >> the other switches don't have "cpu_" prefixes too so...
>> >
>> > Sure, I'm ok with renaming it to that, if there are no objections.
>> 
>> What about when we have a mitigation for a non-speculation related bug :)
>
> Those kind of silicon bugs are usually mitigated unconditionally.

I guess that's true, usually :)

cheers
