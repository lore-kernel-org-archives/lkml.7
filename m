Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD8FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE44214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572351900;
	bh=iVYdLME07J6LOiuNQwGeQutA0v9SJp1hg/yfRqnh734=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DAz4cBrReOYmhtcv0NtRE2/1nJU3kmN20Ewr9w/ICIQvrjyrplnMfYFRerGqbI+QQ
	 t3q0qxrMBpwzeY8Al57A5W7UQAcj2BjaHLo1ibdFwBcogOd4PknV6aUYGogzSxm0rx
	 bJ/ZS/nNeK30pXzERiugcMK4r/Yvf3Vtb9z9NCP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbfJ2MY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:24:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfJ2MY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eqLw/byIOnAgh28nLgXLiIQm/SK994ClRrDOvIpxnIs=; b=ZGOqpdYCJwPNporRaV1zrKKjq
        dLw3DFNDXC6884XxNmMkQNkYsCW6CNNn1QXaALaAJdoXiHCfebV3G5zq7bm+Rqeq1fsNjLIYaakek
        Mse9w9Wl3y5YJOEgT7oBCSloLhXSGDSq+0Y2FlvdNDDvJxTdd9nNa2Vzq3YE6eBW2Fu64=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iPQY9-0002Aq-Pj; Tue, 29 Oct 2019 12:24:37 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6AB2A2742157; Tue, 29 Oct 2019 12:24:35 +0000 (GMT)
Date:   Tue, 29 Oct 2019 12:24:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5677: Make rt5677_spi_pcm_page static
Message-ID: <20191029122435.GD5253@sirena.co.uk>
References: <1571919319-4205-1-git-send-email-zhongjiang@huawei.com>
 <5DB7AD30.60007@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
In-Reply-To: <5DB7AD30.60007@huawei.com>
X-Cookie: When does later become never?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2019 at 11:08:32AM +0800, zhong jiang wrote:
> ping.
> On 2019/10/24 20:15, zhong jiang wrote:

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl24L4IACgkQJNaLcl1U
h9B9owf8C8QZIdzWcSwxuYsuCp2sMoWIa5xlc3CoiW0mcJjKgowSR7UOPyyyGU/p
Ko2IdCXoTYD/LulcNgxx1S9T8eiMWjqcUd/vOxg8LPGC9/Of5y4uJrIlqRf6FqsO
t/r+nw8XSGpDIJPtCQJA/z9RhZI4MXz4PzqeWIqg9hZSqvhpim0XB7biORo9OG8w
oEtsCN04EiZDl1S9t5T1Q7DY5nQpFSfywPz+nn/NRNbptyCgenbKjPyRDwneGII6
59sOpOjs/K+LX4ihuUmQ/rkG7BkeRf0xJ9VWgzTGtsiUMivEnM+ZJoWN31XNitm5
LB4kO2/PAAiRZfKz43Vki54V6uw+Tg==
=GKfl
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
