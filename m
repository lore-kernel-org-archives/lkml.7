Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD3C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371B120652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfD2IHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:07:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32847 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfD2IHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:07:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id g7so10974063qtc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 01:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYi43Lpb2eQY3E2rRqP8+5ua3fkv4oukhSpEYQDHTQo=;
        b=pl32xDab23kz56oaQErTqkD2ZEty1i4MtzuG8my9lixxFARfIf9OFb70gGjB9QGnTa
         WhAziKQJhTsTxQO82mkDQ/xaw2umi26+nv/R5Dhqw4ZdFQCzDpXkKIZ6QOgrBXaWA0CF
         bfjpEN6y5F5aMuPuf9u+7kn39TV2U0Waw7unMVjx4WXyGNqDdlWpI+76OhbPIdA/2VHe
         jF6j6srAH6pyO4dkcJ5W+ApvD61wEx+U+xXTWE26Hfg/Zb8upa+Gnz4yJX8snv+znNgp
         u+xvxBumoq4pWKxZq7RhaA02AU/etOcQGHk3YyeA5NAOwFr76Ni5SGCJd+HWcMLBgHqg
         /7yw==
X-Gm-Message-State: APjAAAX8eyn03Oj6Me5d0K5qVMo5fQZ1x0h7L3G2nmQzPFffEh6HluZH
        Y+Qmi2+1ukklIAen8F0Di5RqcqbECyiilMdAgjU=
X-Google-Smtp-Source: APXvYqznLxAna8C15dPs0Tu0zfUGa9/s0iQusViY1zaVgjjMaAT5ZmuIBABc+Ta4YiLYA4AYCPD1RNBQJKoW0whh8qs=
X-Received: by 2002:ac8:8cd:: with SMTP id y13mr36383548qth.96.1556525264286;
 Mon, 29 Apr 2019 01:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com> <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
 <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
 <20190425172549.GA12376@kroah.com> <CACPK8XemgKvM38wDSUJsXXeK51dwmeUoKWn+e3ZNHd9v5VBZHA@mail.gmail.com>
In-Reply-To: <CACPK8XemgKvM38wDSUJsXXeK51dwmeUoKWn+e3ZNHd9v5VBZHA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Apr 2019 10:07:28 +0200
Message-ID: <CAK8P3a3CK4o8KnD6M084ULEmm+6_CtNFqYHjSqE5vp+U9YAmkA@mail.gmail.com>
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
To:     Joel Stanley <joel@jms.id.au>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Patrick Venture <venture@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>,
        soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 9:49 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Thu, 25 Apr 2019 at 17:25, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Apr 23, 2019 at 08:28:14AM -0700, Patrick Venture wrote:
> > > On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
> > > >
> > > > On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> > > > >
> > > > > Create a SoC folder for the ASPEED parts and place the misc drivers
> > > > > currently present into this folder.  These drivers are not generic part
> > > > > drivers, but rather only apply to the ASPEED SoCs.
> > > > >
> > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > >
> > > > Accidentally lost the Acked-by when re-sending this patchset as I
> > > > didn't see it on v1 before re-sending v2 to the larger audience.
> > >
> > > Since there was a change between v1 and v2, Arnd, I'd appreciate you
> > > Ack this version of the patchset since it changes when the soc/aspeed
> > > Makefile is followed.
> >
> > I have no objection for moving stuff out of drivers/misc/ so the SOC
> > maintainers are free to take this.
>
> I was on the fence about this. The downside of moving drivers out of
> drivers/misc is it allows SoCs to hide little drivers away from
> scrutiny, when in fact they could be sharing a common userspace API
> with other BMCs.  (Keep an eye out for the coming Nuvoton "bios post
> code" driver which is very similar to
> drivers/misc/aspeed-lpc-snoop.c).

Things like this should usually find a different home: drivers/misc
tends to be for one-of-a-kind stuff with a user interface, not for things
where you have multiple chips doing the same thing.

If you think there are going to be additional cases where you have
more than one bmc in need of a user interface for the same
functionality, we could introduce a drivers/bmc/ subsystem and
have a set of user interfaces backed by a set of chip specific
drivers.

> However, in the effort to move away from BMC that are full of shell
> scripts that bash on /dev/mem, we are going to see a collection of
> small, very SoC specific, drivers and it doesn't make sense to clutter
> up drivers/misc.
>
> Acked-by: Joel Stanley <joel@jms.id.au>
>
> The p2a driver has been merged by Greg. We should move that one over
> too. Arnd, can you advise Patrick on how to proceed? We could have him
> spin a v3 that includes the p2a driver, but it would depend on Greg's
> char-misc-next branch.

I don't think there is a rush here, so let's do that for the following
merge window.

      Arnd
