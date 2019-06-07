Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8474FC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE8921473
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559933859;
	bh=7YyENcgYWnUWI0h+gXa3lXdPcIrCG64rkMR0qaxWefQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eQh17qzM6TF7R0WY75eW2rmTuP+bjeYSzXFuZ8p2JaNZ0Izz9NSSsBu+2AS/7HGfK
	 8cUW3/f3Ar56N05SUWAynBVgcr/Hw9LRVPjU+z2My5yalybi73h0leC2wGlC8LZI7Q
	 PRBJDrZPTOOjSfN1cthaifLOpsvmdFniO9kbQJAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfFGS5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:57:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51398 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbfFGS5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7YyENcgYWnUWI0h+gXa3lXdPcIrCG64rkMR0qaxWefQ=; b=ijjX8AWy397IdifJa14T0D/YX
        BkXzDVhOp95Tx13tZjLebfD1hROXcd8FgYT5w6FrrMVX5g50APbN9HlO+DU2oj4+jHhK6ljdqeRWg
        3Egtq8SlTs5zgoZ8fZsJfi6AE5qQX5amn5S4BrEICT4xNuyJxzgfzfNHeOmG1u089SiLY=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hZK3N-0003f5-6I; Fri, 07 Jun 2019 18:57:29 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 7BF8C440046; Fri,  7 Jun 2019 19:57:28 +0100 (BST)
Date:   Fri, 7 Jun 2019 19:57:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 17/20] dt: bindings: fix some broken links from
 txt->yaml conversion
Message-ID: <20190607185728.GJ2456@sirena.org.uk>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
 <effeafed3023d8dc5f2440c8d5637ea31c02a533.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hEaoa1KyNVzF3lFU"
Content-Disposition: inline
In-Reply-To: <effeafed3023d8dc5f2440c8d5637ea31c02a533.1559933665.git.mchehab+samsung@kernel.org>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hEaoa1KyNVzF3lFU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2019 at 03:54:33PM -0300, Mauro Carvalho Chehab wrote:
> Some new files got converted to yaml, but references weren't
> updated accordingly.

These should probably just be sent as normal patches rather than tied in
with the rest of this series...

--hEaoa1KyNVzF3lFU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz6s5UACgkQJNaLcl1U
h9CF/gf6A8YyjbtWR9vuIU+hiuuPGNe8l/3mKrBQmFg2nEkOiWE+N7jc0/RT0WYy
PdT6jbc6Cwn5mJJ6fqF0h32OgglLotXMlY3ZtBPiTYfgyfXYLDw8717VzdoI3BBq
AAprBuCMcg0qZJLD5pYXpWCO0cMo0YZU9dRMIFYeuw/U3RMw+oCd+mf38tXh5kce
dFFdfcmYNcxsRyICaJl42uB5swb46QAtSo+9HiOLhTQy3kMJuBVAoKjG9OjVbgNX
w9xYiPp4+6GikQO7Vl+901wH80kUHNSaZYfiTUfssYQHaorIrdRYZCd2RfmK9NO7
LeseTuJ18aBVgxKkqDEkks1EQqQrEw==
=sF8P
-----END PGP SIGNATURE-----

--hEaoa1KyNVzF3lFU--
