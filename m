Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EE6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C764720645
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556764796;
	bh=7TAA9TSH3bfALKXpxOJuPdMMWzul8unkSp1KD77tTFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JVsthQuADtTml7z3yOBEnRVGCt9j1Svh7VnVsby1ObGgmenq+NK0TgpYXMeXkEpSf
	 muLDvPyPvTkqCA/GVuhb0axCQ0ppFYISmTWFaU30Yn5YGsPXdIEvkFq+Jae//mxLzF
	 RUWoGvBrzJoF4gDcdFTa3LQZ4NRKRnKtNqFDzVFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEBCjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:39:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35282 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfEBCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AOg+ZncfoqT6OZPyimiwJ+flH8XXCIhe4A54zI2KK28=; b=Cb5V6HQQ4gnGG3LZN1YTJSqcw
        pulWeJA0UGmo7LW4DpqAG6I4UuXXDLRLzIDRKL+XkUg3SdVIEaZ8q1FeB1/44M+YWpm/ZqUWVxrNV
        +e/NtKkTZ8jt/JEG83MKeTPQA7Po//H3Id7lWSYCTfnhB3P1+t6BATI/zGJEh3O65Bi5U=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1dU-0005zv-N8; Thu, 02 May 2019 02:39:49 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6F730441D3C; Thu,  2 May 2019 03:39:45 +0100 (BST)
Date:   Thu, 2 May 2019 11:39:45 +0900
From:   Mark Brown <broonie@kernel.org>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190502023945.GA19532@sirena.org.uk>
References: <c4cf809a66b8c98de11e43f7e9fa2823cf3c5ba6.1556417687.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <c4cf809a66b8c98de11e43f7e9fa2823cf3c5ba6.1556417687.git.shengjiu.wang@nxp.com>
X-Cookie: Vax Vobiscum
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2019 at 02:24:54AM +0000, S.j. Wang wrote:
> Add pm runtime support and move clock handling there.
> Close the clocks at suspend to reduce the power consumption.
>=20
> fsl_esai_suspend is replaced by pm_runtime_force_suspend.
> fsl_esai_resume is replaced by pm_runtime_force_resume.

This doesn't apply against for-5.2 again.  Sorry about this, I think
this one is due to some messups with my scripts which caused some
patches to be dropped for a while (and it's likely to be what happened
the last time as well).  Can you check and resend again please?  Like I
say sorry about this, I think it's my mistake.

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKWHAACgkQJNaLcl1U
h9DAmAf/ZznWBwoyQXL+nQLRK1eWpBZg9ma0CiFNxH/eUHzwZYIKALZvQ/XtxTgU
loMrwMJLbC8TRCPxVnH77AQRIKS0VJMheOaYCv9wmu+hFNjnEuuhRT0wg/30oMba
gt6LFb/SdSap+9uDN0x6m6BEAoM44d9efhi8M2zc9F9TegdXH1Vehcg9Z+andnzx
0zj6hZtkD22iTm7Cc866VIvc8SfOEsn3TK7mtFUtH3dwX7uJC11HFQnlBcLqyMrV
Wxny0faTSxjZXYxrMJMd7vk7ekzyvb57Rg58Si3234fbU8yL/vOJS8xLNbWjvjYX
4+wYCtvBSLTk76eOCZIBx+Hi2ifAGw==
=YKw2
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
