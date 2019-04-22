Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3857C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD85F20874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="E5HfDJqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfDVQNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:13:13 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56582 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDVQNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1555949588; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AgYqFhHK9+KEdoRaW0HT5/Jpbx15R9mKS2eYOPHyvQU=;
        b=E5HfDJqOG/dKz5uh7mOGylwgUlc5MSDOmxwoLxV3ytrQ6rZo3uBZ0Zlpyy6xOSiSx8I8c5
        MlEnkQdSxXIMDXaxULwWIbYS1Qs1Kh/lHA1gCFYAkdahEmM0QUlNkKy9c+sf7YK+RMsrpd
        mTWOV5fLJCoyJHX1aJzVBWnLG5VlvPc=
Date:   Mon, 22 Apr 2019 18:13:02 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 2/3] dt-bindings: Add header for the ingenic-drm driver
 bindings
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, od@zcrc.me,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1555949582.1483.0@crapouillou.net>
In-Reply-To: <CAAEAJfBZPvoUd6dT2C6QDO4wsPzpwMpcT-XFwo+Xr4NO+4+jtA@mail.gmail.com>
References: <20190414200824.28348-1-paul@crapouillou.net>
        <20190414200824.28348-2-paul@crapouillou.net>
        <CAL_JsqKkYkRQ4jDM9NR_eP4BLaAw=M5f5f5iDYBv4sZGGDzzgA@mail.gmail.com>
        <CAAEAJfBZPvoUd6dT2C6QDO4wsPzpwMpcT-XFwo+Xr4NO+4+jtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le sam. 20 avril 2019 =E0 14:23, Ezequiel Garcia=20
<ezequiel@vanguardiasur.com.ar> a =E9crit :
> On Wed, 17 Apr 2019 at 10:48, Rob Herring <robh+dt@kernel.org> wrote:
>>=20
>>  On Sun, Apr 14, 2019 at 3:08 PM Paul Cercueil=20
>> <paul@crapouillou.net> wrote:
>>  >
>>  > Add macros that can be used with the ingenic,lcd-mode property in=20
>> the
>>  > devicetree node that corresponds to the ingenic-drm driver.
>>=20
>>  DRM is a Linuxism.
>>=20
>>  >
>>  > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>  > ---
>>  >
>>  > Notes:
>>  >     v2: No change
>>  >
>>  >     v3: s/_DRM//
>>  >
>>  >  include/dt-bindings/display/ingenic,drm.h | 28=20
>> ++++++++++++++++++++++++++++
>>=20
>>  DRM is a Linuxism...
>>=20
>>  >  1 file changed, 28 insertions(+)
>>  >  create mode 100644 include/dt-bindings/display/ingenic,drm.h
>>  >
>>  > diff --git a/include/dt-bindings/display/ingenic,drm.h=20
>> b/include/dt-bindings/display/ingenic,drm.h
>>  > new file mode 100644
>>  > index 000000000000..c749b8c346fc
>>  > --- /dev/null
>>  > +++ b/include/dt-bindings/display/ingenic,drm.h
>>  > @@ -0,0 +1,28 @@
>>  > +/* SPDX-License-Identifier: GPL-2.0 */
>>  > +/*
>>  > + *  Ingenic JZ47xx KMS driver
>>=20
>>  Pretty sure this file is not a KMS driver.
>>=20
>>  > + *
>>  > + *  Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
>>  > + */
>>  > +#ifndef __INCLUDE_DT_BINDINGS_DISPLAY_INGENIC_DRM_H__
>>  > +#define __INCLUDE_DT_BINDINGS_DISPLAY_INGENIC_DRM_H__
>>  > +
>>  > +#define JZ_LCD_GENERIC_16BIT                   0
>>  > +#define JZ_LCD_GENERIC_18BIT                   16
>>=20
>>  We have some generic properties for defining the bus width already.
>>  Plus, in many cases this can be implied by the panel compatible. The
>>  exceptions are cases such as when both the ctrlr and panel support
>>  multiple modes.
>>=20
>=20
> In the same direction as Rob's comment, I'd like to see these=20
> decoupled
> from the register value.
>=20
> Ideally, we'd like to reuse this driver and its bindings for JZ4780,
> and these values are already different.

Well they are not any different on the JZ4780, I just checked on the=20
manual.
But yes, I don't mind getting rid of that devicetree property and its
corresponding bindings file.

The major problem is that we don't have a way to map some of the values=20
there
to DRM macros. I sumitted a PR to add a MEDIA_BUS_FMT_RGB888_3X8_BE bus=20
format
(that I could detect to support 8-bit serial TFT panels, which is what=20
the
Ben Nanonote uses), but I miss a way to detect the special* TFT panels.
I will leave these aside for now, but I want to support them eventually.

Thanks,
-Paul

* "special" TFT panels have extra pins (CLS, SPL, REV, PS) and seem to=20
be a
thing from Sharp. Ingenic SoCs (as well as i.MX SoCs) have the required
hardware to drive these panels.

> Thanks!
> --
> Ezequiel Garc=EDa, VanguardiaSur
> www.vanguardiasur.com.ar

=

