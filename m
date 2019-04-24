Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C61C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1FF218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfDXHQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:16:44 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42165 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfDXHQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:16:44 -0400
Received: by mail-qk1-f193.google.com with SMTP id c190so6448481qke.9;
        Wed, 24 Apr 2019 00:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vtoRdJNYOO5XXJgUqn92NRO5AXTQ17kbZcTRcpqM5M=;
        b=tY62NZtKmJr69adUJDrNMkv5dMxsNdBHTea1h1IhurKSXN8nzKh6MCavEM1smE/3W4
         IHX8vp2vaY2D31r4Gi3Ei7ljaH0eH7iWcnYch0UTwf1I7EdWCfRqlsYusHftLu0PaptY
         XcpJQsUvjD2tQCU/oMvyCLnWAqSOdJ2KnlETLttpKnAFyCspZyyMihMsxaNjRYq/VHV9
         ggTgPyvHLEZkRaNiEgXmyJhuWy4Zdgdx5FrZ76T9zHqWtN9Zir/UtUVKbn9wqcfIi56X
         ss+Repxl6t3qVXudJ/hSxdX31xYrT6vFt0IKRtx9XMehna1YfbYFVO1gUYUAjsrRG/yc
         YMnw==
X-Gm-Message-State: APjAAAWehSoYHo0QYCE2f1WxVhMYIXjIJpw6rtA9WYGeU0CmLlE/ILHm
        DqUWtP7NeLlG0N/C1dGNpU635D80YN2zW2NoFpdDJZxB
X-Google-Smtp-Source: APXvYqyz+NpH/AN9CzMV4SIRQakedWs/eckqDJWHCSHjXUnkX+aEwJkhFYXtiUOU87Bk7DWCP+u0NPXZT5DefWTm1Z4=
X-Received: by 2002:a37:c402:: with SMTP id d2mr11455272qki.291.1556090202785;
 Wed, 24 Apr 2019 00:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3bT=HO=YQ7PY7wOEsJTzf0jS4PkqNHSqYX4JjwmbhY+g@mail.gmail.com>
 <20190424004131.GA19764@altlinux.org>
In-Reply-To: <20190424004131.GA19764@altlinux.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Apr 2019 09:16:26 +0200
Message-ID: <CAK8P3a2vmEkqN2FLu6C5TPGyDZ4F=tUENJXz_E_oeqdN1RDqQA@mail.gmail.com>
Subject: Re: [GIT PULL] arch: add pidfd and io_uring syscalls everywhere
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 2:41 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Tue, Apr 23, 2019 at 09:28:48PM +0200, Arnd Bergmann wrote:
> > The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> >
> >   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
> > syscalls-5.1
> >
> > for you to fetch changes up to 39036cd2727395c3369b1051005da74059a85317:
> >
> >   arch: add pidfd and io_uring syscalls everywhere (2019-04-15 16:31:17 +0200)
> >
> > ----------------------------------------------------------------
> > arch: add pidfd and io_uring syscalls everywhere
> >
> > This comes a bit late, but should be in 5.1 anyway: we want the newly
> > added system calls to be synchronized across all architectures in
> > the release.
> >
> > I hope that in the future, any newly added system calls can be added
> > to all architectures at the same time, and tested there while they
> > are in linux-next, avoiding dependencies between the architecture
> > maintainer trees and the tree that contains the new system call.
>
> Is "everywhere" really means everywhere?
> The reason I'm asking this question is that sh64 seems to be excluded:
> arch/sh/kernel/syscalls_64.S hasn't got any syscall entries since commit
> v4.8-rc1~15^2~3.  Is sh64 supported in any way at all?

sh64 is dead, the only reason those files are still there is because nobody
has bothered to create the patch to remove them.

It has not been possible to even build an sh64 kernel for many years,
and I'm sure none of the prototypes have been turned on for even longer
if they are still in someone's board pile.

     Arnd
