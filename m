Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D715FC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4A4207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503851AbfIXBY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 21:24:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44466 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391923AbfIXBYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:24:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so204445qth.11;
        Mon, 23 Sep 2019 18:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/Mgf6jP/KxSO8yzRBY5wpIujbsiN+nIajcNpr3DS3o=;
        b=XjW/cvcRaK8wzxU4DYxbU5EJONbMiybNvukw4dHl9MMNFIcOyUa8uWKYvan9DrVnOu
         RJ2FwK3DJHXtB9OjrCg1oWYbPggmsfUb+tPc+ASvxWH695NOH53XZOVvX9VBkMKMGE4x
         T2mqoA8wTmRDtZD0oVz/jobbdFzuUSIaPoDGiM3WkgqyaADzZI7rhnwtpt2d/iUgOxCK
         7+Ld+OQI8VsKb647JBuzfuztN3sfufF2dh9NvBEKuFQgM/2qi9LbdHoQl7C5zMxGSVQ2
         SYVUtB3GFHs6uxHhtX6d2pWzxMAhFKhCpRIUyzmTzni8ojr90RqmOC2b3ky8xlITJCGB
         4nrg==
X-Gm-Message-State: APjAAAUYdhgKaIeLKaAW+MUMRAqXqiG6LSFe/5ng4sMBppSU9iPNMn9s
        mvzXvcKlSjcDU7XAVRQiG/6/VxK3RTaEwYSDS3nOivZYOtM=
X-Google-Smtp-Source: APXvYqzmFX0InSZVXOLQka/aXrR7Eu6XO692C9zN1BAodHRLk5phJcCwmFqVOgHrvZQB52JistbkwbO/FjfNfrpZtnI=
X-Received: by 2002:ac8:342a:: with SMTP id u39mr379911qtb.7.1569288264799;
 Mon, 23 Sep 2019 18:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190909204631.1076624-1-arnd@arndb.de> <dbbf0b7a-125c-9517-4232-dd88bea139dd@schaufler-ca.com>
In-Reply-To: <dbbf0b7a-125c-9517-4232-dd88bea139dd@schaufler-ca.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 Sep 2019 18:24:08 -0700
Message-ID: <CAK8P3a1xY9Ez=04yiFpv1JRAJxwC7ay2chKG2SMVg3d=HejB-g@mail.gmail.com>
Subject: Re: [PATCH] smack: include linux/watch_queue.h
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LSM List <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 2:50 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 9/9/2019 1:46 PM, Arnd Bergmann wrote:
> > In some randconfig builds, the lack of an explicit #include
> > in smack_lsm.c causes a build failure:
>
> What tree/branch are you working with? I don't see this.

It was in the latest linux-next at the time I posted the patch. It's
possible that
the patch causing the problem got removed in the meantime.

      Arnd
