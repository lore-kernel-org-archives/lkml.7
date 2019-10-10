Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8D1C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818F320650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570713804;
	bh=ftfmhAaUpIOBZ3QQKC82Wd0DGqRG2QP8JXnss+rx7lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qplRYI2UygalbLbwtgz04oNw/6oUIGF4QnDmWtw9onX7fI6GaYXyGBoERXovG4YHG
	 BTX3w5UgaqUDQJppFhtUyrbcR0zZ7elsMurLj6klA/b/VJ5SmgC24cr08DagshTN3k
	 ZKvHU7OWIc2xaoBjZZK5vr6/jvN7iZmesnuH3v4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbfJJNXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:23:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57656 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388013AbfJJNXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WociR5V+PwUtDGUiulMlt+az7TEdfqJQTJBOofSQeIw=; b=B88lpczAXQldWnyO8Im9vdCEv
        daXUQXh+wZyng11oMF3dtD8+xtR1wQDi92EbTcjf757S/kd/3vMN3xUUt1KFVma+wUSvOf9Q5kZrS
        zZgZmChOHr9R05ehraysEp+s3TpmcKHZiG+YZIG+UMp3R3zkGr37++IozSVUV9WUGhGrY=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIYPU-0001Mi-99; Thu, 10 Oct 2019 13:23:16 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id EC10BD0003A; Thu, 10 Oct 2019 14:23:14 +0100 (BST)
Date:   Thu, 10 Oct 2019 14:23:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     spapothi@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, vkoul@kernel.org,
        pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v7 2/2] ASoC: codecs: add wsa881x amplifier support
Message-ID: <20191010132314.GQ2036@sirena.org.uk>
References: <20191009085108.4950-1-srinivas.kandagatla@linaro.org>
 <20191009085108.4950-3-srinivas.kandagatla@linaro.org>
 <20191009163535.GK2036@sirena.org.uk>
 <95637c0a-8373-0eda-47e5-ac6e529019e5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8Km4OLyaxUtVIPha"
Content-Disposition: inline
In-Reply-To: <95637c0a-8373-0eda-47e5-ac6e529019e5@linaro.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8Km4OLyaxUtVIPha
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2019 at 10:28:04AM +0100, Srinivas Kandagatla wrote:
> On 09/10/2019 17:35, Mark Brown wrote:
> > On Wed, Oct 09, 2019 at 09:51:08AM +0100, Srinivas Kandagatla wrote:
> > > +static const u8 wsa881x_reg_readable[WSA881X_CACHE_SIZE] = {

> > > +static bool wsa881x_readable_register(struct device *dev, unsigned int reg)
> > > +{
> > > +	return wsa881x_reg_readable[reg];

> > There's no bounds check and that array size is not...

> I converted this now to a proper switch statement as other drivers do.

> > > +static struct regmap_config wsa881x_regmap_config = {
> > > +	.reg_bits = 32,
> > > +	.val_bits = 8,
> > > +	.cache_type = REGCACHE_RBTREE,
> > > +	.reg_defaults = wsa881x_defaults,
> > > +	.num_reg_defaults = ARRAY_SIZE(wsa881x_defaults),
> > > +	.max_register = WSA881X_MAX_REGISTER,

> > ...what regmap has as max_register.  Uusually you'd render as a
> > switch statement (as you did for volatile) and let the compiler
> > figure out a sensible way to do the lookup.

> Sorry, I did not get your point here.

> Are you saying that we can skip max_register in this regmap config ?
> Then how would max_register in regmap be set?

I'm saying that you appear to be relying on max_register to
verify that you're not overflowing the array bounds but you
max_register is not set to the same thing as the array size.

--8Km4OLyaxUtVIPha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2fMMIACgkQJNaLcl1U
h9A3/Qf6Ar7ffTTO6fQ9eEU2xlK6kaCO7YSeWXTP1fKzuKvQy6Fd/XOsax1HiBF/
8/H4lV/CNqnW88GwSAgBm7acHnRQwDrq1UkVlImEMNkslEr9q5ANt5CHrUb0DNcW
TI6RkEi4gJj0nfkBozu9aRww71xEYNR+DPcmb/1rugVUdh1WYmFop9sAImmdn+5d
zGGIdGTWdDu71UTPmx272j1zd6226SeJw7ONW4lmacud+HlEnAFRV3OBBc+ftGFD
G6kIhnTS0mnSuzhmGEkyzCTHHuG6Sjv1Co/qRKrV+PdqRPhxPln10rw8N9/Wv55n
5CXKfA5YtlVQjpfqaSr2fmE3YCtiew==
=ZHzM
-----END PGP SIGNATURE-----

--8Km4OLyaxUtVIPha--
