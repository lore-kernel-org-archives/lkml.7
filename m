Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B42ECA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 18:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E9F21928
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 18:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571597814;
	bh=DMWKjIExqTNEr+jTC8Cfcm9xcLhUQN9BnsaReJNFJ8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hHvNPpsTpgM4Ft9Jt6WygFW5/L4pW7Sth723JKY27HtTvYeXOB+oQJmq/tHQISbKK
	 rsFDrYV/JqSRikl7TbL6CDmk9F2WQL37DAwqEC8rIu7nJlzcuWC1dJsWJhcR1c1//a
	 6ASSIovFD7xb9b2hAFdedcTeYsfW9p03BPfX4Cho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfJTS4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 14:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfJTS4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 14:56:51 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB6021929;
        Sun, 20 Oct 2019 18:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571597810;
        bh=DMWKjIExqTNEr+jTC8Cfcm9xcLhUQN9BnsaReJNFJ8M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g8+tJDxW537aodtTeA4/otxkxK01TEF9iPF9sSrkoDF3ukvWcWA//yZavpwqlni8Y
         9fa6tqxNT/JEmkxpKvFzIrbd2Kl8ESLMW4Or00HmBVPMj4wVtxXxU8L0V6iA6zq3Qg
         hlTKF4uSm1pgkha1yNEkF3TKb/aeLvREYzn6YuK0=
Received: by mail-qt1-f182.google.com with SMTP id c17so14294315qtn.8;
        Sun, 20 Oct 2019 11:56:50 -0700 (PDT)
X-Gm-Message-State: APjAAAXj62PmDOvIh/nwiZu+CZOpaZM8OZxj9UtBcnNZKmjG0WYDzgUu
        xp2kMmMWKmU1ADlmknmsB1bSJvkU0mVC++HBsw==
X-Google-Smtp-Source: APXvYqzezxKnvH4ddIHzD22MnL1TUymJkjpa1epQZ/YP39BDEZsjaDCXMab8nDnoewNjHMIBJSM56RP3ixQbzXmu1kU=
X-Received: by 2002:ac8:741a:: with SMTP id p26mr6395369qtq.143.1571597809618;
 Sun, 20 Oct 2019 11:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190911093123.11312-1-colin.king@canonical.com> <4aa3bcde-1ad1-98ec-8deb-4a8ab1bbb41c@gmail.com>
In-Reply-To: <4aa3bcde-1ad1-98ec-8deb-4a8ab1bbb41c@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 20 Oct 2019 13:56:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKETEt3SstdoRBV0s63fKeE7pPnOf405147r22ZC6XcgQ@mail.gmail.com>
Message-ID: <CAL_JsqKETEt3SstdoRBV0s63fKeE7pPnOf405147r22ZC6XcgQ@mail.gmail.com>
Subject: Re: [PATCH] dtc: fix spelling mistake "mmory" -> "memory"
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Colin King <colin.king@canonical.com>, devicetree@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 2:08 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Rob,
>
>
> On 09/11/2019 04:31, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a spelling mistake in an error message. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  scripts/dtc/fdtput.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/dtc/fdtput.c b/scripts/dtc/fdtput.c
> > index a363c3cabc59..3755e5f68a5a 100644
> > --- a/scripts/dtc/fdtput.c
> > +++ b/scripts/dtc/fdtput.c
> > @@ -84,7 +84,7 @@ static int encode_value(struct display_info *disp, char **arg, int arg_count,
> >                       value_size = (upto + len) + 500;
> >                       value = realloc(value, value_size);
> >                       if (!value) {
> > -                             fprintf(stderr, "Out of mmory: cannot alloc "
> > +                             fprintf(stderr, "Out of memory: cannot alloc "
> >                                       "%d bytes\n", value_size);
> >                               return -1;
> >                       }
> >
>
> This is a very old version of the upstream file.  update-dtc-source.sh does
> not pull new versions of this file.
>
> We don't actually build fdtput, is there any reason to not just remove
> scripts/dtc/fdtput.c?

Yes, we should just remove it.

Rob
