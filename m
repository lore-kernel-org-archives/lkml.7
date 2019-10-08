Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7F5C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734CD20673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570531867;
	bh=JqURg+5wxqMXI1DWcU3kCPEwpQxiEuiWbQdKM/Jsw6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hTJTtkAo6648uKLIm3fo7iAIaW2jMhve9Fs0RJJGGN/IGTpbj0qIR1taReCfAvFnh
	 /mO+WXGOR4/mDoSzfWCUNUDpAZjeYPQG1u+ZwM8XF7yHi2Q1MkjqvmStkQNQ158FJP
	 lgblVVavSRC/t30XbckWHwB/4oDXciB5u019IT7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfJHKvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:51:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44526 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfJHKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RR/ChvfDz3Yyh20B5rKzG7TQ93tqkk4uOU4aQLJLA6g=; b=Oa/nzX3bclJZH76ualOBXGeKF
        YQmBcsA0LMHN/SdbaGigkBJSyosu/v/uZArFscb19Mjx+pErNX464qnL7iLGyX8AJRTOqopi2ru8V
        SR5pEnwPnhS+RvKJFeRPQnFz4z6pv0QQCwkGgHF/pJ/pqsedSbr7BY9+6yyQbRYPtdWsg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHn54-00082t-P0; Tue, 08 Oct 2019 10:51:02 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CCAE92742998; Tue,  8 Oct 2019 11:51:01 +0100 (BST)
Date:   Tue, 8 Oct 2019 11:51:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [RESEND][PATCH 2/2] regulator: da9062: Simplify
 da9062_buck_set_mode for BUCK_MODE_MANUAL case
Message-ID: <20191008105101.GB4382@sirena.co.uk>
References: <20191007115009.25672-1-axel.lin@ingics.com>
 <20191007115009.25672-2-axel.lin@ingics.com>
 <CAFRkauCW5-+u6npP2fpAaNL5kPdKXQ_wWrZ_7qZkJr=uMP1BsA@mail.gmail.com>
 <20191008104407.GA4382@sirena.co.uk>
 <CAFRkauDq=6X9LRj7APwKOV+7CVZN5OSVuWXmwBQ3QQPWD9Nauw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <CAFRkauDq=6X9LRj7APwKOV+7CVZN5OSVuWXmwBQ3QQPWD9Nauw@mail.gmail.com>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2019 at 06:48:15PM +0800, Axel Lin wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2019=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:44=E5=AF=AB=E9=81=93=EF=BC=9A

> > It doesn't seem to apply against current code.

> I just test apply it and It looks fine to be applied by linux-next tree.
> Or which branch of regulator tree should I generate the patch?

Well, I queued it for 5.5.  I've not seen if it's got dependencies
against 5.4 yet but you chased me so...

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2cahQACgkQJNaLcl1U
h9Ae0wf/SM0YQe1wHC7e73kpo4zeGPYOaFagpOTrSEGryOSt1z8EAsCgN/MctSzc
zVeIbu74Dok1mhlgDjCbfKuVn/gIE+3MFcl3xXRqr/CejnGoS+lk2RhFsl8uwWvz
84TQmJQ3FMyG4GRjd9rDXPiuFE/QlmZghGg6SWSiuQwQmNiNazDhEHzqZmn2naiw
6eWidxLTgh84zBSpEx3U4CsCiQ/Qp+v+G5qQAbDDMGCTCkTix72/EUGV60IscvG0
BPBXjZhFvJHmlLyac+sbAVncfXlK7YBt8Fo648o1KwTYvWVtt3vTitTjRJfPmupO
MesLfifwwclA/ix6iiifODc/dgfWuw==
=XK1E
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--
