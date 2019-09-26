Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675FBC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4201D222BF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569522195;
	bh=kAnUkT/BMP7a5PTeq6qNCOnmIFLH9OMOuO4IXzD2el0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DzBoKuwQ2N6ws4wCghCVnLZ2mSTMMi1pUURChJAUnoFF+RUQJIsRZUhzyoXoo9cDZ
	 yxSFFItc+DbUPquJvI8ZoON3UPZdHVie/imEIxdr19SOdg7SoCQytXJ9ZUmlcXVrPX
	 r7Xt3ISbAn/hs8i7FZZsnElIcr/akmpnyYIZcHRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfIZSXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:23:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48904 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfIZSXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L0EJVcfMhAB6/N4tPdvEVipe4vp4nRtTRv+xppqN8UE=; b=w9q+m6kd3SPFn6y7MTkeNY4Jn
        iWW/eDfgpO9FfCcmP2UsBb8wauAJzsPNeSDpxUEKoufIMcEq030SrcSQFrYrcK5ECS7Q04Xys9ID+
        uMTDlFAYizv1XHvFtIotrtW50IjuCS5hxhdMgoza8239aNer1Znhf6Qvu+dSj+POSucwQ=;
Received: from [12.157.10.118] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iDYPu-0004Rh-Fu; Thu, 26 Sep 2019 18:23:02 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id E4A53D02DD8; Thu, 26 Sep 2019 19:23:00 +0100 (BST)
Date:   Thu, 26 Sep 2019 11:23:00 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] ASoC: amd: Registering device endpoints using MFD
 framework
Message-ID: <20190926182300.GD2036@sirena.org.uk>
References: <1569539290-756-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OF9salbnfkEgqvaK"
Content-Disposition: inline
In-Reply-To: <1569539290-756-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OF9salbnfkEgqvaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2019 at 04:37:35AM +0530, Ravulapati Vishnu vardhan rao wrote:

> -#define ACP3x_PHY_BASE_ADDRESS 0x1240000
> -#define	ACP3x_I2S_MODE	0
> -#define	ACP3x_REG_START	0x1240000
> -#define	ACP3x_REG_END	0x1250200
> -#define I2S_MODE	0x04
> -#define	BT_TX_THRESHOLD 26
> -#define	BT_RX_THRESHOLD 25
> -#define ACP3x_POWER_ON 0x00
> -#define ACP3x_POWER_ON_IN_PROGRESS 0x01
> -#define ACP3x_POWER_OFF 0x02
> -#define ACP3x_POWER_OFF_IN_PROGRESS 0x03
> +#define ACP3x_DEVS		3
> +#define ACP3x_PHY_BASE_ADDRESS	0x1240000
> +#define	ACP3x_I2S_MODE		0
> +#define	ACP3x_REG_START		0x1240000
> +#define	ACP3x_REG_END		0x1250200

A large part of this appears to be unrelated indentation changes,
these should be split out into a separate patch.

> +static struct device *get_mfd_cell_dev(const char *device_name, int r)
> +{
> +	char auto_dev_name[25];
> +	struct device *dev;
> +
> +	snprintf(auto_dev_name, sizeof(auto_dev_name),
> +		 "%s.%d.auto", device_name, r);
> +	dev = bus_find_device_by_name(&platform_bus_type,
> +					NULL, auto_dev_name);
> +	dev_info(dev, "device %s added\n", auto_dev_name);

Remove this log message, it's going to be very noisy.

> +		r = mfd_add_hotplug_devices(adata->parent, adata->cell,	3);
> +		for (i = 0; i < 3 ; i++)
> +			dev = get_mfd_cell_dev(adata->cell[i].name, i);

What is this doing?  We never look at the result of this
get_mfd_cell_dev() and having a function like this suggests that
there's some abstraction issue here.

> +	kfree(adata->cell);
>  	iounmap(adata->acp3x_base);
> +	/*ignore device status and return driver probe error*/
> +	return -ENODEV;
>  release_regions:

This looks broken, as well as discarding error codes (making
things harder to diagnose) it means we stop unwinding things and
leave the rest of the resources lying around.

--OF9salbnfkEgqvaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2NAgQACgkQJNaLcl1U
h9Cxogf+MiHsjaZBRHQqc3W+QzN0VRj5XNbwBnOYX/QIWj9Qxm9xuUqQK/N7Iwsp
HlvPLHQ1T/PDhEu+zA+EXWKRax2A56I+C/XyhnoqixUdtJolhiNB5Zw3y5MntaSY
zzDm+bvcfGLhm6pjDjvsqCKoPBqDcFrh6UbB042bcGvRXURvPZZIroogzbckGplD
fbRU1BcBrX5ra1yA3nQ+S0QHxbw3ZvwCntDbTMzmCPohGqCFznUxw3ixHoBEavv6
EjMSaar8T0mZbptkpbt0BAlIEug/M13HL7JqRPJ/7iRrU+QYEJqQtdR/RuxfNBsq
VVzy6HUsacBj2tH67Z+TZ+VOKdKKew==
=9AzB
-----END PGP SIGNATURE-----

--OF9salbnfkEgqvaK--
