Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0719DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E6D23A1C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559643667;
	bh=kCxA6uuhFQC5uXjmGgBXyzWV5U3a7KmyKULiqxOFMxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jEa/AfHIzhwMj2ukz6YHLmDgq4ky3s6tuDB+oCgxA3L6MOktN5yHuuxJD40GtXo/6
	 zG7MeTOcl73521ysylEWigreBzEaRlJmiN1nQ1orb84dKajnqUob7NsfW9rYqiaLU7
	 nunsJ7KlDpraugDG6Ik8xIr5OL++vFscIn58VAuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfFDKVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:21:07 -0400
Received: from casper.infradead.org ([85.118.1.10]:39178 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfFDKVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1LiJjE4BLUZ/6TOa4AMue6i7oaMUCoQxA04hSPyYLbU=; b=ElkNkY5Re78xH6p69xUwtSo/Ng
        5LMt73wKzH4YbdNZEoCt8xucen+jn2mKEyqbnxjdDf69U/ewG8Bgp3wYbZYP7osLlVam9py9Su7YT
        2j5OVRXTnZkuuEIOnwtm9MBZn4nFKTVIHX/6VTsk7CrZ8AodKVgf6F8a60od+aMPvYvm7cVtGb8Hs
        jEw4aplK6rVEIp6mEe/cYqAglYmSDjTkAWYqlpsns3WwEP4KfX9EPJDtP/8sKlYHrHZv/4SFbfdWC
        JHDebl4omHJcgenolvSq8dh8e02D69XE87HN8vVSnLx1zTrWq1lIMlG6tu1Za9jQJ24Yovf+fCWFo
        ZEtqeQzQ==;
Received: from [187.113.6.249] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY6Yw-00060q-Bv; Tue, 04 Jun 2019 10:21:02 +0000
Date:   Tue, 4 Jun 2019 07:20:57 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>
Subject: Re: [PATCH 13/22] docs: zh_CN: avoid duplicate citation references
Message-ID: <20190604072057.47d2f6f8@coco.lan>
In-Reply-To: <04bca27d-3c59-5cc7-576b-44e399fa893f@linux.alibaba.com>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
        <9d3b9729663f75249b514dd3910309eb418d9e46.1559171394.git.mchehab+samsung@kernel.org>
        <04bca27d-3c59-5cc7-576b-44e399fa893f@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 2 Jun 2019 23:01:21 +0800
Alex Shi <alex.shi@linux.alibaba.com> escreveu:

> On 2019/5/30 7:23 =E4=B8=8A=E5=8D=88, Mauro Carvalho Chehab wrote:
> >     Documentation/process/management-style.rst:35: WARNING: duplicate l=
abel decisions, other instance in     Documentation/translations/zh_CN/proc=
ess/management-style.rst
> >     Documentation/process/programming-language.rst:37: WARNING: duplica=
te citation c-language, other instance in     Documentation/translations/zh=
_CN/process/programming-language.rst
> >     Documentation/process/programming-language.rst:38: WARNING: duplica=
te citation gcc, other instance in     Documentation/translations/zh_CN/pro=
cess/programming-language.rst
> >     Documentation/process/programming-language.rst:39: WARNING: duplica=
te citation clang, other instance in     Documentation/translations/zh_CN/p=
rocess/programming-language.rst
> >     Documentation/process/programming-language.rst:40: WARNING: duplica=
te citation icc, other instance in     Documentation/translations/zh_CN/pro=
cess/programming-language.rst
> >     Documentation/process/programming-language.rst:41: WARNING: duplica=
te citation gcc-c-dialect-options, other instance in     Documentation/tran=
slations/zh_CN/process/programming-language.rst
> >     Documentation/process/programming-language.rst:42: WARNING: duplica=
te citation gnu-extensions, other instance in     Documentation/translation=
s/zh_CN/process/programming-language.rst
> >     Documentation/process/programming-language.rst:43: WARNING: duplica=
te citation gcc-attribute-syntax, other instance in     Documentation/trans=
lations/zh_CN/process/programming-language.rst
> >     Documentation/process/programming-language.rst:44: WARNING: duplica=
te citation n2049, other instance in     Documentation/translations/zh_CN/p=
rocess/programming-language.rst
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  .../zh_CN/process/management-style.rst        |  4 +--
> >  .../zh_CN/process/programming-language.rst    | 28 +++++++++----------
> >  2 files changed, 16 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/Documentation/translations/zh_CN/process/management-style.=
rst b/Documentation/translations/zh_CN/process/management-style.rst
> > index a181fa56d19e..c6a5bb285797 100644
> > --- a/Documentation/translations/zh_CN/process/management-style.rst
> > +++ b/Documentation/translations/zh_CN/process/management-style.rst
> > @@ -28,7 +28,7 @@ Linux=E5=86=85=E6=A0=B8=E7=AE=A1=E7=90=86=E9=A3=8E=E6=
=A0=BC
> > =20
> >  =E4=B8=8D=E7=AE=A1=E6=80=8E=E6=A0=B7=EF=BC=8C=E8=BF=99=E9=87=8C=E6=98=
=AF=EF=BC=9A
> > =20
> > -.. _decisions:
> > +.. _cn_decisions:
> > =20
> >  1=EF=BC=89=E5=86=B3=E7=AD=96
> >  -------
> > @@ -108,7 +108,7 @@ Linux=E5=86=85=E6=A0=B8=E7=AE=A1=E7=90=86=E9=A3=8E=
=E6=A0=BC
> >  =E4=BD=86=E6=98=AF=EF=BC=8C=E4=B8=BA=E4=BA=86=E5=81=9A=E5=A5=BD=E4=BD=
=9C=E4=B8=BA=E5=86=85=E6=A0=B8=E7=AE=A1=E7=90=86=E8=80=85=E7=9A=84=E5=87=86=
=E5=A4=87=EF=BC=8C=E6=9C=80=E5=A5=BD=E8=AE=B0=E4=BD=8F=E4=B8=8D=E8=A6=81=E7=
=83=A7=E6=8E=89=E4=BB=BB=E4=BD=95=E6=A1=A5=E6=A2=81=EF=BC=8C=E4=B8=8D=E8=A6=
=81=E8=BD=B0=E7=82=B8=E4=BB=BB=E4=BD=95
> >  =E6=97=A0=E8=BE=9C=E7=9A=84=E6=9D=91=E6=B0=91=EF=BC=8C=E4=B9=9F=E4=B8=
=8D=E8=A6=81=E7=96=8F=E8=BF=9C=E5=A4=AA=E5=A4=9A=E7=9A=84=E5=86=85=E6=A0=B8=
=E5=BC=80=E5=8F=91=E4=BA=BA=E5=91=98=E3=80=82=E4=BA=8B=E5=AE=9E=E8=AF=81=E6=
=98=8E=EF=BC=8C=E7=96=8F=E8=BF=9C=E4=BA=BA=E6=98=AF=E7=9B=B8=E5=BD=93=E5=AE=
=B9=E6=98=93=E7=9A=84=EF=BC=8C=E8=80=8C
> >  =E4=BA=B2=E8=BF=91=E4=B8=80=E4=B8=AA=E7=96=8F=E8=BF=9C=E7=9A=84=E4=BA=
=BA=E6=98=AF=E5=BE=88=E9=9A=BE=E7=9A=84=E3=80=82=E5=9B=A0=E6=AD=A4=EF=BC=8C=
=E2=80=9C=E7=96=8F=E8=BF=9C=E2=80=9D=E7=AB=8B=E5=8D=B3=E5=B1=9E=E4=BA=8E=E2=
=80=9C=E4=B8=8D=E5=8F=AF=E9=80=86=E2=80=9D=E7=9A=84=E8=8C=83=E7=95=B4=EF=BC=
=8C=E5=B9=B6=E6=A0=B9=E6=8D=AE
> > -:ref:`decisions` =E6=88=90=E4=B8=BA=E7=BB=9D=E4=B8=8D=E5=8F=AF=E4=BB=
=A5=E5=81=9A=E7=9A=84=E4=BA=8B=E6=83=85=E3=80=82
> > +:ref:`cn_decisions` =E6=88=90=E4=B8=BA=E7=BB=9D=E4=B8=8D=E5=8F=AF=E4=
=BB=A5=E5=81=9A=E7=9A=84=E4=BA=8B=E6=83=85=E3=80=82 =20
>=20
> It's good to have.
>=20
> > =20
> >  =E8=BF=99=E9=87=8C=E5=8F=AA=E6=9C=89=E5=87=A0=E4=B8=AA=E7=AE=80=E5=8D=
=95=E7=9A=84=E8=A7=84=E5=88=99=EF=BC=9A
> > =20
> > diff --git a/Documentation/translations/zh_CN/process/programming-langu=
age.rst b/Documentation/translations/zh_CN/process/programming-language.rst
> > index 51fd4ef48ea1..9de9a3108c4d 100644
> > --- a/Documentation/translations/zh_CN/process/programming-language.rst
> > +++ b/Documentation/translations/zh_CN/process/programming-language.rst
> > @@ -8,21 +8,21 @@
> >  =E7=A8=8B=E5=BA=8F=E8=AE=BE=E8=AE=A1=E8=AF=AD=E8=A8=80
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> > -=E5=86=85=E6=A0=B8=E6=98=AF=E7=94=A8C=E8=AF=AD=E8=A8=80 [c-language]_ =
=E7=BC=96=E5=86=99=E7=9A=84=E3=80=82=E6=9B=B4=E5=87=86=E7=A1=AE=E5=9C=B0=E8=
=AF=B4=EF=BC=8C=E5=86=85=E6=A0=B8=E9=80=9A=E5=B8=B8=E6=98=AF=E7=94=A8 ``gcc=
`` [gcc]_
> > -=E5=9C=A8 ``-std=3Dgnu89`` [gcc-c-dialect-options]_ =E4=B8=8B=E7=BC=96=
=E8=AF=91=E7=9A=84=EF=BC=9AISO C90=E7=9A=84 GNU =E6=96=B9=E8=A8=80=EF=BC=88
> > +=E5=86=85=E6=A0=B8=E6=98=AF=E7=94=A8C=E8=AF=AD=E8=A8=80 [cn_c-language=
]_ =E7=BC=96=E5=86=99=E7=9A=84=E3=80=82=E6=9B=B4=E5=87=86=E7=A1=AE=E5=9C=B0=
=E8=AF=B4=EF=BC=8C=E5=86=85=E6=A0=B8=E9=80=9A=E5=B8=B8=E6=98=AF=E7=94=A8 ``=
gcc`` [cn_gcc]_ =20
>=20
> this change isn't good. cn_gcc will show in docs, it looks wired and conf=
using for peoples. other changes have the same issue. Could you find other =
way to fix the warning? or I'd rather tolerant it.

Well, Sphinx has a way to do that, like, for example:

diff --git a/Documentation/translations/zh_CN/process/programming-language.=
rst b/Documentation/translations/zh_CN/process/programming-language.rst
index 9de9a3108c4d..353fb8eaf4b5 100644
--- a/Documentation/translations/zh_CN/process/programming-language.rst
+++ b/Documentation/translations/zh_CN/process/programming-language.rst
@@ -9,7 +9,7 @@
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 =E5=86=85=E6=A0=B8=E6=98=AF=E7=94=A8C=E8=AF=AD=E8=A8=80 [cn_c-language]_ =
=E7=BC=96=E5=86=99=E7=9A=84=E3=80=82=E6=9B=B4=E5=87=86=E7=A1=AE=E5=9C=B0=E8=
=AF=B4=EF=BC=8C=E5=86=85=E6=A0=B8=E9=80=9A=E5=B8=B8=E6=98=AF=E7=94=A8 ``gcc=
`` [cn_gcc]_
-=E5=9C=A8 ``-std=3Dgnu89`` [cn_gcc-c-dialect-options]_ =E4=B8=8B=E7=BC=96=
=E8=AF=91=E7=9A=84=EF=BC=9AISO C90=E7=9A=84 GNU =E6=96=B9=E8=A8=80=EF=BC=88
+=E5=9C=A8 ``-std=3Dgnu89`` :ref:`gcc C dialect options <cn_gcc-c-dialect-o=
ptions>` =E4=B8=8B=E7=BC=96=E8=AF=91=E7=9A=84=EF=BC=9AISO C90=E7=9A=84 GNU =
=E6=96=B9=E8=A8=80=EF=BC=88
 =E5=8C=85=E6=8B=AC=E4=B8=80=E4=BA=9BC99=E7=89=B9=E6=80=A7=EF=BC=89
=20
 =E8=BF=99=E7=A7=8D=E6=96=B9=E8=A8=80=E5=8C=85=E5=90=AB=E5=AF=B9=E8=AF=AD=
=E8=A8=80 [cn_gnu-extensions]_ =E7=9A=84=E8=AE=B8=E5=A4=9A=E6=89=A9=E5=B1=
=95=EF=BC=8C=E5=BD=93=E7=84=B6=EF=BC=8C=E5=AE=83=E4=BB=AC=E8=AE=B8=E5=A4=9A=
=E9=83=BD=E5=9C=A8=E5=86=85=E6=A0=B8=E4=B8=AD=E4=BD=BF=E7=94=A8=E3=80=82

If we use that, at least for some of those references, it would probably
be better to translate "dialect-options" (and similar terms) to Chinese.

Thanks,
Mauro
