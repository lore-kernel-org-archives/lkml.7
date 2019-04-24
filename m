Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46365C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14620217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EpRpTpHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfDXBQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:16:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60607 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbfDXBQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:16:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pj7g41Qhz9sMM;
        Wed, 24 Apr 2019 11:16:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556068575;
        bh=V0+cLjXauvxMBVhOAIGpVo3YHaDdfjuc+UO04uJiMzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EpRpTpHT1Xxnm83sQTNdVg5cZjCuIn3vjDwACVxBV8PGQbPJpr63zLCeOcyeWi07b
         QhVEkOHkyRW9WE03bdyUq/Bh141HON4586/KZCbxtyBsclO+mjEdGXQLY0xWcrRR+s
         8N83QvmDDlpFXvw00RDxVbhYK09Y6lLhcYtuqpbZs4CuVllaleJPeiUV+BFwGQzaUb
         WknxVThHrr4aUd0SlMP7mEJzgzjrsX8/KoOU5yop5NnYrCi0zgmJ/xNg4hkx8SJ7Q6
         Vm596QEyfUtOiKyYv9ekJg9zFEPbo/QKmGM71GcR/SjjszGVKF+EyyTf+vXqvq0YTG
         XWAu8px1Npt2A==
Date:   Wed, 24 Apr 2019 11:16:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] ARM: dts: qcom-apq8064: Fix DSI PHY ref clk phandle
Message-ID: <20190424111615.6fa69e0c@canb.auug.org.au>
In-Reply-To: <20190424001210.201672-1-mka@chromium.org>
References: <20190424001210.201672-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+Hh9m.f/Xh.LOt20Y3ngziC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+Hh9m.f/Xh.LOt20Y3ngziC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Tue, 23 Apr 2019 17:12:10 -0700 Matthias Kaehlcke <mka@chromium.org> wro=
te:
>
> Commit 3560af5a56b5 ("ARM: dts: qcom-apq8064: Set 'xo_board' as
> ref clock of the DSI PHY") specifies the non-existing phandle
> 'xo_board' as DSI PHY ref clk. Fix this by using the correct
> phandle is 'cxo_board'.
>=20
> Fixes: 3560af5a56b5 ("ARM: dts: qcom-apq8064: Set 'xo_board' as ref clock=
 of the DSI PHY")
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

You should keep the tags in one group (no blank lines between them).
Also, you might like to add a Reported-by tag when you get reports from
others (unless you discovered this yourself, of course).
--=20
Cheers,
Stephen Rothwell

--Sig_/+Hh9m.f/Xh.LOt20Y3ngziC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/uN8ACgkQAVBC80lX
0Gy8vQf/UMgtKv/PcwntGHQ83KYFMtIul/9SCrcJUiJ7CIfE8/gfpKdN7U+2DUg7
H2pv0UI02tPJ/35mk6AgfkrNduW6dEslBVtp2Z04Mq308J10y1ulHXaEQ3Mk0fN9
Pq1696YSAp8FfsW4H5XR/3xWm47JT5wCc2EeSdhHvAJIJstMZpmh8Z8UU+BI4GuL
FLwE11g1D3hmiyC7CgVZz7xRa9d73+5TVLoLGlZPXLnpEJBNORNUDCn5LOsVVqOW
zWJk9uIfR2WzHv+Y5puES+JImPmtJ/CSBDVT8LfbUUQcHNb7kxl1vuCrSQjDvA6g
ZrXwqxnUe2eryHXy+zFbs1TorTGDZg==
=g8aX
-----END PGP SIGNATURE-----

--Sig_/+Hh9m.f/Xh.LOt20Y3ngziC--
