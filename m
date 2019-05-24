Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7EFC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A0D21848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390011AbfEXPyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389385AbfEXPya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:54:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF841217D7;
        Fri, 24 May 2019 15:54:29 +0000 (UTC)
Date:   Fri, 24 May 2019 11:54:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Behmer <jbehmer@google.com>
Cc:     tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: Nested events with zero deltas, can use absolute timestamps
 instead?
Message-ID: <20190524115428.2bf41725@gandalf.local.home>
In-Reply-To: <CAMmhGqK7LxvR2t=v3NY5Um+EPurtbSfkpPtCAhDagFs_Sz0Kuw@mail.gmail.com>
References: <CAMmhGqKc27W03roONYXhmwB0dtz5Z8nGoS2MLSsKJ3Zotv5-JA@mail.gmail.com>
        <20190329125258.2c6fe0cb@gandalf.local.home>
        <CAMmhGqKPw1sxB_Qc+Z-MXZue+wtAQsQDDgUvjs4JQTVY8bR65g@mail.gmail.com>
        <20190401222056.3da6e7a7@oasis.local.home>
        <CAMmhGqL0tvxW_ucJUFKYqRrMRTTfUfRGpm1BnXiEvqFntSXSjQ@mail.gmail.com>
        <CAMmhGq+8XKBB9GA3J0pwZ6X6Qb1syxKVqNU6i6digtyjMrGyWw@mail.gmail.com>
        <20190524110048.142efd44@gandalf.local.home>
        <CAMmhGq+1gZvzR9RwJ6m1MzO1jnTy8yFx8jaRiWpGtZ=E6n9vig@mail.gmail.com>
        <20190524112457.58b24d89@gandalf.local.home>
        <CAMmhGqK7LxvR2t=v3NY5Um+EPurtbSfkpPtCAhDagFs_Sz0Kuw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 08:48:44 -0700
Jason Behmer <jbehmer@google.com> wrote:

> Sorry, I'm not sure I follow.  By new tracing option do you mean a new
> option in the timestamp_mode file?  I guess in that case would that
> still be the only writable option?  You could write 1/0 to the file
> which would turn on/off force_absolute_timestamps, and reading the
> file would show which of absolute, delta, and force_absolute was set?
> Or did you mean something else by tracing option?

I mean the options in tracefs/options/*

Do a search for OVERWRITE in kernel/trace/ and see what it does.

-- Steve
