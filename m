Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A552216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfE2MGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfE2MGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:06:52 -0400
Received: from oasis.local.home (unknown [12.156.218.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D455120644;
        Wed, 29 May 2019 12:06:50 +0000 (UTC)
Date:   Wed, 29 May 2019 08:06:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Johannes Erdfelt <johannes@erdfelt.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Ingo Molnar <mingo@redhat.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Oops caused by race between livepatch and ftrace
Message-ID: <20190529080648.0e001bfd@oasis.local.home>
In-Reply-To: <nycvar.YFH.7.76.1905291315310.1962@cbobk.fhfr.pm>
References: <20190520194915.GB1646@sventech.com>
        <90f78070-95ec-ce49-1641-19d061abecf4@redhat.com>
        <20190520210905.GC1646@sventech.com>
        <20190520211931.vokbqxkx5kb6k2bz@treble>
        <20190520173910.6da9ddaf@gandalf.local.home>
        <20190521141629.bmk5onsaab26qoaw@treble>
        <20190521104204.47d4e175@gandalf.local.home>
        <20190521164227.bxdff77kq7fgl5lp@treble>
        <20190521125319.04ac8b6c@gandalf.local.home>
        <nycvar.YFH.7.76.1905291315310.1962@cbobk.fhfr.pm>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 13:17:21 +0200 (CEST)
Jiri Kosina <jikos@kernel.org> wrote:

> > > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > > Subject: [PATCH] livepatch: Fix ftrace module text permissions race  
> > 
> > Thanks,
> > 
> > I'll try to find some time to test this as well.  
> 
> Steve, Jessica, any final word on this?

I was under the impression that Josh was going to send an updated
patch (and a properly sent one). Patches embedded in other emails don't
get flagged by my internal patchwork, so they usually get ignored.

-- Steve
