Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE1FECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07EC2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571310741;
	bh=76l3i1G8HTHzJ9MlFVy8c4dsAdw53/MmCstigaLV8wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WbqcBYeDhZE2bwpksoRWE3+tWPAwfLZ/vXmoRDxvhSM5Ef+kVO0cVHVheUxzswHbq
	 eAojR3W4da2Go81+stf3sYE8KzDonSIvflRNLT0IoYm7Bu89L06ZcAj8L9xSbMiAW9
	 4ZsVvaB+w+qr5QJcAIjJAch6vhPVzycwZmwXu5dU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502078AbfJQLMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:12:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33574 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502068AbfJQLMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hu92kkg/rOG7H1uhawHnfkVXpSc0yt/8yzcgxVqHn6M=; b=KfPKdlCJZtg1+QqDDMACBohJ4
        nOwvwQT3jnWe3ml7rxiHpiVcbuGR+fqnkoG5zya3ECIaBTvmCLivMwizmQGeeUucAcJ60vhQtDoRL
        bnGGNVwtaW4lV4rx5OMTfMLV+okrJpZxuEVrgZc1ENumUN71ugIMVxf5K9kTcImU/KsWI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iL3gv-0000mV-PU; Thu, 17 Oct 2019 11:11:37 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 200EC2742BAC; Thu, 17 Oct 2019 12:11:37 +0100 (BST)
Date:   Thu, 17 Oct 2019 12:11:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yuehaibing <yuehaibing@huawei.com>
Cc:     codrin.ciubotariu@microchip.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, mirq-linux@rere.qmqm.pl,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: atmel: Fix build error
Message-ID: <20191017111137.GB4976@sirena.co.uk>
References: <20190928081641.44232-1-yuehaibing@huawei.com>
 <c0a0ddc9-5ae4-8b5e-1d77-b322970651bd@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <c0a0ddc9-5ae4-8b5e-1d77-b322970651bd@huawei.com>
X-Cookie: Shut off engine before fueling.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 03:32:01PM +0800, Yuehaibing wrote:
> ping..., this issue still in linux-next 20191017

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

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2oTGgACgkQJNaLcl1U
h9DLQgf/bpKGur09JNKSVcz4fizyK0a7jmcFtSjI2sF5Yi7dqr8rGWgMJuQ6lXnd
yKAo3kNfJkakIcpLAe+5JFWjvLSfOPdlbn+pvA9DO30LWUU9yfZpiwJh8DCCmzHf
VtLwbaYEn2Lz3+7pfSQ+vOjqA07HaBXLvpgu+eL+HcGCAQQ0xiBSEBW0/X1k6Nzi
raR3jYrrFXeqn03GlAdjfcwa0MOx3HO134aU2hDCRLoi0DZsi8mjsEmi5eTW+lTg
BSmJmUTgMBX0EKsscrwJnR66qX+Slx9d2pL0DO48viIRUqz84Ro0I3w6XlBT02Fi
YCa34N8RkRi0nIf++MH8GlzSZYp67w==
=StwZ
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
