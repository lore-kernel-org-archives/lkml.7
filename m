Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FA4C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275F320684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="daPxCSQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfCFPRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:17:24 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:42508 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbfCFPRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:17:24 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id C27FA410CB;
        Wed,  6 Mar 2019 16:17:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1551885440; x=1553699841; bh=PBpVRARdgUEjNaRRthuRb9Kv3eWs38Z7fjx
        uasaKjWU=; b=daPxCSQJH3t1+FIo6w7VEwUwknyUMZ15yTpLO8BpUJySPYKV2QU
        fKCdTppVXY/Gi6fSzmKTfk+ivnUOqnZ6HbK46PoH0ykhKhDb7KHgqfBcVMf9Kt4H
        WUu8Z3ffVLvWxShBld6lF8oietM9zIsIaPeICvIj7h3GzoVHUAfVO5H9W2f+97jO
        3XN1UD0LQIWn6jmK1wWzBpQQbmCzQKdGI7R3A0pYAM1CX48eTiCYdTAZLGriVMqG
        BtPDv6Gq17eSS3sybW4B/rn4JoG/KMRtV1Hm9A+4uOu8/mUv+hKF3K+nyii0OEpm
        fo+wq89EFrYj4GZYcR3gBF0xdlbdwTMwpPLO1ClUEl0N2RMzwRI+X8WMdVglRKpX
        w5VsP8WEYkQOqh4fjBYjY+M6QkkYkRJtBfy3HG85SFNMF+uUwQlEIw8uO3hrjU0b
        GMV6rKSCiVHYPrOjuZqYPSgpaZVfTaDsHn/WFNnwIJCPCITuN1WiVfMdx+vDyHEs
        0LkzqYrBJ36kPGpsj2qBU8RMea8sWCN3f5GjfNlAt/j1gVxvzB2aUW9sofNW69oj
        UeIjEl2uIt/mCJUZld6IodMmm6bW8XdW//Othl+64P730Z9vomKuNb50hetnZ8dU
        qy5muv/PNBgp7WPgLzXotQ3ZLnzw+V4u2YMVytTaAHvKtWhGYlEroYLQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sc0izOWnpQyl; Wed,  6 Mar 2019 16:17:20 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 95AF640148;
        Wed,  6 Mar 2019 16:17:20 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 5BE9B2579;
        Wed,  6 Mar 2019 16:17:20 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-doc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, harryxiyou@gmail.com,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC PATCH] doc: translation disclaimer
Date:   Wed, 06 Mar 2019 16:17:19 +0100
Message-ID: <1683884.6qb0gnyTyR@pcbe13614>
In-Reply-To: <02cb673f-eaf0-f78a-49f3-e95340748694@linux.alibaba.com>
References: <20190305220611.13136-1-federico.vaga@vaga.pv.it> <02cb673f-eaf0-f78a-49f3-e95340748694@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Wednesday, March 6, 2019 2:57:05 AM CET Alex Shi wrote:
> Generally It looks good! A short guide to translator is good as well as a
> disclaimer.
> On 2019/3/6 6:06 =E4=B8=8A=E5=8D=88, Federico Vaga wrote:
> > This is only an example to propose a structure for translation's
> > disclaimers. The actual text needs some thoughs.
> >=20
> > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> > ---
> >=20
> >  Documentation/translations/index.rst           | 18 ++++++++++++++++++
> >  .../translations/it_IT/disclaimer-ita.rst      | 13 +++----------
> >  Documentation/translations/it_IT/index.rst     |  6 ++++++
> >  3 files changed, 27 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/Documentation/translations/index.rst
> > b/Documentation/translations/index.rst index 7f77c52d33aa..b46c8ce98d6e
> > 100644
> > --- a/Documentation/translations/index.rst
> > +++ b/Documentation/translations/index.rst
> > @@ -4,6 +4,24 @@
> >=20
> >  Translations
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > +.. _translations_disclaimer:
> > +
> > +Disclaimer
> > +----------
> > +Write some text in English here to explain that:
> > +
> > +- its purpose is to ease reading and understanding in other languages
> > +- this is not a fork
> > +- the only official documentation is :ref:`linux_doc`
>=20
> Could we merge the 2nd and 3rd into one, like this is not a fork of origi=
nal
> file :ref:`xxxx`

