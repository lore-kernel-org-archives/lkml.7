Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E7CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE63420830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124015;
	bh=1lsTLTacUge/TmK094kPtZgnZ5shmTQX/+pqj5VYXjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nnsoeb74C/DZ7CyX1b4z1IY3MmqUyGEi70q+HXOAVp3F385wYN9PdMfQAcgj8fjZb
	 2mbvihS7omKANwJ58OkvQNw2AcZl2Og3P31mKu4utK1kkZGzCjiCy1Zgqna4afvhHV
	 hgar2AxJvJh2VrLiy48wKMaewfjiw5EuF/xajs2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbfJCRdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:33:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53724 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732705AbfJCRdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1lsTLTacUge/TmK094kPtZgnZ5shmTQX/+pqj5VYXjE=; b=re036ledOxvJgkwTEi0ql8CqX
        uqD9VjHxS8mTVjj0ThUKiclF4XhTek9fMKqjW4oXRYJwD5MacDUoqB9/3eTCfjMGbbMiWPrahAVDp
        TxEvPEaF88oafdaXTj69DBU0VUbUnGN8V6Rau9S+3uF9jDtqnLGk1s8+zeC72R5dZEkEw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iG4ym-0005vr-JL; Thu, 03 Oct 2019 17:33:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D07612740210; Thu,  3 Oct 2019 18:33:27 +0100 (BST)
Date:   Thu, 3 Oct 2019 18:33:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.3 204/344] SoC: simple-card-utils: set 0Hz to sysclk
 when shutdown
Message-ID: <20191003173327.GC6090@sirena.co.uk>
References: <20191003154540.062170222@linuxfoundation.org>
 <20191003154600.389003319@linuxfoundation.org>
 <20191003172849.GB6090@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <20191003172849.GB6090@sirena.co.uk>
X-Cookie: Reactor error - core dumped!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 03, 2019 at 06:28:49PM +0100, Mark Brown wrote:
> On Thu, Oct 03, 2019 at 05:52:49PM +0200, Greg Kroah-Hartman wrote:

> > Some codecs set rate constraints that derives from sysclk. This
> > mechanism works correctly if machine drivers give fixed frequency.

> This is a new feature which seems out of scope for stable - I thought
> I'd raised this already?

No, I didn't sorry - that was a similar patch in a device driver that
I'd flagged (and has been correctly dropped).

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2WMOYACgkQJNaLcl1U
h9BuXQf7BIZUChyxBFPjAWKEbc9ifRghqSEGtDwFhm+kNuPma03Ue2Azp+uqISuZ
XDANYfw0mMFJBSPGqXS2xLtpL4KZu3cv3lFRNWWC3mMpHV5bnwWrw+jhN28aT5z8
7nwxAAGoWXtE4N/ecTEeUqCYBEUp9RwV9QApnBWC9Y9achU741W691H9XXIaUYB3
hOgpysLCGryH8PVNxIR+MYzWcvwRtBmNoMW0KSX76YUYZYsLnc7717GZcUXx0qEO
xK1TBJmUeH9QPxj3x7VI9kNXdwHATHqe1HOU1DEQYvN6molKbGF6S/ANpt+k5iVl
oDgD0Gb/+EFrkQRLkGdb+enxosxdtw==
=4XgQ
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
