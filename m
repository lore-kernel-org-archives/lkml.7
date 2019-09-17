Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C471C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0825C214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568750259;
	bh=tuB5cHS4dkn6YcimQIU63AlBaxwDMtU7dRr1gOjN1I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rLlGPPddBItF+Te6pXnfXdy0GcEdDoE7vfXcdTv9zsLbEdnnZq111glLOmmVrAzHr
	 IU/51umcLFQPxckCT33DPhEf5K1Bf0qOB6qoYfj3tY22cOlEEmxCOc85uEpX0bZuy/
	 iMKbLPqjpyvDhUD3kyCqh2wbYWiIoOy4iJkUJbn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfIQT5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:57:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55534 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIQT5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=61LTuPkSN5x9DFXM7C9aY5FpFIcjYyGAu/QnSRBR1+k=; b=cXmRGY0PWz036MgdZERuORall
        5lEYKs+eLscEcXvHhgLBBCyAPJhFbonRnwqJdlCWw9oFFrJtfWU2sx2BdgXCHDgfABu+sUUNY5QnO
        7yicHIH+ooXY6UvYdqZfCNqrSbLHHasI/00J+A036dDZ+2qlbbvuS5TdzQuOjFpwKaCaM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAJbI-0000Sa-CD; Tue, 17 Sep 2019 19:57:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2E53627428EA; Tue, 17 Sep 2019 20:57:23 +0100 (BST)
Date:   Tue, 17 Sep 2019 20:57:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Mac Chiang <mac.chiang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: Build failure after merge of the sound-current
Message-ID: <20190917195722.GG3524@sirena.co.uk>
References: <20190917103858.GA3524@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pql/uPZNXIm1JCle"
Content-Disposition: inline
In-Reply-To: <20190917103858.GA3524@sirena.co.uk>
X-Cookie: Know Thy User.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pql/uPZNXIm1JCle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2019 at 11:38:58AM +0100, Mark Brown wrote:

> IIRC there was some previous discussion of a dependency on other changes
> here but I thought that was resolved?  I've reverted that commit for
> today.

This wasn't resolved, Stephen's been carrying a patch for it in -next.
I didn't see this mentioned in the pull request for sound to Linus...
might be an issue if it gets pulled before tip.

--Pql/uPZNXIm1JCle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2BOqIACgkQJNaLcl1U
h9DUCwf+LB4ciD6K1POX0vMybBYDmoaK/pFqfxrWoarg2KptPZYr8EVbbe56EATh
ALFE39oibY/d79DrZAgo65uSrx/GHL82HG5xa+3nxoo7ERTvdEmSyj4bEczgBTn7
nmjEmpUkjogq9onvaEUkdcagnAmrVto/6PZwUiM4+4uvj+Sy9y7DjJ3GSMUgAuFy
ACb127VJn5Dr4dM307HM5jhk2bOf3ojt6QMRnh+6SjnvpV2Nzm1DM4OEB8nei0Uz
Mk0CwyAibs/ojrpOHl7i5OVnphz/lj+RLwuBZkquXrFkdme1ST/0c2Ld+N7YQZ8d
wfaSwZ1HHv/PVXd5AtvNvWiKg8MfEQ==
=DCvp
-----END PGP SIGNATURE-----

--Pql/uPZNXIm1JCle--
