Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E577C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E6021850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553064924;
	bh=yVXscwuRDKrELvxDrOSnld8kZH5IC4c9kxf9tEXRpw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=ik7elfiy/CuPoa8OWgDgbf7mXFZg96abmyRKiuOg7lvmopBXTS0cLoNwjFr4M1WLX
	 pLlgdMfa+4dqyCi81vGDQTSEB7MXrGP3YY4G+zG2mpyRAsTV3L0oYDq0sc6MIN+meF
	 wPKpKT47xwQ7e8tE1O8gXX8G1hSZ9esmve9ZFqm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCTGzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:55:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:4493 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfCTGzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:55:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 23:55:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="asc'?scan'208";a="124167130"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga007.jf.intel.com with ESMTP; 19 Mar 2019 23:55:15 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Johan Hovold <johan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Colin Ian King <colin.king@canonical.com>,
        Matteo Croce <mcroce@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] usb: introduce usb_ep_type_string() function
In-Reply-To: <1553044567.10179.148.camel@mhfsdcap03>
References: <28a8e9f1518e47c35e4563706cbe592b972a7f9d.1552977710.git.chunfeng.yun@mediatek.com> <1552982059.10179.143.camel@mhfsdcap03> <20190319092331.GA21652@kroah.com> <1553044567.10179.148.camel@mhfsdcap03>
Date:   Wed, 20 Mar 2019 08:55:11 +0200
Message-ID: <87r2b2ujao.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:

> Hi Greg,
>
> On Tue, 2019-03-19 at 10:23 +0100, Greg Kroah-Hartman wrote:
>> On Tue, Mar 19, 2019 at 03:54:19PM +0800, Chunfeng Yun wrote:
>> >=20
>> > Hi Felipe & Mathias,
>> >=20
>> > Could you please comment this patch, if there is some-effect on dwc3 a=
nd
>> > xhci, I'll remove its change.
> typo: some-effect/side-effect

well, we don't really know if there are tools parsing the output. The
side-effect _does_ exist (i.e. you change the string :-), what we don't
know is if this will cause problems to possibly existing tools.

Personally, I don't mind the patch, but if it breaks existing parsers,
that would be a little annoying.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlyR488ACgkQzL64meEa
mQaAWg//S95naaisDElfGnzXqBw3k2BoHlVBjEBB8ZxEjMzsKRAeg6D+9cUcnr/X
He/uixVvKfFAnAUVpOFe6gCJi+djcJ+XiPWkPerR0Rrpe2/jk2UN1czQgtf1HRR2
K4hyy9wny3xoKguLXs8qTCqBW6WnKRhrrfP0XR5X8xN8Nz9bFcqdvN0rj9TAguoO
LROa4F8afo1M5ImdXA0wnjQkFqVUZNP9/feXlTPjXDWVBK5AdwRFf+ErUXJCofJ+
YEF05yfB+rnrr4ttlZ6MMWJQ+2CmqxQ0xk0w4aqubhWwbrw6f1LJDNj3j+9cA4mS
G7H+ZHBBfpa+93X1iyDPkBv0pE+Ztx6s4UkN3B/YbM6IUwYoID14sBKjcmwzpeYS
0aUc1Fi/91qsj747UyMWwhZFlLhFyycl8oajr+YIz0oWYZBO5S5W4RQ+txOO0YJZ
3dPE/boIblZaY9GqmLQDtEHHpw7jeynu6+JJWpY6dowiHvLjSGAnbnZisHgdOtxy
crm+gcocmt5Czl0FVBeuSDQdv5cMfrGIB4bTUa8uuS72WkNVIownQzG4VUl1LH8J
rudrRmca2jZiq3iP8EXsukiITglgde5hTrN6p8ONK9ZTT8b7DV4OC8osGkOIZ+Eq
Slx/MHsARCrK+J6h5BzBPom+Wl0rUusvIanvS5zPhqEJ5qRkPPE=
=A4FC
-----END PGP SIGNATURE-----
--=-=-=--
