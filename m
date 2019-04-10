Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEC8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D41F20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ez3t9X+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbfDJP0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:26:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:34883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbfDJP0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554909874;
        bh=xA/BnWtun4BOCtmmVM/Q6GGeuQ7oR+arBXiulO7kTmI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ez3t9X+xkifsKQVPzXOndt53CZVRb6llbtR/jLqXGeQeeujVvDVgLjbDiVqUGtsr9
         aV8glwwT2c63gZz/lZbkujrjXd5R/Ae6nFap9q5lCRd3zof+ILXenA9/UKNuFjpZxr
         kr1/qAVR+1p+7zpWxob3lMS4iBhQxfElIyDN+9AE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnPnu-1gfk561V8w-00hh9T; Wed, 10
 Apr 2019 17:24:34 +0200
Date:   Wed, 10 Apr 2019 17:24:24 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dirk Eibach <eibach@gdsys.de>,
        George Joseph <george.joseph@fairview5.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Juerg Haefliger <juergh@gmail.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Huang Rui <ray.huang@amd.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Clemens Ladisch <clemens@ladisch.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Andreas Werner <andreas.werner@men.de>,
        Jim Cromie <jim.cromie@gmail.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Hulsman <m.hulsman@tudelft.nl>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 21/21] docs: hwmon: Add an index file and rename docs to
 *.rst
Message-ID: <20190410152424.GA11536@latitude>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
 <5ac1fbc7f19192dcd30a184e62e3f7989a5437a4.1554893882.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <5ac1fbc7f19192dcd30a184e62e3f7989a5437a4.1554893882.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:TLAu39kAkvV+JyJofEtse/6D/K/biPwb9iYGF66/M1pJjOfHjSl
 5Gvn9F/iX0LVkfahejNon6kcT3qms/6ipAdpwzk/bcp4CJrO2+ikn2UVt5DmS72xmQYbgAm
 Fwh59tkKvyzys0LmnxFnI4MCbOHN9hjVtoafK6B2JMU0kM0HkZOw/KRixn01devzi7mS8qk
 oGfwAeMn0j3k8kz+gF+Jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w13mbtVepiE=:pSML0XQUkNJ6CmMU23Mlte
 vu/Z26coQEsMKKGod1U9gjsHOUCIIuBPVyYm76i5FBcIA+08ebR4D07ovg6H93+0PbkZgWpnO
 Sjyqt/PTV8R5YcXFsGXvnu0urHmg57DNsRhiK1JEgoT62IfNuIf6oOFpFtccRZLyObbyf7Pfe
 D7aJHp3A4KnnSdDumrU/KzzElawLvXuihHVnnRxxTYn1kQPdmV2aL1PW6eSINuoBY+VohrO2r
 qiNtsAfDaCdnhZSx6qFX3E497osiokRZvFXzp2AEWIlFcpWE35KdIe9K6XHvuWhoH8zyiK2C5
 ETCP3SuguC/MNfY4u5R17eNQqbE+KTZp74MAseKET5MOE0mOxXUSW3+zevwdhH2on0ShlN99f
 5Y4djz+vvvoisni+eYA3NalyurndKVm1ddPIvfmfjuvPIDmsEG2luv+oPBalKU+VvncWYw5mE
 kkyPU5W4VVbiUxH/BakxzEiUpDZk4aRqeG/wPg+4hNildye6YKy8tmMysLmS7xLBx5sJQqV2x
 WZ9xUGBRxVwPN2czGmgR/kcwkCznsD419G+NoFU7Xd/hAYh2Io33EI9jfdMk11tYZG+g5suQi
 TzUeOsta6Qe1zDIKFGEBZ7uZayKa8HvGRnKvrsEH/oYBZQzxGtsZlBML+CXbgolfzd8ZObkYO
 8mF9BLzJU0sw+fIq6BYF0c/F/GrrntuN3E+7ZjgVIb+YyepwTKUOBFZcdbqoa+mUAuAggQ1qH
 zGTdArRP9sgaJvUwC3j7gLdGbVT3W9wn8EF/FCN1EpuW8pHPp7bD+7NfA7F4KhtoiGCGqbIxP
 ZjKXx+2ufjotOia15JO5KMby/niNkBzRa7vgN0vFkYsh9ch7U5Lt6Wmj8b5nLLTkD1WXfp3iQ
 ao3001jtjArPcKXrOi0D0tgVFN79gawVQRUxxEHbh02Kqq00hQXQV00sC/7jwc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 10, 2019 at 08:12:11AM -0300, Mauro Carvalho Chehab wrote:
