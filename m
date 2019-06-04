Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDFCC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3F423406
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pXrddZRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfFDKnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:43:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfFDKnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PexTtozTv2hc82+uoM71WOlQnJLPYsYDcwzqdvCWY9s=; b=pXrddZRqdjgtqwGkzbev8LOZL
        /DdY2xxfkLiOlLlK+CzwfksQeWjCtm/Y+C82ainkY6P4RIpXrihZloBuRLoT2pFPdh5yXg6kyDYBt
        8d7KALVYPWQDT2QeOJI3WxKGpe2DCSB0f+LpBWxi9ru8YjuDwaYFEo90mzakba1RvgT2Uu0Omt+tS
        XgWmgGJgJ9mOtb7/0jCIw/hEbcze2QQc1RuA5YkDW4fkwPfr9WOnVuAlBUUsMjbe7shKWvR9V0Z2e
        O3Tao0ANFsir5ffPnxR9Ken3qwSFWuFNDImQjilrJb9/G7tz3bO5epTWAGQ/GeeoW1xnj9Ln2oiad
        U45eXjIKw==;
Received: from [187.113.6.249] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY6uh-0007fi-Cf; Tue, 04 Jun 2019 10:43:31 +0000
Date:   Tue, 4 Jun 2019 07:43:28 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>
Subject: Re: [PATCH 13/22] docs: zh_CN: avoid duplicate citation references
Message-ID: <20190604074328.7e3e7973@coco.lan>
In-Reply-To: <20190604072057.47d2f6f8@coco.lan>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
        <9d3b9729663f75249b514dd3910309eb418d9e46.1559171394.git.mchehab+samsung@kernel.org>
        <04bca27d-3c59-5cc7-576b-44e399fa893f@linux.alibaba.com>
        <20190604072057.47d2f6f8@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 4 Jun 2019 07:20:57 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:

> Em Sun, 2 Jun 2019 23:01:21 +0800
> Alex Shi <alex.shi@linux.alibaba.com> escreveu:
>=20
> > On 2019/5/30 7:23 =E4=B8=8A=E5=8D=88, Mauro Carvalho Chehab wrote: =20
> > >     Documentation/process/management-style.rst:35: WARNING: duplicate=
 label decisions, other instance in     Documentation/translations/zh_CN/pr=
