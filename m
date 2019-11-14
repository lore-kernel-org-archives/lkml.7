Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579D9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344F320709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfKNJFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:05:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:42266 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfKNJFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:05:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3210DAE00;
        Thu, 14 Nov 2019 09:05:44 +0000 (UTC)
Date:   Thu, 14 Nov 2019 10:05:42 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 00/10] ftrace: Add register_ftrace_direct()
In-Reply-To: <20191113113105.140fe6b6@gandalf.local.home>
Message-ID: <alpine.LSU.2.21.1911141004420.20723@pobox.suse.cz>
References: <20191108212834.594904349@goodmis.org> <alpine.LSU.2.21.1911131604170.18679@pobox.suse.cz> <20191113113105.140fe6b6@gandalf.local.home>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019, Steven Rostedt wrote:

> On Wed, 13 Nov 2019 16:10:36 +0100 (CET)
> Miroslav Benes <mbenes@suse.cz> wrote:
> 
> > So I tried to run the selftests and ran into the same timeout issue we had 
> > with live patching :/
> > 
> > See http://lkml.kernel.org/r/20191025115041.23186-1-mbenes@suse.cz for a possible solution.
> 
> Is this when you run the all the selftests?

Yes, when I run all ftrace selftests (make run_tests in 
tools/testing/selftests/ftrace/).

Miroslav