yes

> > +- there are not guarantee about translations being in line with the
> > +  main documentation
>=20
> Could we merge this one with 1st item, like its purpose is to xxxx without
> any guarantee of translations ....

yes, why not.

I did a list of items to separate the ingredients for the final text.

> > +- translation's maintainer can help people who can't write in English
> > +- only comments and patches about translations are accepted, any other
> > +  discussion about Documentation does not belong here.
>=20
> I am not very good at English. is the following words are bit more clear?
> like, only translation related update are accepted here, contents change
> need goes to original files ...

As I wrote in the commit message, this is just a  example to show the=20
structure and share the main message.

What I wrote is just a 10 minutes sketch, to share an idea. This is **not**=
=20
the text that I'm proposing; what I'm proposing here are the structure and =
the=20
concepts/ideas/messages. The final patch will be written appropriately, but=
=20
before doing it I would like to collect the messages that we want to put in=
=20
it; I listed above what I think is necessary to say.

> > +
> > +Translations
> > +------------
> > +
> >=20
> >  .. toctree::
> >     :maxdepth: 1
> >=20
> > diff --git a/Documentation/translations/it_IT/disclaimer-ita.rst
> > b/Documentation/translations/it_IT/disclaimer-ita.rst index
> > d68e52de6a5d..aacc1a0346db 100644
> > --- a/Documentation/translations/it_IT/disclaimer-ita.rst
> > +++ b/Documentation/translations/it_IT/disclaimer-ita.rst
> > @@ -1,13 +1,6 @@
> >=20
> >  :orphan:
> why the orphan here? does that mean no maintainer for it_IT currently?

It is a Sphinx tag to avoid warnings at build time. Instead of re-writing=20
exactly the same text in all files, this one is included at the top of all=
=20
translated documents. But, since it is not a real document this is not=20
included in any TOC and sphinx complains; that's why we need the orphan tag

http://www.sphinx-doc.org/en/master/usage/restructuredtext/field-lists.html=
#metadata

>=20
> Thanks
> Alex
>=20
> > -.. note::
> > -   This document is maintained by Federico Vaga
> > <federico.vaga@vaga.pv.it>. -   If you find any difference between this
> > document and the original file or a -   problem with the translation,
> > please contact the maintainer of this file. -   Following people helped
> > to translate or review:
> > -   Alessia Mantegazza <amantegazza@vaga.pv.it>
> > -
> >=20
> >  .. warning::
> > -   The purpose of this file is to be easier to read and understand for
> > Italian -   speakers and is not intended as a fork. So, if you have any
> > comments or -   updates for this file please try to update the original
> > English file first. +   Short (to not pollute the document) text in
> > Italian to explain that for any +   doubt about the documentation conte=
nt
> > people should refer to the English +   documentation. Read the
> > :ref:`it_disclaimer`.
> > diff --git a/Documentation/translations/it_IT/index.rst
> > b/Documentation/translations/it_IT/index.rst index
> > ea9b2916b3e4..4b0b3da97c73 100644
> > --- a/Documentation/translations/it_IT/index.rst
> > +++ b/Documentation/translations/it_IT/index.rst
> > @@ -4,6 +4,12 @@
> >=20
> >  Traduzione italiana
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > +.. _it_disclaimer:
> > +
> > +Disclaimer
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +The following text should be the translation of
> > :ref:`translations_disclaimer` +
> >=20
> >  L'obiettivo di questa traduzione =C3=A8 di rendere pi=C3=B9 facile la =
lettura e
> >  la comprensione per chi preferisce leggere in lingua italiana.
> >  Tenete presente che la documentazione di riferimento rimane comunque

=46ederico Vaga
http://www.federicovaga.it/


