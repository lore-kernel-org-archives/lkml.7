Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FC5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25D62186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfDEI6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:58:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43918 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbfDEI6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:58:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 702A8168F;
        Fri,  5 Apr 2019 01:58:36 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE20F3F721;
        Fri,  5 Apr 2019 01:58:32 -0700 (PDT)
Date:   Fri, 5 Apr 2019 09:58:28 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH 0/6 v3] sycalls: Remove args i and n from
 syscall_get_arguments()
Message-ID: <20190405085828.GA1576@fuggles.cambridge.arm.com>
References: <20190401134104.676620247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401134104.676620247@goodmis.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 09:41:04AM -0400, Steven Rostedt wrote:
> [ Looking for acks ]

For the arm64 bits:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
