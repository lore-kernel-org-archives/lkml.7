Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACACAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B10A2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555411654;
	bh=ZysEG2qkoKPL4wwKL3WOmlFeiOmGIDTYhuy2UwyNzCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q2noSTJeBHvuTgs4gVfTPnZ3I0Hj0GjE4PYW5i//RzhSpKOG9bu510hL5Y+uWeDN7
	 iQ5UKq7ko0Q3R/iAEBqIFiIxPxajei4XQyuz3DzqHYyTW5igeUH1nkpXdN8SMQ8obw
	 /9VDYObkdrWUaJlCJ/IWZ7RkPYwF4ZmzHybyaaUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfDPKrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:47:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44774 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfDPKrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:47:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id i21so16494616oib.11;
        Tue, 16 Apr 2019 03:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWXhi339mwAqDrCT7JrSf4caIHpti1OuTxdcqSXGDS0=;
        b=JlYD3/f4LWKj1l1OqNqiK0SSsK81giN4hJxQyWL8sogCfloPoWOjFSZgwpvQkK1/Zf
         fhz3MCtoR7qEgymBbg2BlgKxNVouejFdXftnfnSsID+5fYa0JpCQDBIBe3Fvqmr0Wj0e
         Wg/Y23ojqv0uUy2Tq1aG96qa6Id9tK1CdFIcYIj5J/Qh6RGOh0VEA61pfd2FwOsMhKzR
         bmnYeIRUHO6TXcA30Etdlh0klOp2+vKZoSHeqRzVxTaeF6bTVS7hg/sIg5im1cWKoAUP
         wyJMZERhy/0jyfkRyIOqdmzROr2vv7DrHZG80/dQWaEymSoUHgY+isx2lSiJDhu219f7
         IMGg==
X-Gm-Message-State: APjAAAXNaCK2AovnLZCJuAZXh7DWLP+Ud8+oZxhuS2s2vTCQNOAKKXAF
        T5iFKZqa1iYzqXTZ44jujrp9urHV73IvdUE8SutTVQ==
X-Google-Smtp-Source: APXvYqw7XW41k4tZG5i/11Wt7jrrozjQbfMgUmHErB4gC1Qb+YQzOQuVYtyD5Ox4U+o2jKR+PzfeSad6f3z/UdxsTDs=
X-Received: by 2002:aca:4c08:: with SMTP id z8mr17409050oia.30.1555411651913;
 Tue, 16 Apr 2019 03:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
 <cfab8842b681a84518b327980b08aee95d159605.1555382110.git.mchehab+samsung@kernel.org>
 <1616669.eeiCRjss8h@kreacher> <20190416074137.53873332@coco.lan>
In-Reply-To: <20190416074137.53873332@coco.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Apr 2019 12:47:21 +0200
Message-ID: <CAJZ5v0gSP3URj4imX1wroC9bBurbWQ0GVF9F_0e+FpXuHQfODQ@mail.gmail.com>
Subject: Re: [PATCH 25/57] docs: power: convert docs to ReST
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 12:41 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Em Tue, 16 Apr 2019 10:59:23 +0200
> "Rafael J. Wysocki" <rjw@rjwysocki.net> escreveu:
>
> > On Tuesday, April 16, 2019 4:55:50 AM CEST Mauro Carvalho Chehab wrote:
> > > Convert the PM documents to ReST, in order to allow them to
> > > build with Sphinx.
> >
> > And what exactly is the motivation for doing that?
>
> Providing a little of context, I tried to submit a patchset that would
> just place existing documents on a sort of "staging" way, without
> actually reformatting:
>
>         https://lkml.org/lkml/2019/4/10/244
>
> Jon had some concerns about such approach.
>
> So, I split into one patch per subsystem. Then, I looked on each, and
> opted to do the conversion, as, on several cases, the conversion
> seemed to be easy enough.
>
> My selfish motivation is that I was returning from vacations and wanted to
> review some stuff at the Kernel docs, but, discovered that, despite we
> started migrating the documentation on May, 2016, still the vast
> majority of documents that weren't converted.
>
> For me, the main motivation for the conversion are:
>
> 1) Documents will be grouped into books and chapters,
>    with makes easier to study them;
> 2) The Sphinx javascript is very convenient for seeking a
>    document and a keyword within the body of the document;
> 3) Using a browser to read documentation allows to better
>    scale the document to the screen I'm using.
>
> That's said, sometimes I just prefer to convert the document
> to a PDF and read it on my tablet. PDF tools also provide
> similar features.
>
> In other words, for my own consumption, I prefer reading
> documents using document tools, instead of reading in plain
> text.

I see, thanks!

> > There are plans for some of these files to be converted already, some of them need to be merged or split and it just is not worth it to convert some others.
>
> Feel free to use this patch as an starting point. If you prefer,
> I can split into smaller sets, but my main goal here is just
> to help to speedup the conversion.

OK, we'll see.  Thank you!
