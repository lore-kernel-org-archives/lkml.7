Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31F1C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650A9217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557473421;
	bh=BWrULVzHUxmrIZ/1PBVnKb7g/rLEN890zSUCxeUSOSE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=BQ5PZHMOfP3mSX2qlfkN6vm6nm17iWZI7yDKnZSELV7s7hru3Kh5v1s7rZs2VYmLY
	 TyMacaFHfbigdvi8SWgr2a3Uk3/kSk+0BWhNhBVD6z8taMH9VBettIPH1BE+Wnc3kw
	 +9SzBcYjxVO7IjhGOmZ/oT28N5irGVgi2Qj+An70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfEJHaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfEJHaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:30:19 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8F332175B;
        Fri, 10 May 2019 07:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557473419;
        bh=BWrULVzHUxmrIZ/1PBVnKb7g/rLEN890zSUCxeUSOSE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=uC9XIXL5NOnZiIp1vI/7XQ5e8RSwZ4IT5AyZqoCVLEKI36bA3aJ7ebMhe8K9UrwZK
         NB1cOHJMRucygvFiEebZKXgQwJpXbnf6xXOwc7cXZlfBuV/wIwek5990NI2/ITYz+C
         1hVHTxl4GyWwqagtyopplsoOJ6pfWsNyveCFmpN8=
Date:   Fri, 10 May 2019 09:30:14 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC][PATCH] ftrace/x86: Remove mcount support
In-Reply-To: <20190509222858.3ef96113@gandalf.local.home>
Message-ID: <nycvar.YFH.7.76.1905100929290.17054@cbobk.fhfr.pm>
References: <20190509154902.34ea14f8@gandalf.local.home> <CAHk-=wgZGWpXdscUHyuoRqkJ8XD5Wh2Q-320KGFBhGoBJGzAWQ@mail.gmail.com> <20190509222858.3ef96113@gandalf.local.home>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019, Steven Rostedt wrote:

> As this patch is simply a "remove mcount" patch, I'd like to have the 
> removal of klp_check_compiler_support() be a separate patch.
> 
> Jiri or Josh, care to send a patch on top of this one?

Sure thing, I'll do that once you send v2 fixing x86_32 of your patch.

Thanks,

-- 
Jiri Kosina
SUSE Labs