> Now that all files were converted to ReST format, rename them
> and add an index.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
[...]
> diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwmon=
/submitting-patches.rst
> similarity index 99%
> rename from Documentation/hwmon/submitting-patches
> rename to Documentation/hwmon/submitting-patches.rst
> index 12540b7d9b50..6120db7556aa 100644
> --- a/Documentation/hwmon/submitting-patches
> +++ b/Documentation/hwmon/submitting-patches.rst

I'd additionally suggest:

diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwmon/s=
ubmitting-patches.rst
index f88221b46153..0000a86be4b9 100644
--- a/Documentation/hwmon/submitting-patches
+++ b/Documentation/hwmon/submitting-patches.rst
@@ -38,7 +38,7 @@ increase the chances of your change being accepted.
 2. Adding functionality to existing drivers
 -------------------------------------------
=20
-* Make sure the documentation in Documentation/hwmon/<driver_name> is up to
+* Make sure the documentation in Documentation/hwmon/<driver_name>.rst is =
up to
   date.
=20
 * Make sure the information in Kconfig is up to date.
@@ -60,7 +60,7 @@ increase the chances of your change being accepted.
=20
 * Consider adding yourself to MAINTAINERS.
=20
-* Document the driver in Documentation/hwmon/<driver_name>.
+* Document the driver in Documentation/hwmon/<driver_name>.rst.
=20
 * Add the driver to Kconfig and Makefile in alphabetical order.
=20

Thanks,
Jonathan Neusch=C3=A4fer

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlyuCqAACgkQCDBEmo7z
X9ssgw//ZmPBGq00gnKgIkdptmktJsCCdbRKqAnKS97nKt6Ad54+llNhFidFR3ij
Owq03OnpCXcu+3rc9qn/bOEv9QHjUmJ9aBysxuMCjbp5Wm69ItkylykWH6DPik8b
BhloTUt0lnoweWJjZ4qtHyp5xuUlsQ2q6RbGR+BQwgvPA3y3FMuMYnvqi4BmuJs4
B2DHhAUQnwgy+CMGBq62WTLZsWU6O4xAGnPRepoEIP4yf3ikOn5uiyYXeJt9sWmB
7TyiXuM+noRFv5qyyiR695nBSlRZN0W690W2au5d8o1d1zp2tnuNTtljFGPv18S9
gxxRiAzJRiXIGlg9cPZuyu/LD+4NbGwbRv8AfYYTcXyf1ZwLU6/y2VYRt9riJ/Ul
1k5LFmFhHlxicwFJmobOor+AxJYtkb6fXCwJ2fSclBgP5tMYiKz3SjMlFxsiAczd
x5uS/ABnXpJXEy3aOKlF3/GLI2ehMXegPLntmgUYGPHybPxTPgMf4ThsKLN0uovd
f5ZeHCR5EtdFtJuECRIbvAeTs7MyawkdRzABA0dVUXmAxRzNxaU5tpFT8S9/AN1I
wHTaekePAAReHn5G87/nu1RwsRWoLe8TyGkpy3IFCPmcYgGzZSF63tM2X0/eHuPi
Q6PdjLqczbpT3X31fJdJ3q9BEWwy+zsHmKCHB81cYGY1F5fAYIY=
=QA5J
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
