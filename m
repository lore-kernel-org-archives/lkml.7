Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	SUBJ_ALL_CAPS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7945D2183E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 19:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="pp3S2R2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfCWTYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 15:24:16 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35492 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfCWTYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 15:24:15 -0400
Received: by mail-it1-f193.google.com with SMTP id w15so8456567itc.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjWZdDY9OSLIpA/ayQImAUPQu/bDUWvJRk6UM7g95VY=;
        b=pp3S2R2vnaipvEmXelg0TP6R4WzLFLW15mzU+bRwRGxWdVLFCUL4mXoBi7JY7xXok2
         a0/sOnRs4eh0cm0KgXBuL9csza1gCWqq31nbUyY0wd2WM+4Gq2la+wtNSoVzvrnDTpj4
         mHx+QdAnt28wtR7Rx4saOMKU68J9SmWeQ7WEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjWZdDY9OSLIpA/ayQImAUPQu/bDUWvJRk6UM7g95VY=;
        b=l90J721umUKthDP77JFs/D9GFcGNuyFntatyDSulVriobgO/KkThqwThuw4qzuk+ee
         TmG0nFERide+cjVpB+QIz3qYkt8LFvKyQurJWxyjsFAahHlSnAaS8hI7Cg/5Cbh3qSnY
         e9pbCRwcw9DKHFBOXgfO4OVPORNzH/tvIOVQY3E2WlWGqpkqHr9webTUDjSZs3HgWWpS
         LIDHwdCfYH4C0rAgw/Vwa2qB4F3X5rDtcfSRbE+ZIlYz8/Vy0RnHTFiBqktSb0W2D4NX
         DA5VrMbE5iVrt+GrDQIbq7GojUgBFRv8V2umKviEC9E8mHRVE/w6B/x/WrfUpkxeOWkw
         1O7A==
X-Gm-Message-State: APjAAAXFOWjQqgxQOPyWQrF0WQw4HRDsQC6j8cTaymMOUGs5nWEZFgcB
        z93xsliiugLgcak+8t//m1zXFrxbkjgwZ15xJDoBww==
X-Google-Smtp-Source: APXvYqws9+hZof7ehv0V2wxvZsaHh/Qt6V3MUYtc0+dz6CHAepan4F+Pwtuf3Hjcq2jrt7hLLU++Eiz0RW5Fhu08cdE=
X-Received: by 2002:a05:6638:211:: with SMTP id e17mr11782589jaq.35.1553369054734;
 Sat, 23 Mar 2019 12:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553335775.git.sicilia.cristian@gmail.com>
In-Reply-To: <cover.1553335775.git.sicilia.cristian@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 23 Mar 2019 12:24:03 -0700
Message-ID: <CAJCx=g=FvdD4xYDmFfJnHypiyHU44MBR8v=AfVN2quCWu6aCpA@mail.gmail.com>
Subject: Re: [PATCH 0/5] *** SUBJECT HERE ***
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You may want to change "*** SUBJECT HERE ***"  in the future :)

- Matt

On Sat, Mar 23, 2019 at 5:53 AM Cristian Sicilia
<sicilia.cristian@gmail.com> wrote:
>
> Some source refactoring, parameters aligment and camel case clearing.
>
> Replacement of bool to bitfield in a struct, but not found
> the population to check if it is done correctly.
>
> Cristian Sicilia (5):
>   staging: iio: adc: Tab alignment
>   staging: iio: adc: Converted bool to bitfield format
>   staging: iio: adc: Avoid precedence issues in macro
>   staging: iio: adc: Adding temp var to improve readability
>   staging: iio: adc: Remove CamelCase notation
>
>  drivers/staging/iio/adc/ad7192.h  |  16 +++---
>  drivers/staging/iio/adc/ad7280a.c | 109 ++++++++++++++++++--------------------
>  2 files changed, 60 insertions(+), 65 deletions(-)
>
> --
> 2.7.4
>
