Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93643C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 21:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1552075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 21:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfECVq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 17:46:29 -0400
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:36294 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726600AbfECVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 17:46:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 42668180143F7;
        Fri,  3 May 2019 21:46:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cars17_8e972f856e746
X-Filterd-Recvd-Size: 2628
Received: from XPS-9350 (unknown [84.16.30.4])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 May 2019 21:46:19 +0000 (UTC)
Message-ID: <5a671727418034dd1de54ad67f3f028f3cde9516.camel@perches.com>
Subject: Re: [PATCH for 5.2 00/12] Restartable Sequences selftests updates
From:   Joe Perches <joe@perches.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        shuah <shuah@kernel.org>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Date:   Fri, 03 May 2019 14:46:17 -0700
In-Reply-To: <1137649333.995.1556911352713.JavaMail.zimbra@efficios.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
         <678952111.699.1556908562445.JavaMail.zimbra@efficios.com>
         <68a135d7-7b30-71c7-c570-c7608d6f75d5@kernel.org>
         <1137649333.995.1556911352713.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-03 at 15:22 -0400, Mathieu Desnoyers wrote:
> ----- On May 3, 2019, at 2:53 PM, shuah shuah@kernel.org wrote:
> > ERROR: need consistent spacing around '%' (ctx:WxV)
> > #227: FILE: tools/testing/selftests/rseq/rseq-x86.h:104:
> > +		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
> > 
> > Will you be able to fix them and resend?
[]
> (CCing the che checkpatch maintainers)
> 
> checkpatch appears to be wrong for these errors. I suspect it thinks those are
> '%' modulo operators (for which the style requires space before/after),
> but those are actually part of the asm input and goto target operands.

checkpatch doesn't really understand asm.
Ignore checkpatch when it's silly.