ocess/management-style.rst
> > >     Documentation/process/programming-language.rst:37: WARNING: dupli=
cate citation c-language, other instance in     Documentation/translations/=
zh_CN/process/programming-language.rst
> > >     Documentation/process/programming-language.rst:38: WARNING: dupli=
cate citation gcc, other instance in     Documentation/translations/zh_CN/p=
rocess/programming-language.rst
> > >     Documentation/process/programming-language.rst:39: WARNING: dupli=
cate citation clang, other instance in     Documentation/translations/zh_CN=
/process/programming-language.rst
> > >     Documentation/process/programming-language.rst:40: WARNING: dupli=
cate citation icc, other instance in     Documentation/translations/zh_CN/p=
rocess/programming-language.rst
> > >     Documentation/process/programming-language.rst:41: WARNING: dupli=
cate citation gcc-c-dialect-options, other instance in     Documentation/tr=
anslations/zh_CN/process/programming-language.rst
> > >     Documentation/process/programming-language.rst:42: WARNING: dupli=
cate citation gnu-extensions, other instance in     Documentation/translati=
ons/zh_CN/process/programming-language.rst
> > >     Documentation/process/programming-language.rst:43: WARNING: dupli=
cate citation gcc-attribute-syntax, other instance in     Documentation/tra=
nslations/zh_CN/process/programming-language.rst
> > >     Documentation/process/programming-language.rst:44: WARNING: dupli=
cate citation n2049, other instance in     Documentation/translations/zh_CN=
/process/programming-language.rst
> > >=20
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > ---
> > >  .../zh_CN/process/management-style.rst        |  4 +--
> > >  .../zh_CN/process/programming-language.rst    | 28 +++++++++--------=
--
> > >  2 files changed, 16 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/Documentation/translations/zh_CN/process/management-styl=
e.rst b/Documentation/translations/zh_CN/process/management-style.rst
> > > index a181fa56d19e..c6a5bb285797 100644
> > > --- a/Documentation/translations/zh_CN/process/management-style.rst
> > > +++ b/Documentation/translations/zh_CN/process/management-style.rst
> > > @@ -28,7 +28,7 @@ Linux=E5=86=85=E6=A0=B8=E7=AE=A1=E7=90=86=E9=A3=8E=
=E6=A0=BC
> > > =20
> > >  =E4=B8=8D=E7=AE=A1=E6=80=8E=E6=A0=B7=EF=BC=8C=E8=BF=99=E9=87=8C=E6=
=98=AF=EF=BC=9A
> > > =20
> > > -.. _decisions:
> > > +.. _cn_decisions:
> > > =20
> > >  1=EF=BC=89=E5=86=B3=E7=AD=96
> > >  -------
> > > @@ -108,7 +108,7 @@ Linux=E5=86=85=E6=A0=B8=E7=AE=A1=E7=90=86=E9=A3=
=8E=E6=A0=BC
> > >  =E4=BD=86=E6=98=AF=EF=BC=8C=E4=B8=BA=E4=BA=86=E5=81=9A=E5=A5=BD=E4=
=BD=9C=E4=B8=BA=E5=86=85=E6=A0=B8=E7=AE=A1=E7=90=86=E8=80=85=E7=9A=84=E5=87=
=86=E5=A4=87=EF=BC=8C=E6=9C=80=E5=A5=BD=E8=AE=B0=E4=BD=8F=E4=B8=8D=E8=A6=81=
=E7=83=A7=E6=8E=89=E4=BB=BB=E4=BD=95=E6=A1=A5=E6=A2=81=EF=BC=8C=E4=B8=8D=E8=
=A6=81=E8=BD=B0=E7=82=B8=E4=BB=BB=E4=BD=95
> > >  =E6=97=A0=E8=BE=9C=E7=9A=84=E6=9D=91=E6=B0=91=EF=BC=8C=E4=B9=9F=E4=
=B8=8D=E8=A6=81=E7=96=8F=E8=BF=9C=E5=A4=AA=E5=A4=9A=E7=9A=84=E5=86=85=E6=A0=
=B8=E5=BC=80=E5=8F=91=E4=BA=BA=E5=91=98=E3=80=82=E4=BA=8B=E5=AE=9E=E8=AF=81=
=E6=98=8E=EF=BC=8C=E7=96=8F=E8=BF=9C=E4=BA=BA=E6=98=AF=E7=9B=B8=E5=BD=93=E5=
=AE=B9=E6=98=93=E7=9A=84=EF=BC=8C=E8=80=8C
> > >  =E4=BA=B2=E8=BF=91=E4=B8=80=E4=B8=AA=E7=96=8F=E8=BF=9C=E7=9A=84=E4=
=BA=BA=E6=98=AF=E5=BE=88=E9=9A=BE=E7=9A=84=E3=80=82=E5=9B=A0=E6=AD=A4=EF=BC=
=8C=E2=80=9C=E7=96=8F=E8=BF=9C=E2=80=9D=E7=AB=8B=E5=8D=B3=E5=B1=9E=E4=BA=8E=
=E2=80=9C=E4=B8=8D=E5=8F=AF=E9=80=86=E2=80=9D=E7=9A=84=E8=8C=83=E7=95=B4=EF=
=BC=8C=E5=B9=B6=E6=A0=B9=E6=8D=AE
> > > -:ref:`decisions` =E6=88=90=E4=B8=BA=E7=BB=9D=E4=B8=8D=E5=8F=AF=E4=BB=
=A5=E5=81=9A=E7=9A=84=E4=BA=8B=E6=83=85=E3=80=82
> > > +:ref:`cn_decisions` =E6=88=90=E4=B8=BA=E7=BB=9D=E4=B8=8D=E5=8F=AF=E4=
=BB=A5=E5=81=9A=E7=9A=84=E4=BA=8B=E6=83=85=E3=80=82   =20
> >=20
> > It's good to have.
> >  =20
> > > =20
> > >  =E8=BF=99=E9=87=8C=E5=8F=AA=E6=9C=89=E5=87=A0=E4=B8=AA=E7=AE=80=E5=
=8D=95=E7=9A=84=E8=A7=84=E5=88=99=EF=BC=9A
> > > =20
> > > diff --git a/Documentation/translations/zh_CN/process/programming-lan=
guage.rst b/Documentation/translations/zh_CN/process/programming-language.r=
st
> > > index 51fd4ef48ea1..9de9a3108c4d 100644
> > > --- a/Documentation/translations/zh_CN/process/programming-language.r=
st
> > > +++ b/Documentation/translations/zh_CN/process/programming-language.r=
st
> > > @@ -8,21 +8,21 @@
> > >  =E7=A8=8B=E5=BA=8F=E8=AE=BE=E8=AE=A1=E8=AF=AD=E8=A8=80
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =20
> > > -=E5=86=85=E6=A0=B8=E6=98=AF=E7=94=A8C=E8=AF=AD=E8=A8=80 [c-language]=
_ =E7=BC=96=E5=86=99=E7=9A=84=E3=80=82=E6=9B=B4=E5=87=86=E7=A1=AE=E5=9C=B0=
=E8=AF=B4=EF=BC=8C=E5=86=85=E6=A0=B8=E9=80=9A=E5=B8=B8=E6=98=AF=E7=94=A8 ``=
gcc`` [gcc]_
> > > -=E5=9C=A8 ``-std=3Dgnu89`` [gcc-c-dialect-options]_ =E4=B8=8B=E7=BC=
=96=E8=AF=91=E7=9A=84=EF=BC=9AISO C90=E7=9A=84 GNU =E6=96=B9=E8=A8=80=EF=BC=
=88
> > > +=E5=86=85=E6=A0=B8=E6=98=AF=E7=94=A8C=E8=AF=AD=E8=A8=80 [cn_c-langua=
ge]_ =E7=BC=96=E5=86=99=E7=9A=84=E3=80=82=E6=9B=B4=E5=87=86=E7=A1=AE=E5=9C=
=B0=E8=AF=B4=EF=BC=8C=E5=86=85=E6=A0=B8=E9=80=9A=E5=B8=B8=E6=98=AF=E7=94=A8=
 ``gcc`` [cn_gcc]_   =20
