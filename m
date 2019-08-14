Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7326AC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3DD2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfHNXfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 19:35:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52870 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbfHNXfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:35:03 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <alex.hung@canonical.com>)
        id 1hy2nF-0008WH-IQ
        for linux-kernel@vger.kernel.org; Wed, 14 Aug 2019 23:35:01 +0000
Received: by mail-qk1-f197.google.com with SMTP id t2so517598qkd.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 16:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyFhDO1eWcBeMeihOWCBNHAWrS5d5d9jzD5/Lieum7w=;
        b=GYW7/k16bk3bk431tzT0xaFgw6NW9tnrWfvbI7nB0X1GHtJK3F1FJQiUItA8RGmR7Y
         WBXcodwigvG7RfkWNoDrmapV1O3SOPliOQhIXtBu6qrj/jAJBqPSgfmmNltBuycw5FSu
         AVEzGha8FHJkakG5RIBEVSP6WoGb4kmyFyp9Mn0BXn/GdhXdYHWRtUeBxD/5XMfy2Y7J
         QbjtJOfFPVZ4I+0I9PitY7wa9nvvsk6HEvjwHrdfQmK8HoSiqYpmZnVFA2nz8ORcYUy/
         JVN8KF7agL8v73ZZkxDphdoo2JdUrz0/QF+ue+XLiZbJzJMcMCjpxoVwv+0OhjHLj/zg
         RgGg==
X-Gm-Message-State: APjAAAUYPOjDUbqFehH2RaogONGYBj38P4wp4Jj88Zdjyeldl1+CUn3a
        SOq/O6oM5gPqWtHpGlM++Wdo7Ws1Vf/Zr14+l4XGXkwjdD7V/peG6sumKAs9Ykq9rz8bJtwjcSq
        lBHq9P1Lkv1Oq6gimz0AkbPpQkOMHaMSQIuKG3IvgYeSAV7FCXvxxPrA0VA==
X-Received: by 2002:a0c:f6ce:: with SMTP id d14mr1525097qvo.56.1565825700753;
        Wed, 14 Aug 2019 16:35:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxE+6MV13gPzPrDixW9IwdnT+USgnWkWtGUiu6QcUgWCmd75vba/3ZYWWy4K18nZ+ZMC4zhsyMCvvjKOohDSj4=
X-Received: by 2002:a0c:f6ce:: with SMTP id d14mr1525085qvo.56.1565825700594;
 Wed, 14 Aug 2019 16:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190814213118.28473-1-kherbst@redhat.com> <20190814213118.28473-4-kherbst@redhat.com>
In-Reply-To: <20190814213118.28473-4-kherbst@redhat.com>
From:   Alex Hung <alex.hung@canonical.com>
Date:   Wed, 14 Aug 2019 17:34:49 -0600
Message-ID: <CAJ=jquaVcWisQ3Qw-_GMktcOq4zqFmeYXztfwNAVKZJO=_+yLA@mail.gmail.com>
Subject: Re: [PATCH 3/7] Revert "ACPI / OSI: Add OEM _OSI strings to disable
 NVidia RTD3"
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 3:31 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> This reverts commit 9251a71db62ca9cc7e7cf364218610b0f018c291.
>
> This was never discussed with anybody Nouveau related and we would have NACKed
> this change immediately.
>
> We have a better workaround, which makes it actually work with Nouveau. No idea
> why the comment mentions the Nvidia driver and assumes it gives any weight to
> the reasoning.... we don't care about out of tree drivers.
>
> Nouveau does support RTD3, but we had some issues with that. And we even have
> a better fix for this issue. Also, can we _please_ do it in a way worthy of an
> upstream community the next time?
>
> If some distribution feels like they have to please companies not wanting to
> be part of the linux community, please do so downstream and don't try to push
> something like this upstream.

Hi Karol,

A lot of appreciation for your hard-work on this issue, but unfriendly
comments aren't necessary. At the time this was discussed with
hardware vendors and platform vendors and it worked for many systems
and benefit for many people buying these platforms. Last but not
least, I do appreciate better fixes and want to retire the hacks too.

I am going to notify hardware owners to test these patches on the
original intended systems, and will report whether there are
regressions.


>
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> CC: Alex Hung <alex.hung@canonical.com>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Dave Airlie <airlied@redhat.com>
> CC: Lyude Paul <lyude@redhat.com>
> CC: Ben Skeggs <bskeggs@redhat.com>
> ---
>  drivers/acpi/osi.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index 56cc95b6b724..f5d559a2ff14 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -44,15 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
>         {"Processor Device", true},
>         {"3.0 _SCP Extensions", true},
>         {"Processor Aggregator Device", true},
> -       /*
> -        * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
> -        * cards as RTD3 is not supported by drivers now.  Systems with NVidia
> -        * cards will hang without RTD3 disabled.
> -        *
> -        * Once NVidia drivers officially support RTD3, this _OSI strings can
> -        * be removed if both new and old graphics cards are supported.
> -        */
> -       {"Linux-Dell-Video", true},
>  };
>
>  static u32 acpi_osi_handler(acpi_string interface, u32 supported)
> --
> 2.21.0
>


--
Cheers,
Alex Hung
