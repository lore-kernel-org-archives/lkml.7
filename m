Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329D1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055C320659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564496441;
	bh=TK0/38e4x6DolU65AYs3SV3Ov4TYjIEBIIl7Mk/5bCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OcBTHFP8flI001d4OjOVcecGrAFZc+vOnZlPNAUdSBOqNa71pvThPdRB63Qng8ReO
	 ro2KRxYFwx+PeCRDO6lcKYU5nV78eS2Jjhywh949ZHlshexHmbpv+OFb8iWv7Foyd1
	 OidWlrz++g5pRYoSHDX4PuIXnF0nk6jXpqEEmAnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbfG3OUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:20:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46448 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfG3OUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UlNNdsBx6Baw2fuddPCcOCkY2XtucT+E1ZdJLnPYjRk=; b=GX29Id9GIy648eX4mkkvrZCNR
        +K+KQOYmAhU03++KERmWLtllkU8sxhtlPCsUVzpmy049izlwm+6drN6ph7qMOO4fX8scf48WEmyn2
        Hh3wcxcIEjS+rlotusZoUCGNzfSxtQHnkRzJN5itUrCtKXV4KGf1Hj1gv7UQ85TaO6ir4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsSyW-0007is-5f; Tue, 30 Jul 2019 14:19:36 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 607C42742CB5; Tue, 30 Jul 2019 15:19:35 +0100 (BST)
Date:   Tue, 30 Jul 2019 15:19:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ASoC: TDA7802: Add turn-on diagnostic routine
Message-ID: <20190730141935.GF4264@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline
In-Reply-To: <20190730120937.16271-4-thomas.preston@codethink.co.uk>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 01:09:37PM +0100, Thomas Preston wrote:

> +	struct dentry *debugfs;
> +	struct mutex diagnostic_mutex;
> +};

It is unclear what this mutex usefully protects, it only gets taken when
writing to the debugfs file to trigger this diagnostic mode but doesn't
do anything to control interactions with any other code path in the
driver.

> +static int run_turn_on_diagnostic(struct tda7802_priv *tda7802, u8 *status)
> +{
> +	struct device *dev = &tda7802->i2c->dev;
> +	int err_status, err;
> +	unsigned int val;
> +	u8 state[NUM_IB];

> +	/* We must wait 20ms for device to settle, otherwise diagnostics will
> +	 * not start and regmap poll will timeout.
> +	 */
> +	msleep(DIAGNOSTIC_SETTLE_MS);

The comment and define might go out of sync...

> +	err = regmap_bulk_read(tda7802->regmap, TDA7802_DB1, status, 4);
> +	if (err < 0) {
> +		dev_err(dev, "Could not read channel status, %d\n", err);
> +		goto diagnostic_restore;
> +	}

...but here we use a magic number for the array size :(

> +static int tda7802_diagnostic_show(struct seq_file *f, void *p)
> +{
> +	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);

We neither use nor free buf?

> +static int tda7802_probe(struct snd_soc_component *component)
> +{
> +	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
> +	struct device *dev = &tda7802->i2c->dev;
> +	int err;

Why is this done at the component level?

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AUfYACgkQJNaLcl1U
h9BW0wf+PaVQnb5XffJ21Ypo9xRgaGWwcL6bpKaVDfNRL94hrZz1wDnFe0ZbKzEY
hIOheUHZJdsf65s/VqhPR6hprJoLCHtcEcnGVcT0ghx2rkyYEM0DrTZIZ/BzzD8I
dCbzuqE3Zh3JjiBrLup0wTyeeEFwP9/z9mmVZCfy5jOcErgm+TObJYq/kPsu1bXv
txX1/W1cPk3+FuPxa2DZC9AFW2Lxv0VnQ0PgBeUwaOI/5ykbFyN51boKVLXFKh6H
FsEA0Y8qQ2OhufKK4pZnqip4RAgzPa+8DkV1cWaABjlgI+ECI0/sEcXD63MOx3cS
oovWVqTESFF8RhUnU/HXI7WswbziRg==
=GUqM
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--