> >=20
> > this change isn't good. cn_gcc will show in docs, it looks wired and co=
nfusing for peoples. other changes have the same issue. Could you find othe=
r way to fix the warning? or I'd rather tolerant it. =20
>=20
> Well, Sphinx has a way to do that, like, for example:
>=20
> diff --git a/Documentation/translations/zh_CN/process/programming-languag=
e.rst b/Documentation/translations/zh_CN/process/programming-language.rst
> index 9de9a3108c4d..353fb8eaf4b5 100644
> --- a/Documentation/translations/zh_CN/process/programming-language.rst
> +++ b/Documentation/translations/zh_CN/process/programming-language.rst
> @@ -9,7 +9,7 @@
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  =E5=86=85=E6=A0=B8=E6=98=AF=E7=94=A8C=E8=AF=AD=E8=A8=80 [cn_c-language]_=
 =E7=BC=96=E5=86=99=E7=9A=84=E3=80=82=E6=9B=B4=E5=87=86=E7=A1=AE=E5=9C=B0=
=E8=AF=B4=EF=BC=8C=E5=86=85=E6=A0=B8=E9=80=9A=E5=B8=B8=E6=98=AF=E7=94=A8 ``=
gcc`` [cn_gcc]_
> -=E5=9C=A8 ``-std=3Dgnu89`` [cn_gcc-c-dialect-options]_ =E4=B8=8B=E7=BC=
=96=E8=AF=91=E7=9A=84=EF=BC=9AISO C90=E7=9A=84 GNU =E6=96=B9=E8=A8=80=EF=BC=
=88
> +=E5=9C=A8 ``-std=3Dgnu89`` :ref:`gcc C dialect options <cn_gcc-c-dialect=
-options>` =E4=B8=8B=E7=BC=96=E8=AF=91=E7=9A=84=EF=BC=9AISO C90=E7=9A=84 GN=
U =E6=96=B9=E8=A8=80=EF=BC=88
>  =E5=8C=85=E6=8B=AC=E4=B8=80=E4=BA=9BC99=E7=89=B9=E6=80=A7=EF=BC=89
> =20
>  =E8=BF=99=E7=A7=8D=E6=96=B9=E8=A8=80=E5=8C=85=E5=90=AB=E5=AF=B9=E8=AF=AD=
=E8=A8=80 [cn_gnu-extensions]_ =E7=9A=84=E8=AE=B8=E5=A4=9A=E6=89=A9=E5=B1=
=95=EF=BC=8C=E5=BD=93=E7=84=B6=EF=BC=8C=E5=AE=83=E4=BB=AC=E8=AE=B8=E5=A4=9A=
=E9=83=BD=E5=9C=A8=E5=86=85=E6=A0=B8=E4=B8=AD=E4=BD=BF=E7=94=A8=E3=80=82
>=20
> If we use that, at least for some of those references, it would probably
> be better to translate "dialect-options" (and similar terms) to Chinese.
>=20
> Thanks,
> Mauro

