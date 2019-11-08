Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A92C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E84D215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfKHO6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:58:45 -0500
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:38232 "EHLO
        17.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfKHO6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:58:44 -0500
X-Greylist: delayed 4198 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 09:58:43 EST
Received: from player737.ha.ovh.net (unknown [10.108.57.226])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 37A3113DC4C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2019 13:32:47 +0100 (CET)
Received: from sk2.org (gw.sk2.org [88.186.243.14])
        (Authenticated sender: steve@sk2.org)
        by player737.ha.ovh.net (Postfix) with ESMTPSA id BB328277AF29;
        Fri,  8 Nov 2019 12:32:35 +0000 (UTC)
Date:   Fri, 8 Nov 2019 13:34:14 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/clk: convert VL struct to struct_size
Message-ID: <20191108133414.72981353@heffalump.sk2.org>
In-Reply-To: <20191107225002.1520821D7F@mail.kernel.org>
References: <20190927185110.29897-1-steve@sk2.org>
        <24c5e42f-cb56-f57a-163b-c35392bbf887@embeddedor.com>
        <20191107225002.1520821D7F@mail.kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/smeQGoduYW09bF10J89sbv6"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 6948772751797865944
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedruddvuddggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtdefreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpkeekrddukeeirddvgeefrddugeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/smeQGoduYW09bF10J89sbv6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 Nov 2019 14:50:01 -0800, Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Gustavo A. R. Silva (2019-10-02 12:20:28)
> > On 9/27/19 13:51, Stephen Kitt wrote: =20
> > > There are a few manually-calculated variable-length struct allocations
> > > left, this converts them to use struct_size.
> >=20
> > How did you find this?
> >=20
> > Please, mention the tool you used to find this in the commit log. With
> > that you can add my
> >=20
> > Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>=20
> Any answer? I'm tempted to just apply the patch anyway.

Sorry, I hadn=E2=80=99t seen Gustavo=E2=80=99s email!

I didn=E2=80=99t use anything particularly fancy to find these, my history =
says

	git grep -A1 'kzalloc.*sizeof[^_].*+'

and manual review. I noticed that clk/ had a number of hits, but also commi=
ts
to switch to struct_size so I reckoned it was worth pursuing the exercise
there.

Is it worth adding that to the commit message?

Regards,

Stephen

--Sig_/smeQGoduYW09bF10J89sbv6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl3FYMYACgkQgNMC9Yht
g5w5zw/8DCOKSiYpV+FQsKtEi89KSPghyiUhXmTrE9xaqVQBtKZRpIGa5fiSQw8K
4HQ0dwWP3osgh1bEJrxctOajTlkFf/vvdg83eaLHkjSNlJlsKc4yIG2TBzD944w4
vTDkzIiJuksPv511XQN1CHTBJ59hWTQEUrGBRYmKQGZf1GgwLsQlyAXbQyJ/GIts
wjjG4ppZ8pQ3BsG1cGINMfXN4IAzHmMhTrQcIKfAcuiX5uWrJlIr+oNS/2G29ens
mFFqjRxTPetzXTUvbnyqH834CJ8Kt8sPGSX/nnr2XKn+l2ZwDauh6TIEtqCO3TFt
VWxuTKdXT4jHLeeHLWYmnruUw6K0GUz7TOiPrZh42pzub0SUR8DOwNPYTYgkVCBE
xOAF0HWmYuSeXlkS+ZxPrlqrRhboFVR5nCkYn378YBOCGyp3Unz3dn+Z8sdD1UzT
M1PeS0LZOgB5Nvi6b6Z18f/2wlkaB2/DF+1WY6JUy1T+qqism7SCRK/14lSs5XF7
LJ/EtPj99+5R99KWMyQh7pQVUV2Du/eItx3HI98mYC6JJ05DV4j5Sm4TyJ1BdWkZ
T5kAE1C0C1aAnR7bfLNomqEB7T5Sve69nV2eGN8iWdr+yyEPYsi6NdYgxUCLG2qE
Sumfib9j8gTV6xHqcqEHO7uhzNdjBZ/QcFGqo6K1R7WNtttZmow=
=AIuF
-----END PGP SIGNATURE-----

--Sig_/smeQGoduYW09bF10J89sbv6--
