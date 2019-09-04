Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26375C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FF42339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567598204;
	bh=2eXAnbKo4LWskzdBjQZBYRNBA7cawp/A+aZ1NP2A6MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CnRLbDhvMjlJYad+cHXYlwQD6s16mb6R5Gnuu23CIA0mLbPMuvLpVjkhK26s9CJ91
	 r+kvuxSOPV+7CyrOQ2+fAm135YkWiMSmuNz2REe3WJbOu8dB5Nad++7YUPSzasmtbc
	 Fsui91gYRiDCC1BfXKshEYt3kQ8tHqqcDa6TKx9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfIDL4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:56:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42722 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIDL4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DBbsf8r5uOYzN+tf0BF20JNGTJbY9WmlICsBkr1a8NU=; b=xlWeFFxHrCDMBztiXN9rlo8jH
        8JrGmZ3VaD7B2cqQBHxSC2Q4Cny4Pt5Lw7NvWRLwE1/6EkM5oPKFAihJ9ss0ZnQFOn6LCsAaKa+oC
        wc/QPCRUrPrgEADCudEqA6s0uJe4jDxcUw4thuNr6vZNPZ9Edzuyw2jpVDjzB6T5jGQLE=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5Ttn-0005I8-RR; Wed, 04 Sep 2019 11:56:31 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A64EE2742B45; Wed,  4 Sep 2019 12:56:30 +0100 (BST)
Date:   Wed, 4 Sep 2019 12:56:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richtek Jeff Chang <richtek.jeff.chang@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MT6660] Mediatek Smart Amplifier Driver
Message-ID: <20190904115630.GA4348@sirena.co.uk>
References: <1567494501-3427-1-git-send-email-richtek.jeff.chang@gmail.com>
 <20190903163829.GB7916@sirena.co.uk>
 <1a776762-ee65-7344-4bca-c82e16badffa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <1a776762-ee65-7344-4bca-c82e16badffa@gmail.com>
X-Cookie: Help fight continental drift.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2019 at 03:07:06PM +0800, Richtek Jeff Chang wrote:

> > > +static int32_t mt6660_i2c_update_bits(struct mt6660_chip *chip,
> > > +	uint32_t addr, uint32_t mask, uint32_t data)
> > > +{

> > It would be good to implement a regmap rather than open coding
> > *everything* - it'd give you things like this without needing to open
> > code them.  Providing you don't use the cache code it should cope fine
> > with variable register sizes.

> Due to our hardware design, it is hard to implement regmap for MT6660.

You definitely can't use all the functionality due to the variable
register sizes but using reg_write() and reg_read() should get you most
of it.

> > > +static int mt6660_i2c_init_setting(struct mt6660_chip *chip)
> > > +{
> > > +	int i, len, ret;
> > > +	const struct codec_reg_val *init_table;
> > > +
> > > +	init_table = e4_reg_inits;
> > > +	len = ARRAY_SIZE(e4_reg_inits);
> > > +
> > > +	for (i = 0; i < len; i++) {
> > > +		ret = mt6660_i2c_update_bits(chip, init_table[i].addr,
> > > +				init_table[i].mask, init_table[i].data);
> > > +		if (ret < 0)
> > > +			return ret;

> > Why are we not using the chip defaults here?

> Because MT6660 needs this initial setting for working well.

What are these settings?  Are you sure they are generic settings and
not board specific?

> > > +	if (on_off) {
> > > +		if (chip->pwr_cnt == 0) {
> > > +			ret = mt6660_i2c_update_bits(chip,
> > > +				MT6660_REG_SYSTEM_CTRL, 0x01, 0x00);
> > > +			val = mt6660_i2c_read(chip, MT6660_REG_IRQ_STATUS1);
> > > +			dev_info(chip->dev,
> > > +				"%s reg0x05 = 0x%x\n", __func__, val);
> > > +		}
> > > +		chip->pwr_cnt++;

> > This looks like you're open coding runtime PM stuff?  AFAICT the issue
> > is that you need to write to this register to do any I/O.  Just
> > implement this via the standard runtime PM framework, you'll need to do
> > something about the register I/O in the controls (ideally in the
> > framework, it'd be a lot easier if you did have a cache) but you could
> > cut out this bit.

> In our experience, some Customer platform doesn't support runtime PM.

Tell your customers to turn it on, it's a standard kernel framework and
there's really no excuse for open coding it.  If there's some reason why
runtime PM can't work for them then we should get that fixed but it
really is *very* widely deployed.

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1vpm0ACgkQJNaLcl1U
h9D/Wgf/fF6J63LckawJfQOykVgSmyHQqs469Lx+ZiWwED24peJ4nfDP41ehqc2N
jIXIbNv3uhy0SKfDxmczPs6zHyy+XgWw3pHOHVQR7SX2ZBIU/JwBYSYtmJiZW9yo
GWU/tn7Yql2ApiXs1VRjJfCeiHWCpPg4WTAGOjP2LUeALkQasMQI9nwtqEoJWSyz
tZ15Q9sb3HyKa1Pl0qmh4IPIIQvCtpvD3DdTyHs8OZGFlWzUg5WC17sjRLpbqgxd
d75ADeY84KntmV55haCavSYQGD5cjIMD1pWRc5Ln0yOUKO3H3gwUHqgOgafmUbmc
cTfAzmpdBvy1P5aHKQZ0z6uU7LT39g==
=jNHe
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
