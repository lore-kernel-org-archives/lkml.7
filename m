Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388C3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE9B21019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfCMWO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:14:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:39888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbfCMWO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:14:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8FB35ABE1;
        Wed, 13 Mar 2019 22:14:55 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     John Crispin <john@phrozen.org>, Stefan Roese <sr@denx.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 14 Mar 2019 09:14:42 +1100
Cc:     Armando Miraglia <arma2ff0@gmail.com>,
        Armando Miraglia <armax@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sankalpnegi2310@gmail.com, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in spi-mt7621.c
In-Reply-To: <4172ce05-8dfc-c956-6af0-47c8367c215e@denx.de>
References: <20190313122403.248873-1-armax@google.com> <eb85ea17-babd-fe3a-f0ff-9c7f13498bd1@gmail.com> <CAJsYDVKF-3jZo4E3EMiYOqeWXVLu0hBra6Qp0sFoCz8y=BAjSw@mail.gmail.com> <4789d739-d2b5-357b-b9d8-bfaf587d33fc@gmail.com> <4172ce05-8dfc-c956-6af0-47c8367c215e@denx.de>
Message-ID: <87y35ipgkt.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13 2019, Stefan Roese wrote:

> On 13.03.19 17:46, Matthias Brugger wrote:
>>=20
>>=20
>> On 13/03/2019 17:34, Chuanhong Guo wrote:
>>> Hi!
>>> On Wed, Mar 13, 2019 at 8:28 PM Matthias Brugger <matthias.bgg@gmail.co=
m> wrote:
>>>>
>>>>
>>>>
>>>> On 13/03/2019 13:24, Armando Miraglia wrote:
>>>> [...]
>>>> Apart from fixing styling issues it would be usefull to see if we can =
add
>>>> support for mt7621 to drivers/spi/spi-mt65xx.c
>>> It's impossible. They are completely different IPs.
>>=20
>> Thanks for the info. Do you know the status of the rest of the drivers i=
n staging?
>
> Just to inform you. We are using this SPI driver from staging
> in one of our customer projects and I will try to move this
> driver out of staging into drivers/spi very shortly.

This is good news! I think the driver is ready to move out of staging
and would be very happy to see you do it.

My only small concern is that this driver was backported to openwrt
(4.14 based) and then reverted

https://github.com/openwrt/openwrt/commit/749a29f76ca780d8df70a5163d43bbdc6=
f13ba3f

 "This breaks some mt7621 devices."

Possibly it was backported badly, or possibly there is a problem.

John: do you have any more details of the problem other than what is in
the commit message?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyJgNMACgkQOeye3VZi
gbneUw//Tc6ykAvtBr/kDbHEAweMN/VWb4/GIvWCJcUyy9gxUuli/J5EMbUQNy6v
CbLOczHgPmC6iW3mCeznUExi3WM2si1pHM7n/2YJs223rHkGjv+ZKOTVi622fUg9
IrBWcio0bmCq8cePRWlHlysLJnxUM/DnRiVjWH7MR4LSONRCWCbFkVjs/cYxtjzw
zgPJBRZOaqmSFmMUU2F/HHB/FCej3JbfWEwXi1JHQrf4bRi1470hj0OueDMcugOc
HQoT/HkiOGNJ9YVoKHtwD7CnSx4URn9oRej+5AH69jdmJ+rSlOp4M7ALpw6M1U1E
N9CL1tFFgrPIDiBFULTMV8IOYqkG5uql8337Iv/bKh7OD3C0d+vx+6pv78hxmORx
MqsbpqfKPg4CGeZl6nY/eaeK3XIWjMBhqG+A3uzGP4kyKeyam4ckYgd/g9Yd+wkb
d46Vo2OiVraC4G4YvIn1R6W1leMQqfhaclFO6Vig2/BQTkZOqHJoPC+gp3LERgxQ
bnOTvXTMvCZ0uSe4ynOXRy3X8KpIfMDC5giK9DoFksUD3vVgOvdTceakNK2p4jc1
rpDfkWydTkMqjAGGDQMnuiKEAh14W/GanvpJJ3hrw0QVENjkpVtC/3Rp4tdkoVd/
TseQ3rlDHDC0FcTq/sAYQpqVqYn+F2I4+s8ky0XzcDO+wwGbHb8=
=8aM6
-----END PGP SIGNATURE-----
--=-=-=--
