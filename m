Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B26C32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538E22075C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfJACdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 22:33:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44004 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfJACdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 22:33:12 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iF7yH-0005Pq-RI; Tue, 01 Oct 2019 02:33:01 +0000
Date:   Tue, 1 Oct 2019 04:33:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] sched_setattr: switch to copy_struct_from_user()
Message-ID: <20191001023300.2melco5qvojypsup@wittgenstein>
References: <20191001011055.19283-1-cyphar@cyphar.com>
 <20191001011055.19283-4-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191001011055.19283-4-cyphar@cyphar.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 11:10:54AM +1000, Aleksa Sarai wrote:
> The change is very straightforward, and helps unify the syscall
> interface for struct-from-userspace syscalls. Ideally we could also
> unify sched_getattr(2)-style syscalls as well, but unfortunately the
> correct semantics for such syscalls are much less clear (see [1] for
> more detail). In future we could come up with a more sane idea for how
> the syscall interface should look.
> 
> [1]: commit 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
>      robustify sched_read_attr() ABI logic and code")
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
