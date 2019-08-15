Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E65C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C344820644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbfHOOEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:04:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42713 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732705AbfHOOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:04:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id j7so6044959ota.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 07:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zM3G1xWX3WogoYIxIH0si8CwpIiqkYLZ2hiihxpOqQ=;
        b=Sy1iBFsWZHK7axv8bgDxBI1fhkK/67MwzRPQ5fV3QlH5Zle6L28+7aoNykJ5HgxZGF
         j9GhwfTAWLnR6M+HfM4G+bgTTW0p7G488hycnq20ja71FW3rh1QoiLYv3VHqZwjFbYcR
         Q8AHHvNppj6bj0T+W4CFqY22R6y5Yy4uV1eUV9feMBH+LqcfjAcTKuZy+6UpzE7bXswg
         QNROcyl/2rhmhZM2gSURqAZpJY8J8Uq594asDz7xTwdT48eQSnhx0OG+SYrI/9hDL3pC
         cHqgJTcxnuYxEN9geZNxmvyDAgboF8RznW+tG6ailD2xs68QFGFmc5WmyvpvclH+wwd/
         EFtg==
X-Gm-Message-State: APjAAAUkS1/xrb3CEffNRyUhJHk0m0MThS8CszfRhNLyZtPtLUahNMyJ
        NO9FmZLWp9owIcrYA8XomKc2VdoxS5ktTfAWzba9WA==
X-Google-Smtp-Source: APXvYqzchRXgP4x789+GjQl+9hOyJZGL6tLjLzEJ8LcaNO1Yx6DCAmdlcRIEhnpH8KVHbuj5x4BhAACAIvjM27sfOC8=
X-Received: by 2002:a5d:8195:: with SMTP id u21mr5821290ion.260.1565877878036;
 Thu, 15 Aug 2019 07:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com> <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 15 Aug 2019 16:04:27 +0200
Message-ID: <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
 enable dGPU direct output"
To:     Mario.Limonciello@dell.com
Cc:     Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 3:56 PM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org <linux-acpi-owner@vger.kernel.org> On
> > Behalf Of Dave Airlie
> > Sent: Wednesday, August 14, 2019 5:48 PM
> > To: Karol Herbst
> > Cc: LKML; Linux ACPI; dri-devel; nouveau; Rafael J . Wysocki; Alex Hung; Ben
> > Skeggs; Dave Airlie
> > Subject: Re: [Nouveau] [PATCH 1/7] Revert "ACPI / OSI: Add OEM _OSI string to
> > enable dGPU direct output"
> >
> > On Thu, 15 Aug 2019 at 07:31, Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > This reverts commit 28586a51eea666d5531bcaef2f68e4abbd87242c.
> > >
> > > The original commit message didn't even make sense. AMD _does_ support it and
> > > it works with Nouveau as well.
> > >
> > > Also what was the issue being solved here? No references to any bugs and not
> > > even explaining any issue at all isn't the way we do things.
> > >
> > > And even if it means a muxed design, then the fix is to make it work inside the
> > > driver, not adding some hacky workaround through ACPI tricks.
> > >
> > > And what out of tree drivers do or do not support we don't care one bit anyway.
> > >
> >
> > I think the reverts should be merged via Rafael's tree as the original
> > patches went in via there, and we should get them in asap.
> >
> > Acked-by: Dave Airlie <airlied@redhat.com>
> > Dave.
>
> There are definitely going to be regressions on machines in the field with the
> in tree drivers by reverting this.  I think we should have an answer for all of those
> before this revert is accepted.
>
> Regarding systems with Intel+NVIDIA, we'll have to work with partners to collect
> some information on the impact of reverting this.
>
> When this is used on a system with Intel+AMD the ASL configures AMD GPU to use
> "Hybrid Graphics" when on Windows and "Power Express" and "Switchable Graphics"
> when on Linux.

and what's exactly the difference between those? And what's the actual
issue here?

We already have the PRIME offloading in place and if that's not
enough, we should work on extending it, not adding some ACPI based
workarounds, because that's exactly how that looks like.

Also, was this discussed with anybody involved in the drm subsystem?

>
> I feel we need a knob and/or DMI detection to affect the changes that the ASL
> normally performs.

Why do we have to do that on a firmware level at all?
