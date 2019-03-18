Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D39C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E7320850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfCRO5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:57:25 -0400
Received: from foss.arm.com ([217.140.101.70]:35768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfCRO5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:57:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C6701650;
        Mon, 18 Mar 2019 07:57:24 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98E1E3F59C;
        Mon, 18 Mar 2019 07:57:21 -0700 (PDT)
Date:   Mon, 18 Mar 2019 14:57:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 2/6] ptrace: introduce ptrace_syscall_enter to
 consolidate PTRACE_SYSEMU handling
Message-ID: <20190318145719.GB18196@e107155-lin>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-3-sudeep.holla@arm.com>
 <20190318144115.GC27941@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318144115.GC27941@altlinux.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 05:41:15PM +0300, Dmitry V. Levin wrote:
> On Mon, Mar 18, 2019 at 10:49:21AM +0000, Sudeep Holla wrote:
> > Currently each architecture handles PTRACE_SYSEMU in very similar way.
> > It's completely arch independent and can be handled in the code helping
> > to consolidate PTRACE_SYSEMU handling.
> > 
> > Let's introduce a hook 'ptrace_syscall_enter' that arch specific syscall
> > entry code can call.
> 
> Sorry if I'm late for the party, but the new name looks confusing.
> If all it does is related to TIF_SYSCALL_EMU, why does it have a generic
> name 'ptrace_syscall_enter' without any hint of being specific to
> TIF_SYSCALL_EMU?
> 

Not at all late. Infact Haibo Xu pointed that out, I updated but somehow
missed to commit and lost those changes. I will rename as
ptrace_sysemu_syscall_enter

--
Regards,
Sudeep