Thanks,
Mauro

This should do the work:

[PATCH] docs: zh_CN: avoid duplicate citation references

    Documentation/process/management-style.rst:35: WARNING: duplicate label=
 decisions, other instance in     Documentation/translations/zh_CN/process/=
management-style.rst
    Documentation/process/programming-language.rst:37: WARNING: duplicate c=
itation c-language, other instance in     Documentation/translations/zh_CN/=
process/programming-language.rst
    Documentation/process/programming-language.rst:38: WARNING: duplicate c=
itation gcc, other instance in     Documentation/translations/zh_CN/process=
/programming-language.rst
    Documentation/process/programming-language.rst:39: WARNING: duplicate c=
itation clang, other instance in     Documentation/translations/zh_CN/proce=
ss/programming-language.rst
    Documentation/process/programming-language.rst:40: WARNING: duplicate c=
itation icc, other instance in     Documentation/translations/zh_CN/process=
/programming-language.rst
    Documentation/process/programming-language.rst:41: WARNING: duplicate c=
itation gcc-c-dialect-options, other instance in     Documentation/translat=
ions/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:42: WARNING: duplicate c=
itation gnu-extensions, other instance in     Documentation/translations/zh=
_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:43: WARNING: duplicate c=
itation gcc-attribute-syntax, other instance in     Documentation/translati=
ons/zh_CN/process/programming-language.rst
    Documentation/process/programming-language.rst:44: WARNING: duplicate c=
itation n2049, other instance in     Documentation/translations/zh_CN/proce=
ss/programming-language.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

diff --git a/Documentation/translations/zh_CN/process/management-style.rst =
b/Documentation/translations/zh_CN/process/management-style.rst
index a181fa56d19e..c6a5bb285797 100644
--- a/Documentation/translations/zh_CN/process/management-style.rst
+++ b/Documentation/translations/zh_CN/process/management-style.rst
@@ -28,7 +28,7 @@ Linux=E5=86=85=E6=A0=B8=E7=AE=A1=E7=90=86=E9=A3=8E=E6=A0=
=BC
=20
 =E4=B8=8D=E7=AE=A1=E6=80=8E=E6=A0=B7=EF=BC=8C=E8=BF=99=E9=87=8C=E6=98=AF=
=EF=BC=9A
=20
-.. _decisions:
+.. _cn_decisions:
=20
 1=EF=BC=89=E5=86=B3=E7=AD=96
 -------
@@ -108,7 +108,7 @@ Linux=E5=86=85=E6=A0=B8=E7=AE=A1=E7=90=86=E9=A3=8E=E6=
=A0=BC
 =E4=BD=86=E6=98=AF=EF=BC=8C=E4=B8=BA=E4=BA=86=E5=81=9A=E5=A5=BD=E4=BD=9C=
=E4=B8=BA=E5=86=85=E6=A0=B8=E7=AE=A1=E7=90=86=E8=80=85=E7=9A=84=E5=87=86=E5=
=A4=87=EF=BC=8C=E6=9C=80=E5=A5=BD=E8=AE=B0=E4=BD=8F=E4=B8=8D=E8=A6=81=E7=83=
=A7=E6=8E=89=E4=BB=BB=E4=BD=95=E6=A1=A5=E6=A2=81=EF=BC=8C=E4=B8=8D=E8=A6=81=
=E8=BD=B0=E7=82=B8=E4=BB=BB=E4=BD=95
 =E6=97=A0=E8=BE=9C=E7=9A=84=E6=9D=91=E6=B0=91=EF=BC=8C=E4=B9=9F=E4=B8=8D=
