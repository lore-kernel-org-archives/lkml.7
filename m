Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6491C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A870520815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfJHPHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfJHPHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:07:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45336206BB;
        Tue,  8 Oct 2019 15:07:39 +0000 (UTC)
Date:   Tue, 8 Oct 2019 11:07:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 0/6] Rewrite x86/ftrace to use text_poke()
Message-ID: <20191008110737.73803008@gandalf.local.home>
In-Reply-To: <20191007081716.07616230.8@infradead.org>
References: <20191007090225.44108711.6@infradead.org>
        <20191007081716.07616230.8@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Oct 2019 10:17:16 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Ftrace was one of the last W^X violators; these patches move it over to the
> generic text_poke() interface and thereby get rid of this oddity.
> 

Ingo, Thomas or H.Peter,

If it's OK with you, can you ack this series so that I can pull it
through my tree? I have some code that will conflict with this that I
want to write on top of it. As well as hammer it out to make sure
ftrace works fine.

Thanks!

-- Steve
