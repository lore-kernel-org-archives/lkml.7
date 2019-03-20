Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A41CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2BF2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 23:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553124971;
	bh=qths8MNw9aEEngfDoGT++DTro5VEJoDpUKqiTcdgB1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AQQ5G6lwPju693Dx+CsfwrSaIm9cEX7krY62cUi53xoUOKVYmM9VEufJu9lUoC2Dh
	 m3MuJxrDocjOLfmw/ifInc2JvxMmD8p31U8Tv3Ns/aVb2OopVbCLnthZPySb3LZPXb
	 NPiYmz9sj06r6faH+f576ElWN13Tp8ZktcLnAyrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCTXgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 19:36:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35794 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfCTXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 19:36:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id d6so3520606eds.2;
        Wed, 20 Mar 2019 16:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvOmomr9tUJ/2JSbib0/ZcNUxhi2pBzAcBlB2gCXZOE=;
        b=lRLRHOejkB7x5iwSm0NNZ+glAIjfSpG39DNYCCcYtiJv3AMG2SDI/b/s+H3HljQG5H
         wr/mCTpXhrtPddGCxOXSflf7xSeu11y/4JBj5PQTZt+C/bdbFmHn5AtlCM3oxvrHIJcc
         J+pMKak6HmCZhY3PI0ewzBgeEwPSnbtCnpODM5hK5a+QOwJauRb+ljW/JOKHkfl7AXSY
         a95FLEDs89BmvjDSJgJhjDZZlPkE8kuCVS2mfvXo4dZe860s38jt/ulAbQvaTHOsFPHJ
         1JW3bdSD/XEU9IZy+/ysI0gD4PsR28rU2SJsGDNEnlWn5O6R3ZI777jidibUN0+YxNjP
         Caew==
X-Gm-Message-State: APjAAAWGTQ1E1ZwesmagmMVTZMsH+MMM9R2rpNEdWdVncGPpCKL2gTgH
        FI9M3WMAbHzd6ZC91zcIJraOhkxKkqDgIAFacM6Nyg==
X-Google-Smtp-Source: APXvYqxaS1vqygw7jO6mSC3T4c+CT5bdH5JvaoKFZqkmdpZfNRQzejED8j3y9JmsfaGAmase1SmtDqiBWDn4aovtQYU=
X-Received: by 2002:a17:906:a18:: with SMTP id w24mr461285ejf.94.1553124967601;
 Wed, 20 Mar 2019 16:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180817163442.10065-1-calvin.walton@kepstin.ca>
In-Reply-To: <20180817163442.10065-1-calvin.walton@kepstin.ca>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 20 Mar 2019 19:35:55 -0400
Message-ID: <CAJvTdKnsv8zyq8ndKWFezx7sgYmp7ZwD5yMdYW5jYbUbPLr+WA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] tools/power turbostat: Add support for AMD Fam 17h
 (Zen) RAPL
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks!

On Fri, Aug 17, 2018 at 12:35 PM Calvin Walton <calvin.walton@kepstin.ca> wrote:
>
> This is an updated version of my RAPL patchset for Zen CPUs, rebased on
> top of the current state of kernel/git/lenb/linux.get turbostat branch.
> (In particular, this fixes conflicts with the AMD APIC-id patch)
>
> I've split it into two patches now. The first patch only adds Cores
> power reporting, since I'm fairly confident that this'll work on all of
> the Zen chips. I think this part is ready to apply now.
>
> The second part is still a work in progress until I'm able to (or I'm
> able to find someone else to) test the package power reporting on a
> multi-die Zen chip.
>
> Calvin Walton (2):
>   tools/power turbostat: Add support for AMD Fam 17h (Zen) RAPL
>   [WIP] tools/power turbostat: Also read package power on AMD F17h (Zen)
>
>  tools/power/x86/turbostat/turbostat.c | 167 +++++++++++++++++++++-----
>  1 file changed, 138 insertions(+), 29 deletions(-)
>
> --
> 2.18.0
>


-- 
Len Brown, Intel Open Source Technology Center
