Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F89C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 13:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6FE2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 13:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="rfsgG01c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCINMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 08:12:24 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:59799 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbfCINMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 08:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e1+PooW68RFdIhgByfIapW5l0KbHzEVlqRQkOtxUfNQ=; b=rfsgG01ct9i8DTWczANug/40VV
        FDoA99go3PbeWLTh4TuraUVHEFtNqohLA/HfKqYgzH2qsoG23FKQ8/e7A8wCenM5dfByDqjEiouCe
        lpyAcBQCcSNgYF9vQS/dK//lZa8I8N0j/5XN9uvA/wRFH5L0K4jANcveXa27NcAEUFgg+z2nB+bFA
        hy4uHp4dSgnnQmh0kqoJnPVDVeBUmR98og8EwM3744so9NPTW7i6LO6D/ZVLQwkdee/SSu5w9W/ax
        oYxssr3KX3DItLhwTSovZMW0HYPd2qG//uPBupq3iPAmukqdKJh8kjM6b0GnAVeLRkCkTh2vf3fBW
        fEbhRuTg==;
Received: from [37.204.119.143] (port=56212 helo=cello)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h2blv-000BMt-1W; Sat, 09 Mar 2019 16:12:15 +0300
Date:   Sat, 9 Mar 2019 16:12:13 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Petr Vorel <pvorel@suse.cz>
Message-ID: <20190309131213.GC25561@cello>
References: <20190221215901.23970-2-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <20190221215901.23970-2-ar@cs.msu.ru>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: Re: [PATCH] scripts/kconfig/Makefile: use KCONFIG_CONFIG if set
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:58:58AM +0300, Arseny Maslennikov wrote:
> In a kernel source tree:
>=20
> % make mrproper
> % make KCONFIG_CONFIG=3D.myconfig kvmconfig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTCC  scripts/kconfig/preprocess.o
>   LEX     scripts/kconfig/zconf.lex.c
>   YACC    scripts/kconfig/zconf.tab.h
>   HOSTCC  scripts/kconfig/zconf.lex.o
>   YACC    scripts/kconfig/zconf.tab.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> The base file '.config' does not exist.  Exit.
> make[1]: *** [scripts/kconfig/Makefile:96: kvm_guest.config] Error 1
> make: *** [Makefile:538: kvmconfig] Error 2
>=20
> Essentially `make kvmconfig' (and probably other similar targets)
> did ignore KCONFIG_CONFIG set to a different filename.
>=20
> If KCONFIG_CONFIG is set, use it; otherwise behave as if it was set
> to `.config'.
>=20
> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>

Since this patch has nothing to do with debian packaging and thus with
the rest of the thread, I'll resend it separately.

> ---
>  scripts/kconfig/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 181973509a05..1c7ac07def4d 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -93,7 +93,7 @@ configfiles=3D$(wildcard $(srctree)/kernel/configs/$@ $=
(srctree)/arch/$(SRCARCH)/c
> =20
>  %.config: $(obj)/conf
>  	$(if $(call configfiles),, $(error No configuration exists for this tar=
get on this architecture))
> -	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m .conf=
ig $(configfiles)
> +	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m $(KCO=
NFIG_CONFIG) $(configfiles)
>  	+$(Q)yes "" | $(MAKE) -f $(srctree)/Makefile oldconfig
> =20
>  PHONY +=3D kvmconfig
> --=20
> 2.20.1
>=20

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAlyDu6YACgkQ9dQjyAYL
01Aa2A//Zy2lbgKQX4IPGbOJj8Id1ouZtRYqx9nKi073Qgy5U8fYNt7UA1LVbJg+
SPnXzPfVDY2+ugYFy5tAMWKSj+OLlzGtQ3i3/Tl/hAqc6D6awqnZCDHz3l7KQLMx
Jc4JDOZRqyy3Y64ZxCFE2neFGHTnKDs0qv6D5XNeYSqjy+JITiNF9krJN5rK5YjJ
uXu9Sl08gWMN32vKOcjhfOA1WzBmKxIn7H2Er2fHjTvB1ty3onevG7+q8+nR+ZPE
qZGs24oqvVJvEJluDNGZjU/fMNlDW+xGP0dHuCW7er6vbHruOsLPeLb2sbJuwRQu
dycfL21r3x3NCXAfyEftPQ7Annwoz1zTfqNqFihd7rjyPALFEi/sjN12F4DxLpLX
T3BLI+PmnLYvBmR1zlvVe8R3vCzlSZOuihpizrxNafYyashPqiL5G+f0AiFRDNQM
GaqQLk5tJgLoQqPkYgrRsX11088vnV6WKSdXSGpS7vRBEhEbJM1I8iKRf4zdBQA5
qfnGhWPBNXCyKradLtcVm4MAVaUvMzObFSG3wVbikq5qoLRvffks2nh7pHo/2YdL
XO30uJtIMoJKt0IQ6SKmJ0TrJkZr0y3Z06wyEl7xo3CMFw8F2y7HdzAJWjgvBEYb
B+b4lU3figN176Rs5nwgjx2HqeptQ4Yt2asONJ72F9H5eKArAhc=
=cfQe
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
