Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA16C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D333421985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfGVW2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:28:06 -0400
Received: from ms.lwn.net ([45.79.88.28]:43710 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfGVW2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:28:06 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6579A7DA;
        Mon, 22 Jul 2019 22:28:05 +0000 (UTC)
Date:   Mon, 22 Jul 2019 16:28:04 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Perches <joe@perches.com>
Cc:     Stephen Kitt <steve@sk2.org>, Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] checkpatch: Added warnings in favor of strscpy().
Message-ID: <20190722162804.754943bc@lwn.net>
In-Reply-To: <512d8977fb0d0b3eef7b6ea1753fb4c33fbc43e8.camel@perches.com>
References: <1561722948-28289-1-git-send-email-nitin.r.gote@intel.com>
        <20190629181537.7d524f7d@sk2.org>
        <201907021024.D1C8E7B2D@keescook>
        <20190706144204.15652de7@heffalump.sk2.org>
        <201907221047.4895D35B30@keescook>
        <15f2be3cde69321f4f3a48d60645b303d66a600b.camel@perches.com>
        <20190722230102.442137dc@heffalump.sk2.org>
        <d96cf801c5cf68e785e8dfd9dba0994fcff20017.camel@perches.com>
        <20190722155730.08dfd4e3@lwn.net>
        <512d8977fb0d0b3eef7b6ea1753fb4c33fbc43e8.camel@perches.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019 15:24:33 -0700
Joe Perches <joe@perches.com> wrote:

> > If the functions themselves are fully defined in the .h file, I'd just add
> > the kerneldoc there as well.  That's how it's usually done, and you want
> > to keep the documentation and the prototypes together.  
> 
> In this case, it's a macro and yes, the kernel-doc could
> easily be set around the macro in the .h, but my desire
> is to keep all the string function kernel-doc output
> together so it should be added to lib/string.c
> 
> Are you suggesting I move all the lib/string.c kernel-doc
> to include/linux/string.h ?

If you want the *output* together, just put the kernel-doc directives
together in the RST file that pulls it all in.  Or am I missing something
here?

Thanks,

jon
