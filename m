Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E062C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6468C20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCHXMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:12:25 -0500
Received: from anholt.net ([50.246.234.109]:54926 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCHXMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:12:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A893310A2E2B;
        Fri,  8 Mar 2019 15:12:24 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 2ZXDGzLKICeR; Fri,  8 Mar 2019 15:12:23 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 90C6A10A275D;
        Fri,  8 Mar 2019 15:12:23 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 2C12D2FE4653; Fri,  8 Mar 2019 15:12:23 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Dave Emett <david.emett@broadcom.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Subject: Re: [PATCH v4 2/2] drm/v3d: Add support for V3D v4.2.
In-Reply-To: <CAApk1dVbYaxBi7LVNgvVBabCZaWp7=yJ5YDMq3ozz4-peZnaGA@mail.gmail.com>
References: <20190308174336.7866-1-eric@anholt.net> <20190308174336.7866-2-eric@anholt.net> <CAApk1dVbYaxBi7LVNgvVBabCZaWp7=yJ5YDMq3ozz4-peZnaGA@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Fri, 08 Mar 2019 15:12:22 -0800
Message-ID: <87k1h99d0p.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Dave Emett <david.emett@broadcom.com> writes:

> On Fri, 8 Mar 2019 at 17:43, Eric Anholt <eric@anholt.net> wrote:
>>
>> No compatible string for it yet, just the version-dependent changes.
>> They've now tied the hub and the core interrupt lines into a single
>> interrupt line coming out of the block.  It also turns out I made a
>> mistake in modeling the V3D v3.3 and v4.1 bridge as a part of V3D
>> itself -- the bridge is going away in favor of an external reset
>> controller in a larger HW module.
>>
>> v2: Use consistent checks for whether we're on 4.2, and fix a leak in
>>     an error path.
>> v3: Use more general means of determining if the current 4.2 changes
>>     are in place, as apparently other platforms may switch back (noted
>>     by Dave).  Update the binding doc.
>> v4: Improve error handling for IRQ init.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
> Reviewed-by: Dave Emett <david.emett@broadcom.com>

Pushed to drm-misc-next.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyC9tYACgkQtdYpNtH8
nugMbhAAkYnXB+tHB8yD7aP/1tw5vpi7JLJ4jz6FZVjfeFxXN02QeKSOcnRlmyzN
ShASbstuJ2QzpPr+6cZ08RrJSgCGUVnz/AhtCyZlOOG+Iz9rZuAfMuIhicEOwaYL
FnDFjcPCCfJLoYygDlEtH1cimk3JyKoMGPEpYcdG56l1KJaPwaA3nNqKhRo2FShs
cdNXddWLJKjTQW6PaJAynWdcrBNGHqws1GpzTqittDGzHL4oLGECIhVPrSk6u0GE
gtI/kYQ5a99hi8FVEZegKrU5V/ygTKi3LulUNoJawTZFUot+0McQb6KsGhnltm+/
B+kXq8t7Iqq1ddOx/VJjjaeQgHvAgVqY1TjL2UCYhwfkiUtzMXxlppNEmptU4ZrW
R+EBXcTXGc2xBTqycM7HHapB/8KMFVe4wS+H15TgMU67Jbt0LRrkUHMqJFW3vRxd
31U8u8pJmWMxLjQfPTIHtoO2CjauIfcBxWduUwHdXpLxYBlaH181QvPRO1hJnAD+
pGelup6HFAnVc0Z9QVpyJAlK52+Okt0IM4iKWjIYETjjinhzUOyTBv4N/YL6whxa
qmJxvEM6QbQzeO9TZ/FBa124fAXkKL6+KzxhA+P253Zr5D+EfbXuvrAbspUHIcCb
Md95LxCyJEkpT4m/bv9RS/vpmfYnqIMTMz1JMUJQkN0AiirRtMM=
=gGBR
-----END PGP SIGNATURE-----
--=-=-=--
