Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D369CC10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE462084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=azazel.net header.i=@azazel.net header.b="ETb6Fkg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfCKJ3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:29:05 -0400
Received: from kadath.azazel.net ([81.187.231.250]:44666 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfCKJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:29:04 -0400
X-Greylist: delayed 1672 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2019 05:29:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LBN5QAHTqN8u2shw3ZgoeFsS6Ms8vom38fCGVmq2Y6w=; b=ETb6Fkg6VprSecWUPjnHIwN812
        f0X6oMTC9/69JkOG+yE7ok5kbF3cIx9KxjrpSm8C+p72dYlhLNcx07IhxyYdKD09MBH2rVl/IcCH8
        +Tn+Y3R9m9zAqOVUZTUnU+aRveByuDkI7OB9UviLO0X8LkL2nwMQm8Ds0LTwnwhi3Mwm0Gng3tvrR
        paEjlEPqj9Yl5uNBHhy1YsIIpfa2L6EZU9y3c+B+XssX3rE5oxyy2rRnHkDR4TqUzQhvJEoqVK6ep
        uRtk0+AJQqhP43J5oDFxzL6V69VK9Vhnt2coZDOKuowwtiFfuw543G+ur0G3af8YHtCpkux4IKgVG
        FBGIiYNA==;
Received: from kadath.azazel.net ([2001:8b0:135f:bcd1:e2cb:4eff:fedf:e608] helo=azazel.net)
        by kadath.azazel.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jeremy@azazel.net>)
        id 1h3Gno-0005Tu-E3; Mon, 11 Mar 2019 09:00:56 +0000
Date:   Mon, 11 Mar 2019 09:00:55 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        devel@driverdev.osuosl.org,
        Karen Palacio <karen.palacio.1994@gmail.com>, lars@metafoo.de,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7192: Add spaces around minus
 operator
Message-ID: <20190311090055.pbu6gaebku4db577@azazel.net>
References: <1552252931-10592-1-git-send-email-karen.palacio.1994@gmail.com>
 <CA+U=Dso8UzRFcHj-2Ss08DmykuXaTzbYmtj3F40tzchgvb7zBw@mail.gmail.com>
 <20190311083159.GE2434@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7gmnqbntbxwjbu5l"
Content-Disposition: inline
In-Reply-To: <20190311083159.GE2434@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:8b0:135f:bcd1:e2cb:4eff:fedf:e608
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7gmnqbntbxwjbu5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2019-03-11, at 11:31:59 +0300, Dan Carpenter wrote:
> On Mon, Mar 11, 2019 at 10:12:48AM +0200, Alexandru Ardelean wrote:
> > On Sun, Mar 10, 2019 at 11:23 PM Karen Palacio
> > <karen.palacio.1994@gmail.com> wrote:
> > >
> > > Add spaces around minus operator to fix readibility.
> > >
> > > Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
> > > ---
> > >  drivers/staging/iio/adc/ad7192.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > > index acdbc07..7c632cf 100644
> > > --- a/drivers/staging/iio/adc/ad7192.c
> > > +++ b/drivers/staging/iio/adc/ad7192.c
> > > @@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
> > >  }
> > >
> > >  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> > > -                            in_voltage-voltage_scale_available,
> > > +                            in_voltage - voltage_scale_available,
> >
> > This isn't broken, but I do agree it should be addressed.  I think
> > it's the second time I see a similar patch trying to fix this.  So,
> > obviously the code is a bit misleading.
> >
>
> It's got to be more than that.  I did a simple grep of my inbox and it
> says that this is the 13th time someone has tried to do this.  It's
> possible that my grep is wrong, 13 seems high but not totaly
> impossible.

The second parameter of IIO_DEVICE_ATTR_NAMED is a name which is
eventually stringified, not an arithmetic expression.

  #define IIO_DEVICE_ATTR_NAMED(_vname, _name, _mode, _show, _store, \
				_addr) \
	struct iio_dev_attr iio_dev_attr_##_vname \
	= IIO_ATTR(_name, _mode, _show, _store, _addr)

which is defined as:

  #define IIO_ATTR(_name, _mode, _show, _store, _addr)		\
	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
	  .address = _addr }

which is defined as:

  #define __ATTR(_name, _mode, _show, _store) {             \
	.attr = {.name = __stringify(_name),                \
		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode) }, \
	.show	= _show,                                    \
	.store	= _store,                                   \
  }

J.

--7gmnqbntbxwjbu5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZ8d+2N/NBLDbUxIF0Z7UzfnX9sMFAlyGI74ACgkQ0Z7UzfnX
9sNyYA/+N6VQsfX9JS/eJpeNODFxG7YQbeKFcapZ8D0fDuiU+k/66NXngjLGZUIC
bjqHi4hOZV69bf1E+ET28KIKwrxatnOIgMvigHCGsSx3yLjKsQx6bDDiZYZpZpjX
nNC9CZAw1AxRUZupxWa91tB7N+tXadkkkzHPZjkOmDeT8nqiIsSzLpr3w7zlafly
z71RkGjGx8/L+2LOeJTmaaz1wba4r4AHZgXFwNAv7GrURHkeS6GfijoxPjqR9P+U
UTC2kbeBuybnger/iHQTy8LnJBKQ/iljeZ5CbizFk4evRWu+8w0qfNXCwZkFPj54
GTUv16iXao6ZzLrbVLYijbJfI/wdOiPXalGbaCv2EHWoI1ofpZHWT0tAWsbP8wwj
eQBOXyflXPuQp1o9NdCPWmNpmWAijiuSw3PmqM0FY5CC8TDVaLxDiLeAXPagbfXQ
UYo13MSD/dUNwCxpRgPdOgzwoSJsWA9ueRueeFXUZF/W8wLC9Xig2bM2K8pI0UN+
Ue/5JPqp2k9kCarXxWDtZ2TFW87IhXmGg4JOibA1EACREdskkfJqPWy7ApB40cyc
TW83AKvcomb2nogK+kryL6n+6RclnoaAcNoDpdxzB9Gr2Ly14Uk2DNzQDvw6VGaI
1EzPLCIGXcV5w2yHciq5GHxHl89R4VyVT/5iKFeXuqqdPe0TueE=
=sbSh
-----END PGP SIGNATURE-----

--7gmnqbntbxwjbu5l--
