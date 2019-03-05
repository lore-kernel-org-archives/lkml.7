Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174E5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47D320842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfCEOoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:44:16 -0500
Received: from ms.lwn.net ([45.79.88.28]:39732 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbfCEOoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:44:15 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5605E2B4;
        Tue,  5 Mar 2019 14:44:14 +0000 (UTC)
Date:   Tue, 5 Mar 2019 07:44:13 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Meijboom <robin@meijboom.info>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] objtool: move stack-validation.txt to
 Documentation/
Message-ID: <20190305074413.5f72ecc1@lwn.net>
In-Reply-To: <1551764896-8453-2-git-send-email-yamada.masahiro@socionext.com>
References: <1551764896-8453-1-git-send-email-yamada.masahiro@socionext.com>
        <1551764896-8453-2-git-send-email-yamada.masahiro@socionext.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Mar 2019 14:48:15 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Move the document to the standard Documentation/ directory instead of
> creating the same directory structure under objtool/.

This seems like a good idea to me, but can I make a couple of requests?

 - Convert it to RST while you're at it?  It's 99% there already.

 - Let's not add it to the top-level Documentation/ mess; I'm slowly
   trying to bring some order there.  Perhaps a better home would be
   Documentation/kbuild/ ?

Thanks,

jon
