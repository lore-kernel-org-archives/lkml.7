Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39936C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A56D2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567767594;
	bh=nri1cRvD93fS1FSuajViJZ1Z2+h/3WzUxR8ezWWos1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G1wrRXjpk/pTcULZcZNEGDsEAQrR3ewqhxXYi9JOczRr08kQVxCAdRJGXpcBZlbHF
	 I08nMnXtrfJIAbDoBenhUy3bHcjYeuZ2eOFfifaX4SJ2SPHcd6Ck0Ms0ngPE2XWY7J
	 dO0CbFqxHHc/wf+DKUBGEVhgW66bklOy7NCvtMM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392130AbfIFK7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:59:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55946 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbfIFK7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nri1cRvD93fS1FSuajViJZ1Z2+h/3WzUxR8ezWWos1k=; b=efv0xVakc5gcr9ZGopxiCSdI+
        SjXGitf9TSrgiuS6OByVO1M/MQKQoSXt+cBhS9lxkjkOf80W9Vg9br6JnyurOLa7geq1GyorJzf1L
        z3bvJNdz0shL4xHdBuUOkTh9XbxLKb5PUM1Lh0a6r3MVUeTJuQzRabDixPWE/40VodJVY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i6By0-0001TN-U1; Fri, 06 Sep 2019 10:59:48 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 6454FD02CE7; Fri,  6 Sep 2019 11:59:48 +0100 (BST)
Date:   Fri, 6 Sep 2019 11:59:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ricard Wanderlof <ricardw@axis.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 06/77] ASoC: Fail card instantiation if DAI format
 setup fails
Message-ID: <20190906105948.GT23391@sirena.co.uk>
References: <20190904175303.317468926@linuxfoundation.org>
 <20190904175304.060004729@linuxfoundation.org>
 <20190904180952.GF4348@sirena.co.uk>
 <20190905185648.GB24873@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CMebLzmeJATad/OR"
Content-Disposition: inline
In-Reply-To: <20190905185648.GB24873@kroah.com>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CMebLzmeJATad/OR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2019 at 08:56:48PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 04, 2019 at 07:09:52PM +0100, Mark Brown wrote:

> > I nacked this patch when Sasha posted it - it only improves diagnostics
> > and might make systems that worked by accident break since it turns
> > things into a hard failure, it won't make anything that didn't work
> > previously work.

> Now dropped.

Thanks!

--CMebLzmeJATad/OR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1yPCMACgkQJNaLcl1U
h9ALpQf/WK2yXkTwMdpeaQVPdDYQVdZkwsV7MP3epmkRJw9MI+bD/677eAW8GJnc
Q3DT3rHaaci7UGTXIiBeWkdoxI44lEaFqQtEuDBorC/2eFCRxdsJMDdBQDGKifXM
yjvcpWWPSOd8HRK65p/mJSUx0Whz8lrGruR3QzzWlXQAFuqXJFVRb01QPOIC2pYi
zXzLs53IaBdj4fFSBT/K4a7YivqRvPq0dGJQpbNe0JjLTC+Y+i/Lg8vhcYN6u1Wu
nJSLEgF2DEPeEGCqdnapFhyeF5FBbF0Ipwydgng/UmLwmS1nfPsiF8uCFIYcv6aM
JcI/REqMlowLymx659maPP7jsAzKlA==
=A9pj
-----END PGP SIGNATURE-----

--CMebLzmeJATad/OR--
