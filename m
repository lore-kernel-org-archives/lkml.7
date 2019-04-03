Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080D1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE2E2133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDCTPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:15:32 -0400
Received: from anholt.net ([50.246.234.109]:34024 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCTPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:15:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7D69710A2F03;
        Wed,  3 Apr 2019 12:15:31 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 0oU17i2LBtXg; Wed,  3 Apr 2019 12:15:30 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 292B410A2DD2;
        Wed,  3 Apr 2019 12:15:30 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id B020F2FE3483; Wed,  3 Apr 2019 12:15:29 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 2/2] drm/vc4: Disable V3D interactions if the v3d component didn't probe.
In-Reply-To: <c153b5bf62825718216dc54a2f79c291f84eb24f.camel@bootlin.com>
References: <20190401183559.3823-1-eric@anholt.net> <20190401183559.3823-2-eric@anholt.net> <c153b5bf62825718216dc54a2f79c291f84eb24f.camel@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 03 Apr 2019 12:15:29 -0700
Message-ID: <87bm1moq7i.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Hi,
>
> On Mon, 2019-04-01 at 11:35 -0700, Eric Anholt wrote:
>> One might want to use the VC4 display stack without using Mesa.
>> Similar to the debugfs fixes for not having all of the possible
>> display bits enabled, make sure you can't oops in vc4 if v3d isn't
>> enabled.
>
> Just thought about this: perhaps we should be returning -ENODEV instead
> of -EINVAL when !vc4->v3d, just so that the error is a bit more
> explicit to userspace?

I like it.  Doing that while applying the series.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlylBlEACgkQtdYpNtH8
nugVaBAAiL1YcEpP77T4qlkmL2FNDFcSRt6dsyldUZPGcj3aqltXF4N6rjT/+xp6
l9md04QkPb15W1CNDOqtEMTBr9oq3U1m6ULITCP84Je1pzbZ5Etf5dfXeHMBnKJ5
NSX6i8u5uuqopEZS/RucilsOrxQvithN6HVtrvqU8SR/dY/Uti6VB306WGEa7RTZ
QwdOUjcAL5uLMUS6AhrLr/csuNtUDnAKqdabeOQFdpCffZFudA97ik4LhFG8RaTk
dB1sHqwNkasPwjI2cxm2yolLgnoI6qEP9HkJ30lcinG16F2ViW8adtGkfEDISHL7
5iXXJqmBo7qDWViqTynF77KAoxrOz9LnesxrvHmH1vBaBSmgXobPpj6rYMftJaIq
CPh4di5/aiN8C3rLO+M7R3NZ0n7XYT3x+4y2PbiGwwLgsyQZTvqscaRNiZZk/Z7V
WAVLmyQO2PkprLGMxjlrXh1MKOYW1roc9oJb3pyNgs+dGLC8upvyHrxqNGYbcqsz
xqhBoaNz+rTIxIohvxRXIUoUbylFCdZq0RvBAl8oFyyJfI4LnldLHi9980hLpBiS
e/XvtPEfW+XyS8j7MO8mpIRTivqj3yIqcrd6isHo6WzZCRnFQdEbPS+sxu0uyMiR
zEWWc+h2jCWOVHY6rDHXo8n821HxtYy6esT4NTdNhdv2rK8aiV4=
=WQsh
-----END PGP SIGNATURE-----
--=-=-=--
