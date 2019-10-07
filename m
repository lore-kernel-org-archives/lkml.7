Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB07C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB77F20679
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 06:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfJGGwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 02:52:05 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:41828 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726960AbfJGGwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 02:52:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id F2040182CED5B;
        Mon,  7 Oct 2019 06:52:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: drain01_11f090bc8a144
X-Filterd-Recvd-Size: 1962
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Oct 2019 06:52:03 +0000 (UTC)
Message-ID: <b5b363ef96a1bfad6965c4b01c8737990b8f4e91.camel@perches.com>
Subject: Re: checkpatch: false positive "does MAINTAINERS need updating?"
 warning
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 06 Oct 2019 23:52:02 -0700
In-Reply-To: <CAK7LNARKUAoHDFzGJ3snAy2XeQshTqmzDMUC7qqU8=L-p=+LNg@mail.gmail.com>
References: <CAK7LNARKUAoHDFzGJ3snAy2XeQshTqmzDMUC7qqU8=L-p=+LNg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-07 at 13:44 +0900, Masahiro Yamada wrote:
> Hi Joe,
> 
> 
> I ran checkpatch.pl against the following:
> https://lore.kernel.org/patchwork/patch/1136334/
> 
> 
> I did update MAINTAINERS, but I still get
> "does MAINTAINERS need updating?" warning.
> Why?

Because checkpatch is not able to determine
that you updated MAINTAINERS correctly.

Ignore checkpatch output when you know better.

> 
> 
> $ scripts/checkpatch.pl
> 0001-doc-move-namespaces.rst-out-of-kbuild-directory.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #18:
>  Documentation/{kbuild => admin-guide}/namespaces.rst | 0
> 
> total: 0 errors, 1 warnings, 14 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0001-doc-move-namespaces.rst-out-of-kbuild-directory.patch has style
> problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 