=E8=A6=81=E7=96=8F=E8=BF=9C=E5=A4=AA=E5=A4=9A=E7=9A=84=E5=86=85=E6=A0=B8=E5=
=BC=80=E5=8F=91=E4=BA=BA=E5=91=98=E3=80=82=E4=BA=8B=E5=AE=9E=E8=AF=81=E6=98=
=8E=EF=BC=8C=E7=96=8F=E8=BF=9C=E4=BA=BA=E6=98=AF=E7=9B=B8=E5=BD=93=E5=AE=B9=
=E6=98=93=E7=9A=84=EF=BC=8C=E8=80=8C
 =E4=BA=B2=E8=BF=91=E4=B8=80=E4=B8=AA=E7=96=8F=E8=BF=9C=E7=9A=84=E4=BA=BA=
=E6=98=AF=E5=BE=88=E9=9A=BE=E7=9A=84=E3=80=82=E5=9B=A0=E6=AD=A4=EF=BC=8C=E2=
=80=9C=E7=96=8F=E8=BF=9C=E2=80=9D=E7=AB=8B=E5=8D=B3=E5=B1=9E=E4=BA=8E=E2=80=
=9C=E4=B8=8D=E5=8F=AF=E9=80=86=E2=80=9D=E7=9A=84=E8=8C=83=E7=95=B4=EF=BC=8C=
=E5=B9=B6=E6=A0=B9=E6=8D=AE
-:ref:`decisions` =E6=88=90=E4=B8=BA=E7=BB=9D=E4=B8=8D=E5=8F=AF=E4=BB=A5=E5=
=81=9A=E7=9A=84=E4=BA=8B=E6=83=85=E3=80=82
+:ref:`cn_decisions` =E6=88=90=E4=B8=BA=E7=BB=9D=E4=B8=8D=E5=8F=AF=E4=BB=A5=
=E5=81=9A=E7=9A=84=E4=BA=8B=E6=83=85=E3=80=82
=20
 =E8=BF=99=E9=87=8C=E5=8F=AA=E6=9C=89=E5=87=A0=E4=B8=AA=E7=AE=80=E5=8D=95=
=E7=9A=84=E8=A7=84=E5=88=99=EF=BC=9A
=20
diff --git a/Documentation/translations/zh_CN/process/programming-language.=
rst b/Documentation/translations/zh_CN/process/programming-language.rst
index 51fd4ef48ea1..22b0e68c8360 100644
--- a/Documentation/translations/zh_CN/process/programming-language.rst
+++ b/Documentation/translations/zh_CN/process/programming-language.rst
@@ -8,21 +8,21 @@
 =E7=A8=8B=E5=BA=8F=E8=AE=BE=E8=AE=A1=E8=AF=AD=E8=A8=80
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-=E5=86=85=E6=A0=B8=E6=98=AF=E7=94=A8C=E8=AF=AD=E8=A8=80 [c-language]_ =E7=
=BC=96=E5=86=99=E7=9A=84=E3=80=82=E6=9B=B4=E5=87=86=E7=A1=AE=E5=9C=B0=E8=AF=
=B4=EF=BC=8C=E5=86=85=E6=A0=B8=E9=80=9A=E5=B8=B8=E6=98=AF=E7=94=A8 ``gcc`` =
[gcc]_
-=E5=9C=A8 ``-std=3Dgnu89`` [gcc-c-dialect-options]_ =E4=B8=8B=E7=BC=96=E8=
=AF=91=E7=9A=84=EF=BC=9AISO C90=E7=9A=84 GNU =E6=96=B9=E8=A8=80=EF=BC=88
+=E5=86=85=E6=A0=B8=E6=98=AF=E7=94=A8C=E8=AF=AD=E8=A8=80 :ref:`c-language <=
cn_c-language>` =E7=BC=96=E5=86=99=E7=9A=84=E3=80=82=E6=9B=B4=E5=87=86=E7=
=A1=AE=E5=9C=B0=E8=AF=B4=EF=BC=8C=E5=86=85=E6=A0=B8=E9=80=9A=E5=B8=B8=E6=98=
=AF=E7=94=A8 ``gcc`` :ref:`gcc <cn_gcc>`
+=E5=9C=A8 ``-std=3Dgnu89`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-o=
ptions>` =E4=B8=8B=E7=BC=96=E8=AF=91=E7=9A=84=EF=BC=9AISO C90=E7=9A=84 GNU =
=E6=96=B9=E8=A8=80=EF=BC=88
 =E5=8C=85=E6=8B=AC=E4=B8=80=E4=BA=9BC99=E7=89=B9=E6=80=A7=EF=BC=89
