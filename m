Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDB1C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0E6206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfCELMB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:12:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46565 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfCELMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:12:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id z25so8500188qti.13;
        Tue, 05 Mar 2019 03:12:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SMNmFmA2nVdf8waKD/nGaMcDIRXl5dXvlq6KlMBcTnY=;
        b=Y9HEqJGPiBEQcfxZTnxnJD3CLgazkCURsecxZJAaj5xURD4dwkiM8ntvxP0YBuDxYY
         ktlv31NXgkk/9QvXUJ1XX/EVy4+Bt4L0raRDP7q2zMBVIwPyhw1K3OVh7EBlbkVPa10b
         RwwmsM2zIYUKia6e2s5DntP8SrPgl+ODiFqHiIA363rIOGw5JG0Yi09no+YK6UgkQRXl
         UFZ8kJUpJdO82II8491Ura4OL0derz8mmjmnk27s+/S+cwemUYJJVQDrsX4ie/WQ+Xja
         gIiZ+zJUd/c8dF6jyaMOvu6vXFi4yT2hentaUXM5R4VE5ux3/D6Ms33v7DyF6ld+LX2z
         1tvQ==
X-Gm-Message-State: APjAAAXbCgAAfAu8D2B/0pHKz1ta9N8t2q+KVZEKWHhsp5pn/q81ZW/n
        J40h2ksDchn1qCO9n2hwj7t/xpjhUv04BcqLFXc=
X-Google-Smtp-Source: APXvYqwuJFRoFUoTd+YqCLC7AkRZXIBpH0HGJc4TIw0cr17H1jnAo3tCCo19dQ5AYCG6b8o3XUgMLLCjMEIo21pGVoA=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr916713qtb.343.1551784319784;
 Tue, 05 Mar 2019 03:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20190301035852.26780-1-marek.behun@nic.cz> <20190301035852.26780-4-marek.behun@nic.cz>
 <CACRpkdam_CYGtph16McpQQ_WwohpZr+Rzi1B=re4UrGxXmSEqg@mail.gmail.com>
 <20190301161510.20b15183@nic.cz> <CACRpkdb0Bv1iwtd61GUQLU25nAKrfk-VS0PGKTYh_LoyjYWHFg@mail.gmail.com>
In-Reply-To: <CACRpkdb0Bv1iwtd61GUQLU25nAKrfk-VS0PGKTYh_LoyjYWHFg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 12:11:41 +0100
Message-ID: <CAK8P3a2V-rxF4-oWiRGkFafgDuCVTS3ObZ==LD3nAw08s831rw@mail.gmail.com>
Subject: Re: [PATCH v3 bus+gpio 3/5] bus: moxtet: Add sysfs documentation
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marek Behun <marek.behun@nic.cz>, Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 1:08 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Mar 1, 2019 at 4:15 PM Marek Behun <marek.behun@nic.cz> wrote:
>
> > On Fri, 1 Mar 2019 15:34:26 +0100
> > Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > > > +What:          /sys/bus/moxtet/devices/moxtet-<name>.<addr>/output_value
> > > > +Date:          March 2019
> > > > +KernelVersion: 5.2
> > > > +Contact:       Marek Behún <marek.behun@nic.cz>
> > > > +Description:   (RW) Read last written value or write value to the
> > > > module on
> > > > +               this Moxtet address. Format: %x
> > >
> > > What is the usecase for these?
> > >
> > > If this is for debugging it should be in debugfs rather than in sysfs.
> > >
> > > If it is here for random userspace drivers, we need some good
> > > explanation as to why they can't just be kernel drivers.

I had the same thought, and then saw you already commented.

> > Hmm, it was for debugging purposes but the ability to write there is
> > not needed anymore... Shall I make it read/only? Or completely remove
> > it?
>
> I would either remove it or move it to debugfs.

How about removing it for the initial submission? Then we
can see if it's still needed later and discuss how it should be
done when we need it.

     Arnd
