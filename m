Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE9AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB630213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554105481;
	bh=mApzT2GHRJImpLV2vAV+LBqD0PGlq4JWbRQ3dINZHV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XEupYM36y3O31Iuh7ySf8NIaaPnzuq1lfNYI/TaFtU6m37tbAMmmc0cU65Ti19rc1
	 gJjzNZ3zFrNkiLpjta9a6u50oCVPRWABlhTuVCUqstJW0paU6rAktpgojVJHJSUQfA
	 pelYJT7KBHW/x4ZYWKWYtpmTo9s34RPMH8nZQiOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbfDAH6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:58:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51220 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbfDAH6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mApzT2GHRJImpLV2vAV+LBqD0PGlq4JWbRQ3dINZHV8=; b=WQe0GHb3GV3eiYaAmorPmUnA4
        5nB6oOMSi+Ayo8Dno8s02sdYY6wzhxgIaVzHS3hRo6Yec+2Z2AlaEUVMnGWLZf7CvWOFKiP5dntb5
        uQ+YHkaHIZQAMWMeWy0EREukYVxVz0qGOkGePIgsd2sckU49VwRdINBqkb1+RLAe4jWo8=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hArpL-0008Fw-Jp; Mon, 01 Apr 2019 07:57:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8ABA6440082; Mon,  1 Apr 2019 08:57:52 +0100 (BST)
Date:   Mon, 1 Apr 2019 14:57:52 +0700
From:   Mark Brown <broonie@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ASoC: tlv320aic31xx: Add headphone/headset
 detection
Message-ID: <20190401075752.GN2059@sirena.org.uk>
References: <20190329154704.4922-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JLiXfqD9/Kt1b+Pq"
Content-Disposition: inline
In-Reply-To: <20190329154704.4922-1-afd@ti.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JLiXfqD9/Kt1b+Pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2019 at 10:47:03AM -0500, Andrew F. Davis wrote:
> This device can detect the insertion/removal of headphones and headsets.
> Enable reporting this status by enabling this interrupt and forwarding
> this to upper-layers if a jack has been defined.

This doesn't apply against current code, please check and resend.

--JLiXfqD9/Kt1b+Pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhxH8ACgkQJNaLcl1U
h9C8ZAf/Yxn+/gAw6NllkxZh49h6GowFWW6/Qq16wkCb+1bPpkCAGn5uH/ge6xTo
bTbz8j5zoW9QbvLN2LXVyzmW3gmXTcKzlKS0jogm/JUzbOf/RAbsdfUstmO6FF2Y
Ewj93DcuKx8DscRxx/rbQbzDZmwj3UPNaWlgz56/at3ieOa72Io8eXpZJy2oaWKa
ZBx1es7kgAg5FOdojs0oJMlB/xTykMe+kpZ6JdP0oVElkRhDxyOoByUeZzSgTgUG
1MinmsbQmsnIxy1MNf+o/NaCpG31smi2i28ErXUNTMl0E11L+JRdgmIEEx5CfJDK
COeZ5EkGZ6h2Zfp1gQuxr24QQvm7uA==
=mAL8
-----END PGP SIGNATURE-----

--JLiXfqD9/Kt1b+Pq--
