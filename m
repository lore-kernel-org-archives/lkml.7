Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41882C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7232175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aurorafoss.org header.i=@aurorafoss.org header.b="tg/Zctoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfDEXBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:01:17 -0400
Received: from out.migadu.com ([91.121.223.63]:49960 "EHLO out.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDEXBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 19:01:17 -0400
Received: (Migadu outbound); Fri, 05 Apr 2019 23:01:14 +0000
Authentication-Results: out.migadu.com; auth=pass (plain)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by out.migadu.com (Haraka/2.8.16) with ESMTPSA id 10782001-829D-4549-96A6-CF4BB71D090B.1
        envelope-from <luis@aurorafoss.org> (authenticated bits=0)
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 verify=FAIL);
        Fri, 05 Apr 2019 23:01:13 +0000
Received: by mail-oi1-f179.google.com with SMTP id 3so6212462oir.7;
        Fri, 05 Apr 2019 16:01:13 -0700 (PDT)
X-Gm-Message-State: APjAAAV1g2hxGPdn1TrQQ6Bc4Hugg1iHEE3adkiITbAUHU6LhNrLc8EH
        hGdqfyNEyskZC7xMHkoJDPgp7vj9Befy+ItlFtc=
X-Google-Smtp-Source: APXvYqz1ffCniccESqtwEsDV5jqQHjIfxR5gn5BcBf2My8LuOHuOOrHh6RUMSti4TSLYg5ovm9KHWnzAhWU00ZGtOyE=
X-Received: by 2002:aca:6084:: with SMTP id u126mr7238179oib.145.1554505272820;
 Fri, 05 Apr 2019 16:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190402160433.15810-1-luis@aurorafoss.org> <55a52a4e-01d1-2f4c-25e3-0047537bef86@redhat.com>
In-Reply-To: <55a52a4e-01d1-2f4c-25e3-0047537bef86@redhat.com>
From:   =?UTF-8?Q?Lu=C3=ADs_Ferreira?= <luis@aurorafoss.org>
Date:   Sat, 6 Apr 2019 00:01:01 +0100
X-Gmail-Original-Message-ID: <CAPyOxm8DyFjRxeL9QFHGW084cg5vhsKrwqGFy5rp8MEEZ3AHEQ@mail.gmail.com>
Message-ID: <CAPyOxm8DyFjRxeL9QFHGW084cg5vhsKrwqGFy5rp8MEEZ3AHEQ@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: add missing sensor for some 2-in-1 based ultrabooks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     jic23@kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1;a=rsa-sha256;bh=r4dT3J2YnIWFEPLvTA2lVqEHCGbz7z9fmfLuIuMI7SM=;c=relaxed/simple;d=aurorafoss.org;h=from:subject:date:to;s=default;b=tg/ZctoiWwrmxGfHo5+56XrmsGe85zTyqf1wt5c/bXCEHPxrT2iv3fo5fT4+TggIU2RO0OCnrf/mh9yHoBaSMymlZuXjc0v7NeslcmsE9YBfIYk+CVjTziDf+qkyPOHFN60Ce7zcF8OnwLTvPBScyMUBoGBMdNZjxyvmBnOlsZg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Basically we need to come up with a convention to (optionally) indicate
> the sensors location with a udev attribute set by:
> /lib/udev/hwdb.d/60-sensor.hwdb

So should we start adding `ACCEL_LOCATION=3Ddisplay` and
`ACCEL_LOCATION=3Dkeyboard` attributes to that file and patch
iio-sensor-proxy to ignore the keyboard ones as a first step ?

Best Regards,
Lu=C3=ADs

Sincerely,
Lu=C3=ADs Ferreira
E2AB 2BF8 F3EC ABE2 E149 F2FD BC43 0831 9CE4 0B64 (plain text)



Aurora Free Open Source Software is a non-profit organization that
promote free and open source software. All applications, source code
and services are complete open and free to use according to a valid
Open Source license. Check out more at https://www.aurorafoss.org/ .

---
PRIVILEGED & CONFIDENTIAL COMMUNICATIONS
This email and all rights associated with it are the property of Lu=C3=ADs =
Ferreira.
It contains material for which legal professional privilege is
claimed. The contents of this email may not be examined, removed or
reproduced without my express written permission by Lu=C3=ADs Ferreira. The
information contained in this e-mail message and any accompanying
files is or may be confidential. It is intended only for the
addressee. If you are not the intended recipient, any use,
dissemination, reliance, forwarding, printing or copying of this
e-mail or any attached files is unauthorised. This e-mail is subject
to copyright. No part of it should be reproduced, adapted or
communicated without the written consent of the copyright owner. If
you have received this e-mail in error please advise the sender
immediately by return e-mail or telephone and delete all copies. Lu=C3=ADs
Ferreira does not guarantee the accuracy or completeness of any
information contained in this e-mail or attached files. Internet
communications are not secure, therefore Lu=C3=ADs Ferreira does not accept
legal responsibility for the contents of this message or attached
files.


On Wed, 3 Apr 2019 at 10:10, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 02-04-19 18:04, Lu=C3=ADs Ferreira wrote:
> > Some ultrabooks, like Teclast F6 Pro, use KIOX010A sensor on display
> > and KIOX020A sensor on keyboard base, to detect tablet mode or screen
> > orientation.
>
> I deliberately left out the KIOX020A id for now, because currently
> userspace cannot really deal with having 2 sensors.
>
> See:
> https://github.com/systemd/systemd/issues/6557
> https://github.com/hadess/iio-sensor-proxy/issues/166
>
> Basically we need to come up with a convention to (optionally) indicate
> the sensors location with a udev attribute set by:
> /lib/udev/hwdb.d/60-sensor.hwdb
>
> And then patch iio-sensor-proxy to consume that attribute and ignore
> the one which has e.g. ACCEL_LOCATION=3Dkeyboard in its udev properties
>
> Ignoring would be a first step, maybe later it can do something useful
> with it, see e.g. :  https://github.com/alesguzik/linux_detect_tablet_mod=
e
>
> IMHO we really should minimally get code in place for iio-sensor-proxy
> to ignore the keyboard accelerometer before merging this patch.
>
> I realize that having the code in place will not magically get it on
> all users machines, but I believe this is the minimum which needs to
> happen before we push this out and potentially breaks people screen
> rotation.
>
> I've had working on this on my TODO list for a long long time now,
> but -ENOTIME. If you have some time to work on this then that would
> be great.
>
> Regards,
>
> Hans
>
>
>
>
> >
> > Signed-off-by: Lu=C3=ADs Ferreira <luis@aurorafoss.org>
> > ---
> >   drivers/iio/accel/kxcjk-1013.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1=
013.c
> > index 7096e577b23f..9a5e445facc1 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -1492,6 +1492,7 @@ static const struct acpi_device_id kx_acpi_match[=
] =3D {
> >       {"KIOX0009", KXTJ21009},
> >       {"KIOX000A", KXCJ91008},
> >       {"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-i=
n-1 */
> > +     {"KIOX020A", KXCJ91008},
> >       {"KXTJ1009", KXTJ21009},
> >       {"KXJ2109",  KXTJ21009},
> >       {"SMO8500",  KXCJ91008},
> >
