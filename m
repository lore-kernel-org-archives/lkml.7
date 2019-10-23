Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9772CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16EC21928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403925AbfJWTZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 15:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733199AbfJWTZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:25:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 586A820663;
        Wed, 23 Oct 2019 19:25:43 +0000 (UTC)
Date:   Wed, 23 Oct 2019 15:25:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Robert Richter <rric@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH v2 2/4] module: Fix up module_notifier return values.
Message-ID: <20191023152541.4b22cb10@gandalf.local.home>
In-Reply-To: <20191007082700.08643163.5@infradead.org>
References: <20191007082541.64146933.7@infradead.org>
        <20191007082700.08643163.5@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Oct 2019 10:25:43 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

>  kernel/trace/trace.c           |    2 +-
>  kernel/trace/trace_events.c    |    2 +-
>  kernel/trace/trace_printk.c    |    4 ++--
>  kernel/tracepoint.c            |    2 +-

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
