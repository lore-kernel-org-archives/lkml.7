Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC343C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845A7222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569522301;
	bh=KjjPgajd70asKkrHQaB2rFDmxELjNOiWKTL19PQNLcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UZ3VbqYdx5E/4DJot8S1O8EGVpfjtlpNnmPbQ0Z/mBDy7rytkEesF3+L9vG1E0dMR
	 U883h4vf+zcKYq3S6THTq4vpZ/rnmUyWMU+BE1cMKwJPzX0G9VwFw2SVP3puQSJ22Y
	 V0xhxasxw8KWF8MCWIfay6gdJKQlfswtUg6dsJxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfIZSZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:25:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51916 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfIZSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AugkIEvD7+r+PFx4d50SUNlVbq4ALnJeABueWXjTypQ=; b=omq5DJJDq8oshEHinGKpmGl9v
        43qb+SBkAaKuYb4Jjqppv08P5rF2yoWgxlK/11R6UGp4EUBN3ZUu/+1AlsAZNnW6a+TGMYpyDbifd
        FnpYGX9M/TwL9BQpq67e8gjBg4Mm8szxbXSxb4OJ1xO7TIYVB2bNwR8RPws3iW0QnrupM=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iDYRe-0004SG-6f; Thu, 26 Sep 2019 18:24:50 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 86FA7D02DD8; Thu, 26 Sep 2019 19:24:48 +0100 (BST)
Date:   Thu, 26 Sep 2019 11:24:48 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] ASoC: amd: added pmops for pci driver
Message-ID: <20190926182448.GE2036@sirena.org.uk>
References: <1569539290-756-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1569539290-756-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JTVzY7YXrWvPVXom"
Content-Disposition: inline
In-Reply-To: <1569539290-756-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JTVzY7YXrWvPVXom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2019 at 04:37:38AM +0530, Ravulapati Vishnu vardhan rao wrote:

> +static int  snd_acp3x_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int  snd_acp3x_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops acp3x_pm = {
> +	.runtime_suspend = snd_acp3x_suspend,
> +	.runtime_resume =  snd_acp3x_resume,
> +	.resume	=	snd_acp3x_resume,
> +
> +};

These operations are empty so they should just be removed.

--JTVzY7YXrWvPVXom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2NAm8ACgkQJNaLcl1U
h9AjzAf/UH1pDPCNMtAFU1c75tQQ88+9u6FIttYJDSACr7DGvasiGcA09dm6+N4N
+HhIH338G/hCPzq8YLpT0mRv2KPofAecLo9bpMiWTLGU3Lk8j+MNqitNZlhTf/+/
ym4qJajutTJ3uoVnruc7L5YJX8pF2TB9dIkImSd0Nt73y3OQGOUBKgmyhlo7PYuZ
4HZtnnanVCkvOyIYcQxGcFZXRWna+sH/oUnKINuxJeHgRmAG6XrHpu4y1RkYB/EN
Jpvg6NyRKMJDxYGiPSX5gAzPDlVR0qMcp+UFlf7OOqQUot7zwehbxhSYUALk3y9D
UqDxncXlmBrURtifJVn3J8hUPOJJxg==
=Y0dc
-----END PGP SIGNATURE-----

--JTVzY7YXrWvPVXom--
