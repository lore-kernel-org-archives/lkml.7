Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E303C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574BD20811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfCNQ2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:28:15 -0400
Received: from anholt.net ([50.246.234.109]:58350 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbfCNQ2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:28:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B478C10A2E6A;
        Thu, 14 Mar 2019 09:28:12 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zNOWwDIlNz-x; Thu, 14 Mar 2019 09:28:10 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CEAF510A27AB;
        Thu, 14 Mar 2019 09:28:10 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 06DA52FE4653; Thu, 14 Mar 2019 09:28:10 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com
Subject: Re: [PATCH 1/4] drm: Add helpers for locking an array of BO reservations.
In-Reply-To: <CAL_Jsq+rV+yR1xUrpXmGsXuPCwZ2w_D69p-u5L9E0e3mJi7zaQ@mail.gmail.com>
References: <20190308161716.2466-1-eric@anholt.net> <20190308161716.2466-2-eric@anholt.net> <CAL_JsqL-16kyPiWSC=pEC+JLeeJaDBJahnXqOW3Wni5CJcACsQ@mail.gmail.com> <8736nsm1tm.fsf@anholt.net> <CAL_Jsq+rV+yR1xUrpXmGsXuPCwZ2w_D69p-u5L9E0e3mJi7zaQ@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 14 Mar 2019 09:28:07 -0700
Message-ID: <87imwlwhd4.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Rob Herring <robh@kernel.org> writes:

> On Tue, Mar 12, 2019 at 12:37 PM Eric Anholt <eric@anholt.net> wrote:
>>
>> Rob Herring <robh@kernel.org> writes:
>>
>> > On Fri, Mar 8, 2019 at 10:17 AM Eric Anholt <eric@anholt.net> wrote:
>> >>
>> >> Now that we have the reservation object in the GEM object, it's easy
>> >> to provide a helper for this common case.  Noticed while reviewing
>> >> panfrost and lima drivers.  This particular version came out of v3d,
>> >> which in turn was a copy from vc4.
>> >>
>> >> Signed-off-by: Eric Anholt <eric@anholt.net>
>> >> ---
>> >>  drivers/gpu/drm/drm_gem.c | 76 +++++++++++++++++++++++++++++++++++++++
>> >>  include/drm/drm_gem.h     |  4 +++
>> >>  2 files changed, 80 insertions(+)
>> >
>> > Sweet! I was about to go write this same patch. You are changing the
>> > license from GPL to MIT copying the v3d version, but I guess you have
>> > rights to do that.
>> >
>> > FWIW,
>> >
>> > Acked-by: Rob Herring <robh@kernel.org>
>>
>> Was this just for this one patch, or the series?  I don't think I can
>> merge without a consumer.
>
> Sure, it can be for patches 1-3. Patch 4 is dependent on me sending
> out the shmem helpers again.

Thanks.  Pushed the first 3 now.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyKgRcACgkQtdYpNtH8
nuimzA//YxkF1fkf3RwaC3JqLJkTPskb4MQRgUiWP7zcDiYl9JMhcRfBrabvkJlQ
+iNlJUGik9s2buiaTJQl+Js/14gTzuQrQZqQg7WZeMGQ4eQNZopVUq1QtXHxuH3U
cnYbuUzCS0q7VX1rrad5qMM9d+NjNQCRozPAsu4vMMno7x/SKVv2tUOKMcffITeq
80ZTl3NRNN79AEsMtUv62JuvjHKaVi0aMr4lakPg/J79LI6wjeNDWl0RSHLExM7W
8v0T8nwZd7NcIM04ddHhfnVYiYvvB2mKeRx0G4B0rLKHMQPwTO5EfgJwN019E6eh
jLrFGt8K2bwAs7lsFLX/m4N+a7g1VwE9SM/BmW9ZuwFH16lp2d89i3RNXDNfL7Ux
7ZtwZCH48RRN89Afqy7DUO1A5ruwXpGckkbgiIQ8MxIYP5YQr26r5Bk8JemkAjvL
R6O8BQlc8orX2c4j1jyXYWTEq6Zb2JDkWYu+yu9zRzG+RmEZ+656VOnj0T9EQ0MT
ZBgTdMUKxJsPRrDNkPCG7xWe1utY4qhw+E82XE7ZzO/AOoGQmSv9TOuJlzJg3tLH
akIOHoPop/dWG3/Zdx5WxYU2YSaGR431W4Ktw8tke7Krq2UwqWtAk9rkNayDcVHS
j5SgrBFjgg8GexoeIVEcT5eHDn8LMqWcBOz06avQ1t2/uHIAw58=
=NkRZ
-----END PGP SIGNATURE-----
--=-=-=--