=20
-=E8=BF=99=E7=A7=8D=E6=96=B9=E8=A8=80=E5=8C=85=E5=90=AB=E5=AF=B9=E8=AF=AD=
=E8=A8=80 [gnu-extensions]_ =E7=9A=84=E8=AE=B8=E5=A4=9A=E6=89=A9=E5=B1=95=
=EF=BC=8C=E5=BD=93=E7=84=B6=EF=BC=8C=E5=AE=83=E4=BB=AC=E8=AE=B8=E5=A4=9A=E9=
=83=BD=E5=9C=A8=E5=86=85=E6=A0=B8=E4=B8=AD=E4=BD=BF=E7=94=A8=E3=80=82
+=E8=BF=99=E7=A7=8D=E6=96=B9=E8=A8=80=E5=8C=85=E5=90=AB=E5=AF=B9=E8=AF=AD=
=E8=A8=80 :ref:`gnu-extensions <cn_gnu-extensions>` =E7=9A=84=E8=AE=B8=E5=
=A4=9A=E6=89=A9=E5=B1=95=EF=BC=8C=E5=BD=93=E7=84=B6=EF=BC=8C=E5=AE=83=E4=BB=
=AC=E8=AE=B8=E5=A4=9A=E9=83=BD=E5=9C=A8=E5=86=85=E6=A0=B8=E4=B8=AD=E4=BD=BF=
=E7=94=A8=E3=80=82
=20
-=E5=AF=B9=E4=BA=8E=E4=B8=80=E4=BA=9B=E4=BD=93=E7=B3=BB=E7=BB=93=E6=9E=84=
=EF=BC=8C=E6=9C=89=E4=B8=80=E4=BA=9B=E4=BD=BF=E7=94=A8 ``clang`` [clang]_ =
=E5=92=8C ``icc`` [icc]_ =E7=BC=96=E8=AF=91=E5=86=85=E6=A0=B8
+=E5=AF=B9=E4=BA=8E=E4=B8=80=E4=BA=9B=E4=BD=93=E7=B3=BB=E7=BB=93=E6=9E=84=
=EF=BC=8C=E6=9C=89=E4=B8=80=E4=BA=9B=E4=BD=BF=E7=94=A8 ``clang`` :ref:`clan=
g <cn_clang>` =E5=92=8C ``icc`` :ref:`icc <cn_icc>` =E7=BC=96=E8=AF=91=E5=
=86=85=E6=A0=B8
 =E7=9A=84=E6=94=AF=E6=8C=81=EF=BC=8C=E5=B0=BD=E7=AE=A1=E5=9C=A8=E7=BC=96=
=E5=86=99=E6=AD=A4=E6=96=87=E6=A1=A3=E6=97=B6=E8=BF=98=E6=B2=A1=E6=9C=89=E5=
=AE=8C=E6=88=90=EF=BC=8C=E4=BB=8D=E9=9C=80=E8=A6=81=E7=AC=AC=E4=B8=89=E6=96=
=B9=E8=A1=A5=E4=B8=81=E3=80=82
=20
 =E5=B1=9E=E6=80=A7
 ----
=20
-=E5=9C=A8=E6=95=B4=E4=B8=AA=E5=86=85=E6=A0=B8=E4=B8=AD=E4=BD=BF=E7=94=A8=
=E7=9A=84=E4=B8=80=E4=B8=AA=E5=B8=B8=E8=A7=81=E6=89=A9=E5=B1=95=E6=98=AF=E5=
=B1=9E=E6=80=A7=EF=BC=88attributes=EF=BC=89 [gcc-attribute-syntax]_
+=E5=9C=A8=E6=95=B4=E4=B8=AA=E5=86=85=E6=A0=B8=E4=B8=AD=E4=BD=BF=E7=94=A8=
=E7=9A=84=E4=B8=80=E4=B8=AA=E5=B8=B8=E8=A7=81=E6=89=A9=E5=B1=95=E6=98=AF=E5=
=B1=9E=E6=80=A7=EF=BC=88attributes=EF=BC=89 :ref:`gcc-attribute-syntax <cn_=
gcc-attribute-syntax>`
 =E5=B1=9E=E6=80=A7=E5=85=81=E8=AE=B8=E5=B0=86=E5=AE=9E=E7=8E=B0=E5=AE=9A=
