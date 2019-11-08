Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01217C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96222075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfKHUQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:16:26 -0500
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:52672 "EHLO
        5.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfKHUQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:16:25 -0500
X-Greylist: delayed 25662 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 15:16:24 EST
Received: from player763.ha.ovh.net (unknown [10.108.57.139])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id BCC7A196058
        for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2019 21:16:22 +0100 (CET)
Received: from sk2.org (gw.sk2.org [88.186.243.14])
        (Authenticated sender: steve@sk2.org)
        by player763.ha.ovh.net (Postfix) with ESMTPSA id 0C47DBED04EE;
        Fri,  8 Nov 2019 20:16:13 +0000 (UTC)
Date:   Fri, 8 Nov 2019 21:17:54 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk/ti/adpll: allocate room for terminating null
Message-ID: <20191108211754.430d4c52@heffalump.sk2.org>
In-Reply-To: <20191108170026.55DA52178F@mail.kernel.org>
References: <20191019155441.2b1b349f@heffalump.sk2.org>
        <20191019140634.15596-1-steve@sk2.org>
        <20191108170026.55DA52178F@mail.kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/urfJBMy9eUwjFd6M5Ta2c=G"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 14777999228607679960
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedruddvuddgudefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekkedrudekiedrvdegfedrudegnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejieefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/urfJBMy9eUwjFd6M5Ta2c=G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 08 Nov 2019 09:00:25 -0800, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Stephen Kitt (2019-10-19 07:06:34)
> > The buffer allocated in ti_adpll_clk_get_name doesn't account for the
> > terminating null. This patch switches to devm_kasprintf to avoid
> > overflowing.
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> > --- =20
>=20
> Please don't send as replies to existing threads. It screws up my
> tooling and makes it more manual to apply the patch. I guess I'll have
> to go fix my scripts to ignore certain emails.

My bad, sorry about that, I misread the In-Reply-To section of
submitting-patches :-(.

Regards,

Stephen

--Sig_/urfJBMy9eUwjFd6M5Ta2c=G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl3FzXIACgkQgNMC9Yht
g5yOAhAAnGdI2emqN4a/GrokLIb57cKV63Y80R0avBz7ROKWLNIDr4LaZ9cB64Yw
7cZCVIuMbrQHY/nPkVMZEi9Ay3d/BwxDeNOEpstOd5sgPcw89uJbQ7q/+INR6lt7
REXx/NP4DTgkL+XIymdUPY0D5W7NvszWJy5XRE/UKCQZB/aPxolR+rFH23+wESdg
P0NfyarVlcSfdjBBh5f+/BzWTpYvokzQEbq1CrIMgHKZrXKy4+Up7uXyiMNrlXUG
uBcc1XrJFH80f/tRcldSsoaNBjnqtBljCfoXstvpEMs/sG6NCvOcxPH/fHfu4JLi
9B0/C32B4vOdIzL+yHdXFBYZHq33eRjc3j9+Yj7gGKpRqHji3sDL+XDjbSvZxbf9
adQ40ZQJvj/e1VDmjqT18pl8RSZnVGqGzXvVQ5WVkKvdIsHEHSlYKHmqmRwvwIMT
jD5B2zH8lkKQwQMMT0URBSVw9uKyE0QzOWfIKvO+ZpDuE+LptBl7G5KGT0019oh3
3pGYYype7J5XIs5dF0I7xVTsogwFR7X/fMK2N7yLefJbthPo1bbCx4akl5kIaXG7
/aVU0RcZzX9ta5dJ6sE+KlWP9OaRo2MoTQmSfxfnWgLP9Bk99UgltFQk+FILXiHG
+1JRD4bnI5BKUmshBpJ9Rk9h7QTYrJBmn6ed7FRxlwP0piEkFgQ=
=ZIn8
-----END PGP SIGNATURE-----

--Sig_/urfJBMy9eUwjFd6M5Ta2c=G--
