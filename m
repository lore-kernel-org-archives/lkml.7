Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18291C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EE82075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfDBTwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:52:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfDBTwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:52:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9B4AAD63;
        Tue,  2 Apr 2019 19:51:58 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     George Hilliard <thirtythreeforty@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 03 Apr 2019 06:51:49 +1100
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkam?= =?utf-8?Q?p?= 
        <christian@lkamp.de>, Nishad Kamdar <nishadkamdar@gmail.com>,
        Sergej Perschin <ser.perschin@gmail.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 03/16] staging: m57621-mmc: delete driver from the tree.
In-Reply-To: <CACmrr9hZRiw10dDVcvFUFB7ZFzFq-WfELRXnTLOM_j5LoNnw3A@mail.gmail.com>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org> <20190402103203.14959-4-gregkh@linuxfoundation.org> <CACmrr9hZRiw10dDVcvFUFB7ZFzFq-WfELRXnTLOM_j5LoNnw3A@mail.gmail.com>
Message-ID: <87r2ak18yy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Apr 02 2019, George Hilliard wrote:

> On Tue, Apr 2, 2019, 5:32 AM Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> wrote:
>
>> The license text in this driver is "interesting" and not really obvious
>> that it is supposed to be able to be distributed in the kernel source
>> tree.  Yes, the MODULE_LICENSE() text says GPL, so it's probably ok, but
>> to be safe, I am deleting this driver.  I will be glad to add it back if
>> the license is properly sorted out, but for now, this isn't worth the
>> potential risk, I should have never taken it in the first place.
>>
>
> So, for what it's worth, this driver has an obvious heritage of having been
> modified from the main Mediatek MMC driver. Now, of course it's *possible*
> to distribute GPL-incompatible changes to a GPL program, but the only
> *compliant* way to distribute these changes would have been the GPL.
>
> So there's a very good chance that it's intended to be GPL.  (Which is
> good, because I need this driver!)  I suppose we need to reach out to the
> original contributor.

People keep telling me that drivers/mmc/host/mtk-sd.c should be able to
handle the same hardware as this driver, with a little bit of work.
Unfortunately they haven't told me what the little bit of work involves.

Have you explored that possibility at all?  I might try to have a look
if I can make time.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyjvVUACgkQOeye3VZi
gbnYNhAAl32AjR7b/Bpums50JkMbYkj3zKbOqrhdqORyjtBYCGIbf8LrCv7nxEOj
CqkPh9vkZKmvjpMZ13fa8trRW5R1AevNuUOZML0EPOolKitjR+SM0wfjnDG24f3x
3yFX57Js509+3ii2LUmLwtTAIbfPQverqBnr1cCQbYHVICRRs6o0ZIHM4To7SQVk
+XDYgm4lSVjHUvZ7QqAod8xr/xh81S5NTMqC48iH1CsItZyNxl1m2DjNeOtw7SLl
hQC4yFdrC+zhlQHaMSoYVOk0kfgXTJK9rb52I2I2QAgsqnHXas23yRCbRcGxLB3g
NBnK14DJxVtYsEkVoCR5PcgVwq/jCgAe9UuMEX9/Ey3Pbn+ShlI1O+ckoyqiJtZv
nH/Z/XR0gnuhhiMQOFDtzP6ZUjARYwH0DLUeiQQ9rK2JzmBy4yYfRPkzpWgMFpHO
J50UsmxdO6AaqCU1ttq2MtT5yQV2lv24Qn6z3jhd0OPDaNW3W7bWX+gDZBS/X31b
8VJPaAsx282AHPvxMscdD5pGZ+gXSbGBFvWYbobnsjPhH9YsMaFxbPK39zE7tbw8
JRJm1IL0m35Iz4jBqIG0+U9T/zyibxAn44QlBkmgsjwP8cBnQjxHQKPRYx/v9cRy
dDJlyzSRPZSiOoM8KaOdhbswO8/BkQktdPOjFx6Py9gsI00GaKQ=
=vXHR
-----END PGP SIGNATURE-----
--=-=-=--
