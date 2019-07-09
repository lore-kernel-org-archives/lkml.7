Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FECDC73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0263121537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGIOof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfGIOoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:44:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06ECC21537;
        Tue,  9 Jul 2019 14:44:32 +0000 (UTC)
Date:   Tue, 9 Jul 2019 10:44:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/ftrace: Select an existing function in
 kprobe_eventname test
Message-ID: <20190709104431.7599939c@gandalf.local.home>
In-Reply-To: <20190709214402.ffe8b206485dec2ec28eeb3a@kernel.org>
References: <20190322150923.1b58eca5@gandalf.local.home>
        <20190708191026.GA8307@calabresa>
        <20190708152214.0304ec7e@gandalf.local.home>
        <20190709214402.ffe8b206485dec2ec28eeb3a@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 21:44:02 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Masami, can you ack this, and Shuah, can you take it?  
> 
> Yeah anyway,
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks Masami,

Shuah, want to take this in your tree?

-- Steve