=E4=B9=89=E7=9A=84=E8=AF=AD=E4=B9=89=E5=BC=95=E5=85=A5=E8=AF=AD=E8=A8=80=E5=
=AE=9E=E4=BD=93=EF=BC=88=E5=A6=82=E5=8F=98=E9=87=8F=E3=80=81=E5=87=BD=E6=95=
=B0=E6=88=96=E7=B1=BB=E5=9E=8B=EF=BC=89=EF=BC=8C=E8=80=8C=E6=97=A0=E9=9C=80=
=E5=AF=B9=E8=AF=AD=E8=A8=80=E8=BF=9B=E8=A1=8C
-=E9=87=8D=E5=A4=A7=E7=9A=84=E8=AF=AD=E6=B3=95=E6=9B=B4=E6=94=B9=EF=BC=88=
=E4=BE=8B=E5=A6=82=E6=B7=BB=E5=8A=A0=E6=96=B0=E5=85=B3=E9=94=AE=E5=AD=97=EF=
=BC=89 [n2049]_
+=E9=87=8D=E5=A4=A7=E7=9A=84=E8=AF=AD=E6=B3=95=E6=9B=B4=E6=94=B9=EF=BC=88=
=E4=BE=8B=E5=A6=82=E6=B7=BB=E5=8A=A0=E6=96=B0=E5=85=B3=E9=94=AE=E5=AD=97=EF=
=BC=89 :ref:`n2049 <cn_n2049>`
=20
 =E5=9C=A8=E6=9F=90=E4=BA=9B=E6=83=85=E5=86=B5=E4=B8=8B=EF=BC=8C=E5=B1=9E=
=E6=80=A7=E6=98=AF=E5=8F=AF=E9=80=89=E7=9A=84=EF=BC=88=E5=8D=B3=E4=B8=8D=E6=
=94=AF=E6=8C=81=E8=BF=99=E4=BA=9B=E5=B1=9E=E6=80=A7=E7=9A=84=E7=BC=96=E8=AF=
=91=E5=99=A8=E4=BB=8D=E7=84=B6=E5=BA=94=E8=AF=A5=E7=94=9F=E6=88=90=E6=AD=A3=
=E7=A1=AE=E7=9A=84=E4=BB=A3=E7=A0=81=EF=BC=8C
 =E5=8D=B3=E4=BD=BF=E5=85=B6=E9=80=9F=E5=BA=A6=E8=BE=83=E6=85=A2=E6=88=96=
=E6=89=A7=E8=A1=8C=E7=9A=84=E7=BC=96=E8=AF=91=E6=97=B6=E6=A3=80=E6=9F=A5/=
=E8=AF=8A=E6=96=AD=E6=AC=A1=E6=95=B0=E4=B8=8D=E5=A4=9F=EF=BC=89
@@ -31,11 +31,42 @@
 ``__attribute__((__pure__))`` =EF=BC=89=EF=BC=8C=E4=BB=A5=E6=A3=80=E6=B5=
=8B=E5=8F=AF=E4=BB=A5=E4=BD=BF=E7=94=A8=E5=93=AA=E4=BA=9B=E5=85=B3=E9=94=AE=
=E5=AD=97=E5=92=8C/=E6=88=96=E7=BC=A9=E7=9F=AD=E4=BB=A3=E7=A0=81, =E5=85=B7=
=E4=BD=93
 =E8=AF=B7=E5=8F=82=E9=98=85 ``include/linux/compiler_attributes.h``
=20
-.. [c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
-.. [gcc] https://gcc.gnu.org
-.. [clang] https://clang.llvm.org
-.. [icc] https://software.intel.com/en-us/c-compilers
-.. [gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Op=
tions.html
-.. [gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
-.. [gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syn=
tax.html
-.. [n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
+.. _cn_c-language:
+
+c-language
+   http://www.open-std.org/jtc1/sc22/wg14/www/standards
+
+.. _cn_gcc:
+
+gcc
+   https://gcc.gnu.org
+
+.. _cn_clang:
+
+clang
+   https://clang.llvm.org
+
+.. _cn_icc:
+
+icc
+   https://software.intel.com/en-us/c-compilers
+
+.. _cn_gcc-c-dialect-options:
+
+c-dialect-options
+   https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
+
+.. _cn_gnu-extensions:
+
+gnu-extensions
+   https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
+
+.. _cn_gcc-attribute-syntax:
+
+gcc-attribute-syntax
+   https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
+
+.. _cn_n2049:
+
+n2049
+   http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf

