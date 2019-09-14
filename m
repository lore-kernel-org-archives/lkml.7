Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CF2C49ED6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 07:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B662081B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 07:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfINH7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 03:59:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:35694 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfINH7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 03:59:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 87F242CC;
        Sat, 14 Sep 2019 07:59:02 +0000 (UTC)
Date:   Sat, 14 Sep 2019 01:58:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Joe Perches <joe@perches.com>
Cc:     linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Louis Taylor <louis@kragniz.eu>
Subject: Re: [PATCH] docs: printk-formats: Stop encouraging use of
 unnecessary %h[xudi] and %hh[xudi]
Message-ID: <20190914015858.7c76e036@lwn.net>
In-Reply-To: <a68114afb134b8633905f5a25ae7c4e6799ce8f1.camel@perches.com>
References: <a68114afb134b8633905f5a25ae7c4e6799ce8f1.camel@perches.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Sep 2019 14:11:51 -0700
Joe Perches <joe@perches.com> wrote:

> Standard integer promotion is already done and %hx and %hhx is useless
> so do not encourage the use of %hh[xudi] or %h[xudi].
> 
> As Linus said in:
> Link: https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/
> 
> It's a pointless warning, making for more complex code, and
> making people remember esoteric printf format details that have no
> reason for existing.
> 
> The "h" and "hh" things should never be used. The only reason for them
> being used if if you have an "int", but you want to print it out as a
> "char" (and honestly, that is a really bad reason, you'd be better off
> just using a proper cast to make the code more obvious).
> 
> So if what you have a "char" (or unsigned char) you should always just
> print it out as an "int", knowing that the compiler already did the
> proper type conversion.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied, thanks.

I took the liberty of removing "Link:" (but not the URL) from the commit
message.  That wasn't a patch tag, there is no real reason to make it
look like one...

jon
