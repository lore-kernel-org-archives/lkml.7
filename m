Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B377C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDA8208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=velocard.eu header.i=@velocard.eu header.b="KeIeozMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfFGHyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:54:13 -0400
Received: from mail.velocard.eu ([80.211.74.207]:60782 "EHLO mail.velocard.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbfFGHyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:54:12 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 03:54:11 EDT
Received: by mail.velocard.eu (Postfix, from userid 1001)
        id 72F198765F; Fri,  7 Jun 2019 09:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=velocard.eu; s=mail;
        t=1559893555; bh=28mexHLKqDk2ixxtw16xz45K8l/dWN7qZL8I5V4XNxg=;
        h=Date:From:To:Subject:From;
        b=KeIeozMvSeJH+xfq4OyQK2T+GlDMi5kjRNCNirnAE0sUUjpZj8RR3MYuU4Wyqi7r3
         bZuuYcSpUei+Ka0fuEdt7HyfyrMhHKh04tT82b9T+fkWsKdjXLpsN5q2H9C3j18nNv
         GjBnYdyou0fTbf2rMcLJYq7fxaB2A/zYkGHG0N9c=
Received: by mail.velocard.eu for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 07:45:51 GMT
Message-ID: <20190607084500-0.1.j.1bgz.0.ubh8f70xkm@velocard.eu>
Date:   Fri,  7 Jun 2019 07:45:51 GMT
From:   =?UTF-8?Q? "Kapolcs_M=C3=A1ty=C3=A1s" ?= 
        <kapolcs.matyas@velocard.eu>
To:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?B=C3=A9ren_fel=C3=BCli_juttat=C3=A1sok?=
X-Mailer: mail.velocard.eu
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kedves H=C3=B6lgyem/Uram!

2019 janu=C3=A1rj=C3=A1t=C3=B3l szinte minden b=C3=A9ren k=C3=ADv=C3=BCli=
 juttat=C3=A1s j=C3=B6vedelemk=C3=A9nt fog ad=C3=B3zni (kiv=C3=A9telt k=C3=
=A9pez ez al=C3=B3l a SZ=C3=89P k=C3=A1rtya). A v=C3=A1ltoz=C3=A1sok elle=
n=C3=A9re a v=C3=A1llalatok t=C3=B6bb mint 55%-a meg k=C3=ADv=C3=A1nja ta=
rtani a dolgoz=C3=B3i juttat=C3=A1sok nett=C3=B3 =C3=B6sszeg=C3=A9t, mag=C3=
=A1ra v=C3=A1llalva ezzel a megemelkedett ad=C3=B3terheket.=20

Juttat=C3=A1si k=C3=A1rty=C3=A1ink seg=C3=ADts=C3=A9g=C3=A9vel 2019-ben a=
 munk=C3=A1ltat=C3=B3k lefedhetik szinte az =C3=B6sszes jelenleg haszn=C3=
=A1lt b=C3=A9ren k=C3=ADv=C3=BCli juttat=C3=A1st, mik=C3=B6zben munkav=C3=
=A1llal=C3=B3ik =C3=A9lvezhetik az ak=C3=A1r korl=C3=A1tlan felhaszn=C3=A1=
l=C3=A1s lehet=C5=91s=C3=A9g=C3=A9t.  A SZ=C3=89P k=C3=A1rty=C3=A1t=C3=B3=
l elt=C3=A9r=C5=91en a mi k=C3=A1rty=C3=A1inkkal olyan mindennapos k=C3=B6=
lts=C3=A9gek fedezhet=C5=91ek mint p=C3=A9ld=C3=A1ul =C3=A9lelmiszer v=C3=
=A1s=C3=A1rl=C3=A1s, eg=C3=A9szs=C3=A9g=C3=BCgyi ell=C3=A1t=C3=A1s, ruh=C3=
=A1zat, elektronika, =C3=BCzemanyagk=C3=B6lts=C3=A9g, k=C3=B6zm=C5=B1d=C3=
=ADj, s=C5=91t, ak=C3=A1r m=C3=A9g k=C3=A9szp=C3=A9nzfelv=C3=A9telre is a=
lkalmasak.=20

Ez az egyetlen olyan juttat=C3=A1si k=C3=A1rtya a magyar piacon, melyet m=
inden hazai POS termin=C3=A1l elfogad, ezzel biztos=C3=ADtva a k=C3=A1rty=
a sz=C3=A9les k=C3=B6r=C5=B1 felhaszn=C3=A1lhat=C3=B3s=C3=A1g=C3=A1t.=20

Sz=C3=ADvesen bemutatom =C3=96nnek, milyen tov=C3=A1bbi el=C5=91ny=C3=B6k=
kel j=C3=A1r k=C3=A1rty=C3=A1ink dolgoz=C3=B3i juttat=C3=A1sk=C3=A9nt t=C3=
=B6rt=C3=A9n=C5=91 alkalmaz=C3=A1sa, =C3=A9s r=C3=A9szletes t=C3=A1j=C3=A9=
koztat=C3=A1st adok a k=C3=A1rty=C3=A1k felhaszn=C3=A1l=C3=A1si lehet=C5=91=
s=C3=A9geir=C5=91l =E2=80=93 k=C3=A9rem jelezze ez ir=C3=A1nti ig=C3=A9ny=
=C3=A9t.=20


Kapolcs M=C3=A1ty=C3=A1s
Hungary Team Leader =20

