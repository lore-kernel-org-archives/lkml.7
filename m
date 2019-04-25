Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BA6C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC96E2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556217471;
	bh=T8ncurE8J1D8op2iKGGPRuLMRlW32hNFlZzVr3FFO8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KhzEd/5h0zawQoLsslSITPEDewvL5kHSauHeGypZzxFTJ4JA6mEgyIxlKYODT9jsN
	 LCCwVUcNn+OpNxTjCp1HWMxvEPFZYFbPlRZluCuzihdhB1cGmlljAvOpASL/Yb2xgX
	 d9tQYTSiNx1oxBP7P2i7Or+DKuoKKxMyCm0yc8Mc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfDYShu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:37:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54864 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfDYShu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nSIfCqlsx2G+8+G5t23TY+XHbHiOh9kZsU20xPG2v1M=; b=exnzUHlNpzmHwn5XHFYkoe7/d
        PZ5KYKhHzwVHZsMdHOAVWXx5a7psDNSwFphhKR45k+t3p7qaRAZ2PZIMeFYyjKjn7LKgHLDXJ5l38
        oF2TlKuh+18FAyZI0bzvVhoHsPs6tvHgTvPsnMlm9M6cn/PZghT/EQCZfNolxfu71+ykk=;
Received: from 188.29.165.56.threembb.co.uk ([188.29.165.56] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJjFa-0004EV-Sj; Thu, 25 Apr 2019 18:37:39 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1FD68441D3B; Thu, 25 Apr 2019 19:37:36 +0100 (BST)
Date:   Thu, 25 Apr 2019 19:37:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        niklas.cassel@linaro.org, khasim.mohammed@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: regulator: qcom: add PMS405 SPMI regulator
Message-ID: <20190425183736.GF23183@sirena.org.uk>
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548675904-18324-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190204090301.GC23441@sirena.org.uk>
 <95276ca0-6896-a595-867a-184a518fa31f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Content-Disposition: inline
In-Reply-To: <95276ca0-6896-a595-867a-184a518fa31f@linaro.org>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 19, 2019 at 07:29:48PM +0200, Jorge Ramirez wrote:
> On 2/4/19 10:03, Mark Brown wrote:

> >> +	/* we know we only have one range for this type */
> >> +	if (vreg->logical_type == SPMI_REGULATOR_LOGICAL_TYPE_HFS430)
> >> +		return range;

> > Rather than have special casing for the logical type in here it seems
> > better to just provide a specific op for this logical type, you could
> > always make _find_range() call into that one if you really want code
> > reuse here.  You already have separate ops for this regulator type
> > anyway.

> sorry I dont quite understand your point.

If you need to skip the majority of the contents of the function for
some regulators just define a separate function for those regulators and
give them different ops structures rather than using the same ops
structure and handling it in the functions.

> But also I am not sure I see the benefits with respect to the proposed
> change...

The benefit is that the selection of which operations to use is done in
only one place (the selection of the ops structure) rather than in
multiple places (the selection of the ops structure and the contents of
the operations).

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzB/m8ACgkQJNaLcl1U
h9DS4gf/bAbnyiU2v4l44+1nIFu1Ffa/AwcPHiVzkuINIa7V6xi3h/yxk1Cr4s43
aXJvrdZ/ntwIw4bKuV8OyNDwFgO5yICJmECx6aBP0ripdl7pC9dUg72aalbcr0z9
7Q9G+HDvgk+g3iFWbVKzKvjzyAuczqQUQApPIYUNmMN9GCvCBp3AZcrE8bSA9fW4
jBg4bnkesubO/6c4S3b1guJV/+/EviDML4LxpOTUuhXd3lVWyzrRdNZoGMAmn5U+
Eq5xWl1UQY8jXLPLvqU3/iS1cv7IPvfzoKez/nYHIxibVNREG3R4iq/jDnKZZkuv
vbmbmthnr1zVnDQmehWKd6qumeH+Hg==
=GJ7z
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--
