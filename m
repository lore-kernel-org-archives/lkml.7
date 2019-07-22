Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCFFC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299C921985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733292AbfGVWfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:35:31 -0400
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:55345 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729193AbfGVWfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:35:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 58A45182CED28;
        Mon, 22 Jul 2019 22:35:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: door20_8706454f72216
X-Filterd-Recvd-Size: 2417
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jul 2019 22:35:27 +0000 (UTC)
Message-ID: <abd83fb8e7ca10eb67d4669248fc0ff51da48191.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Added warnings in favor of strscpy().
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Kitt <steve@sk2.org>, Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Mon, 22 Jul 2019 15:35:24 -0700
In-Reply-To: <20190722162804.754943bc@lwn.net>
References: <1561722948-28289-1-git-send-email-nitin.r.gote@intel.com>
         <20190629181537.7d524f7d@sk2.org> <201907021024.D1C8E7B2D@keescook>
         <20190706144204.15652de7@heffalump.sk2.org>
         <201907221047.4895D35B30@keescook>
         <15f2be3cde69321f4f3a48d60645b303d66a600b.camel@perches.com>
         <20190722230102.442137dc@heffalump.sk2.org>
         <d96cf801c5cf68e785e8dfd9dba0994fcff20017.camel@perches.com>
         <20190722155730.08dfd4e3@lwn.net>
         <512d8977fb0d0b3eef7b6ea1753fb4c33fbc43e8.camel@perches.com>
         <20190722162804.754943bc@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-22 at 16:28 -0600, Jonathan Corbet wrote:
> On Mon, 22 Jul 2019 15:24:33 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > > If the functions themselves are fully defined in the .h file, I'd just add
> > > the kerneldoc there as well.  That's how it's usually done, and you want
> > > to keep the documentation and the prototypes together.  
> > 
> > In this case, it's a macro and yes, the kernel-doc could
> > easily be set around the macro in the .h, but my desire
> > is to keep all the string function kernel-doc output
> > together so it should be added to lib/string.c
> > 
> > Are you suggesting I move all the lib/string.c kernel-doc
> > to include/linux/string.h ?
> 
> If you want the *output* together, just put the kernel-doc directives
> together in the RST file that pulls it all in.  Or am I missing something
> here?

Nah, it's me.
I'm not particularly up to date on .rst file usage.

Thanks.


