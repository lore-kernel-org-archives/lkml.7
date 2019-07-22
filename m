Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373D5C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF4D2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbfGVWYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:24:38 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:59822 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726544AbfGVWYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:24:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C970C18224D99;
        Mon, 22 Jul 2019 22:24:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dress20_280f7ba920e31
X-Filterd-Recvd-Size: 2494
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jul 2019 22:24:35 +0000 (UTC)
Message-ID: <512d8977fb0d0b3eef7b6ea1753fb4c33fbc43e8.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Added warnings in favor of strscpy().
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Kitt <steve@sk2.org>, Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Mon, 22 Jul 2019 15:24:33 -0700
In-Reply-To: <20190722155730.08dfd4e3@lwn.net>
References: <1561722948-28289-1-git-send-email-nitin.r.gote@intel.com>
         <20190629181537.7d524f7d@sk2.org> <201907021024.D1C8E7B2D@keescook>
         <20190706144204.15652de7@heffalump.sk2.org>
         <201907221047.4895D35B30@keescook>
         <15f2be3cde69321f4f3a48d60645b303d66a600b.camel@perches.com>
         <20190722230102.442137dc@heffalump.sk2.org>
         <d96cf801c5cf68e785e8dfd9dba0994fcff20017.camel@perches.com>
         <20190722155730.08dfd4e3@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-22 at 15:57 -0600, Jonathan Corbet wrote:
> On Mon, 22 Jul 2019 14:50:09 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > On Mon, 2019-07-22 at 23:01 +0200, Stephen Kitt wrote:
> > > How about you submit your current patch set, and I follow up with the above
> > > adapted to stracpy?  
> > 
> > OK, I will shortly after I figure out how to add kernel-doc
> > for stracpy/stracpy_pad to lib/string.c.
> > 
> > It doesn't seem appropriate to add the kernel-doc to string.h
> > as it would be separated from the others in string.c
> > 
> > Anyone got a clue here?  Jonathan?
> 
> If the functions themselves are fully defined in the .h file, I'd just add
> the kerneldoc there as well.  That's how it's usually done, and you want
> to keep the documentation and the prototypes together.

In this case, it's a macro and yes, the kernel-doc could
easily be set around the macro in the .h, but my desire
is to keep all the string function kernel-doc output
together so it should be added to lib/string.c

Are you suggesting I move all the lib/string.c kernel-doc
to include/linux/string.h ?

