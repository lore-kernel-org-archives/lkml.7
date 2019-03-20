Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A496C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E7A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfCTJpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:45:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40467 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfCTJpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:45:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so1939316wri.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/5Jq/1A4wnNU45uP0a2SlC5SWn4VZjmGVVWgkyU8b6Q=;
        b=QvTYKidPjVdc/Z+pFwJkND2xKX/ZScvIwgjDt0DNwExWePLStnCo/rPBLR5WN1JpdL
         fakLHcaihvNUZRXFyZQ0tyTmxOArIPXIaFMRocTuhfaTMLnNvCNnK4ZV77JegcwNIQKB
         zg3EZct0BGaOV3zcyGVS0WqtjP2ayCyuNZgQ9FXR6XNEPrPzaJHP/bL/ayMJCXf6ai4a
         1IpqQW3B7Rjb/7ZR7oB94Sh2DrfQc6KmfYLUoftBllSuc0RbtpaHGXVOlv5nw0v2jTHT
         8tUeGGAAnr1ZRb7biAtAJpTib4/FBRIzRUcTB4BB9ytxCKC6O3Kr4aH0h8e6rIWIE2gw
         s0Qw==
X-Gm-Message-State: APjAAAV3CebMvjxT+HS1hl0I9C4xKizndiOFjlNgGx24zb/JP67qlZOs
        NKq1X6C0nWeP+prubIglRlvykgkIFEU=
X-Google-Smtp-Source: APXvYqzII/fmq2lFyYDmCPW3x4gl3JslO9q1l87eIxW6hq+HHlFlkhJTlM2Tth2VSEq8y9DUCy8RPg==
X-Received: by 2002:adf:90af:: with SMTP id i44mr20781788wri.222.1553075108830;
        Wed, 20 Mar 2019 02:45:08 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id o10sm1234925wrx.82.2019.03.20.02.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 02:45:08 -0700 (PDT)
Date:   Wed, 20 Mar 2019 10:45:05 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190320094504.GA16193@localhost.localdomain>
References: <20190320081549.7112c33c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20190320081549.7112c33c@canb.auug.org.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi all,
>=20
> In commit
>=20
>   13f61dfc5235 ("mt76: fix schedule while atomic in mt76x02_reset_state")
>=20
> Fixes tag
>=20
>   Fixes: e4ebb8b403d1 ("mt76: mt76x2: implement full device restart on wa=
tchdog reset")
>=20
> has these problem(s):
>=20
>   - Target SHA1 does not exist
>=20
> Did you mean:
>=20
>   004960423fe1 ("mt76: mt76x2: implement full device restart on watchdog =
reset")

Hi Stephen,

yes, the right Fixes tag is:
004960423fe1 ("mt76: mt76x2: implement full device restart on watchdog rese=
t")

Sorry for the mistake.

Regards,
Lorenzo

>=20
> --=20
> Cheers,
> Stephen Rothwell



--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXJILnAAKCRA6cBh0uS2t
rLs1APsHBqDbJ8Dnrh33NzyBoydGceQK5C9X0KLG7NNv2zDm+AEA2CUnUhrv+gGQ
4h9qAzCppfRa+tbcAkyvr+pprstOPwE=
=0ehf
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
