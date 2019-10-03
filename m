Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924A3C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668D920830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123594;
	bh=W6VJsExyi9vmLTgdMHkdhQQ8t5of2jDVayuag8NHcdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SUSOjEMAqceWGVXKmc8alPafQFkapT7BmlVzIzkfirKKKLRDsh/bIgHBi8731CsCR
	 jr0yjse1/IsPWStoKcaCXyrnty7zGA9b3HBABkoavhiEIPD6klSZDNZqTQgeUahFpQ
	 DVL44/jmcIQHc3n59QEMJOe60CUXvwbDA+mEcsf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfJCR0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:26:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41948 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbfJCR0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W6VJsExyi9vmLTgdMHkdhQQ8t5of2jDVayuag8NHcdI=; b=ZHeXmHqyCMYgjnTWIoisOi1oc
        KYJOwXkCXe5LCdM2p0nHDMCRwRHud91Im1KnpMp0vBlu8K2KPWgMR5OEO6+34ycwzlz/oYA7d0VoX
        YiHc//LlbqFysyGlJiOaaCHSaqXrrl/kFCMN9rDc3gLriEe+bK+4Vc3LHxd94kfWe5ArY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iG4rq-0005uB-K2; Thu, 03 Oct 2019 17:26:18 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7C3C32740210; Thu,  3 Oct 2019 18:26:17 +0100 (BST)
Date:   Thu, 3 Oct 2019 18:26:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Libin Yang <libin.yang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.3 039/344] ASoC: SOF: Intel: hda: Make hdac_device
 device-managed
Message-ID: <20191003172617.GA6090@sirena.co.uk>
References: <20191003154540.062170222@linuxfoundation.org>
 <20191003154543.920067214@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20191003154543.920067214@linuxfoundation.org>
X-Cookie: Reactor error - core dumped!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2019 at 05:50:04PM +0200, Greg Kroah-Hartman wrote:

>=20
> Signed-off-by: Libin Yang <libin.yang@intel.com>
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Link: https://lore.kernel.org/r/20190626070450.7229-1-ranjani.sridharan@l=
inux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Looks like you're missing your own signoff on this (and quite a few of
the others)?

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2WLzgACgkQJNaLcl1U
h9AsUgf/Ypif3M0/oHszBFkHueTeLv4O7afKTO2hSl/cll9P758X8/YTRqzbx/cC
/XF0KaWAxBnzIpZh8uYOs+G/FuvXbhGuZ+A64GRlx2xZRjuq1/W74UCscPhezoch
4bNHILV8mWSRqls+wGu5Ikw1qzCIR38evTKjMuZvQFqDGeFoAo10UUjwHw2O2L8E
GXzIiWRJDjsECpWnPjqRgTXo7PG82SGWyPJVmuVZehSM5Ff3USpD+WC1A9rMZEIx
geY91WJDE4drBo86hcSJmopwkWFfQ63zHER+xkY5EwyOYtXdSmgNUhGIn2h45j4r
R7PLtweHllaE9fS/KLBrL0eF+Tc0Bg==
=XVcS
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
