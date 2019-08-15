Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3602DC3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16678206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfHOOZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:25:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36576 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbfHOOZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:25:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id k18so6288514otr.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 07:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1srfTVVrcLRgd7+YxvKeopiwdoMN+JSwzxmbw7BufKY=;
        b=qxDUEtcPzkRofzNr6OxDz69Yjsq2TDF1q/VZ+SRlO1lZUyke8DCswqQY9qZIYgcDiZ
         5OOt8OmWUgiTicUbTy46XdowGKDiFseKjZTqyTshPVAmf8TTi7qT29C8fj7k+hlAqepx
         8wWnenkil6UgdEhT6qexBou0wbTDU3gSCiXNp5Ep9yN02wHsRxJgpT0ne7TOmEMBfXRe
         MTGSTiMNB9dIJFVMr/s2TzR5O7Ko+VyW+a4MOvzISZQLom1P6UN78DnHvb8VVMTuoaXQ
         HjHrOIIJGNciBX0G9kCic7zr3866I2e13meC/svGMRJHH0Uat1abR8rjPN81yfvFKYOJ
         KKGA==
X-Gm-Message-State: APjAAAXJkWLYW/wK68wTnqNiRYd5wmzx7Eszr+RcG3pSOisbhRcXBNDc
        sFHrG2fUJzM9c4SjLxoLZBjei7cFIYXIv0m4e7Iz0A==
X-Google-Smtp-Source: APXvYqyrsllK46/iEpgqVrPevhv4r81hiZTZAIlyGy948ydui3IANnmoo0w+/y8635P46GWeANx/Vo/sumdoLjxDBXo=
X-Received: by 2002:a6b:7606:: with SMTP id g6mr5795786iom.288.1565879117968;
 Thu, 15 Aug 2019 07:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-2-kherbst@redhat.com>
 <CAPM=9ty7yEUqKrcixV1tTuWCpyh6UikA3rxX8BF1E3fDb6WLQQ@mail.gmail.com>
 <5e05532328324d01bc554c573f6298f8@AUSX13MPC101.AMER.DELL.COM>
 <CACO55tsDA1WpMGtAPqUJpWt0AmPDnv9LuC09g2KB5GXB-VSCew@mail.gmail.com> <3fc22fe8bcaf4304bb07534b61c4de90@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <3fc22fe8bcaf4304bb07534b61c4de90@AUSX13MPC101.AMER.DELL.COM>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 15 Aug 2019 16:25:06 +0200
Message-ID: <CACO55tvDfxYMZr0BGv2ROSNEVB4GvXZnBnWBy=RDPOG5hnk7OA@mail.gmail.com>
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

On Thu, Aug 15, 2019 at 4:20 PM <Mario.Limonciello@dell.com> wrote:
>
> > > There are definitely going to be regressions on machines in the field with the
> > > in tree drivers by reverting this.  I think we should have an answer for all of
> > those
> > > before this revert is accepted.
> > >
> > > Regarding systems with Intel+NVIDIA, we'll have to work with partners to
> > collect
> > > some information on the impact of reverting this.
> > >
> > > When this is used on a system with Intel+AMD the ASL configures AMD GPU to
> > use
> > > "Hybrid Graphics" when on Windows and "Power Express" and "Switchable
> > Graphics"
> > > when on Linux.
> >
> > and what's exactly the difference between those? And what's the actual
> > issue here?
>
> DP/HDMI is not detected unless plugged in at bootup.  It's due to missing HPD
> events.
>

afaik Lyude was working on fixing all that, at least for some drivers.
If there is something wrong, we still should fix the drivers, not
adding ACPI workarounds.

Alex: do you know if there are remaining issues regarding that with amdgpu?

> >
> > We already have the PRIME offloading in place and if that's not
> > enough, we should work on extending it, not adding some ACPI based
> > workarounds, because that's exactly how that looks like.
> >
> > Also, was this discussed with anybody involved in the drm subsystem?
> >
> > >
> > > I feel we need a knob and/or DMI detection to affect the changes that the ASL
> > > normally performs.
> >
> > Why do we have to do that on a firmware level at all?
>
> Folks from AMD Graphics team recommended this approach.  From their perspective
> it's not a workaround.  They view this as a different architecture for AMD graphics driver on
> Windows and AMD graphics w/ amdgpu driver.  They have different ASL paths used for
> each.

@alex: is this true?
