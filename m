Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D98C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD1520652
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561061784;
	bh=SWcfkEOEVbWaHHRHA9IDqTMmCUWrjXZHT6F+bBy/R3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lhYOKZhG5nGsXS9YzLaueiEY9qKIOUPd53Ii133TAJZNhHaVr6OfPDGnYp0J5rXr/
	 Lkgpep/IjMnRqd5gGQ/2f0f/3lD5N5/x+OQ2YKJAREXdDlcQLGo/sgM9AA0QvAFLkS
	 v2oH8WUM+BiRt+6SJfQOBMPHdz1h+rlBFVkUzHnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfFTUQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:16:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfFTUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xLzSHA4/gkaFqrZh4lXTfktvq/utTEgs9SNl0/TIIiA=; b=dZq86h2FV+z4V1VI/QUx53zQF
        dxVMbFlrsah5ck1D4PgYAVcG3iB9XjoIzyVuHBPABMWz/HQLuttjJiL79wRPjexu9kgLZurRiiIDX
        KDzJ2y/KFgJ6Exk3RoKZ8YGgz1rulVez2qcknoCc8yesftHiTI72QWVj56p+PZeLQLrtpFPKSkEcg
        sDr6f881KAZy9b0xMoBJVeedV2q0sYywr0kK17Vg6kItjOhPxzGXT4+1VhZpbO0pq7fl0ZPRbcwZI
        lRwUgmf0ZLgYmCPxbB5aFJNPz8RWfZrp2bByCLTvPJQZg5vxfDPcz9kFvRqbwR4F8Nywuq9n9lnOW
        Sr4HlaVog==;
Received: from [177.97.20.138] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he3Tp-00074O-O7; Thu, 20 Jun 2019 20:16:21 +0000
Date:   Thu, 20 Jun 2019 17:16:17 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/6] time: hrtimer: use a bullet for the returns bullet
 list
Message-ID: <20190620171617.3368f30b@coco.lan>
In-Reply-To: <20190620140233.3d7202ee@lwn.net>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
        <a4cab6020e0475e7a4afc65dc5854756dd1bfbe9.1560883872.git.mchehab+samsung@kernel.org>
        <20190620140233.3d7202ee@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 20 Jun 2019 14:02:33 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Tue, 18 Jun 2019 15:51:20 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
>=20
> > That gets rid of this warning:
> >=20
> > 	./kernel/time/hrtimer.c:1119: WARNING: Block quote ends without a blan=
k line; unexpected unindent.
> >=20
> > and displays nicely both at the source code and at the produced
> > documentation.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  kernel/time/hrtimer.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> > index edb230aba3d1..49f78453892f 100644
> > --- a/kernel/time/hrtimer.c
> > +++ b/kernel/time/hrtimer.c
> > @@ -1114,9 +1114,10 @@ EXPORT_SYMBOL_GPL(hrtimer_start_range_ns);
> >   * @timer:	hrtimer to stop
> >   *
> >   * Returns:
> > - *  0 when the timer was not active
> > - *  1 when the timer was active
> > - * -1 when the timer is currently executing the callback function and
> > + *
> > + *  =E2=80=A2  0 when the timer was not active
> > + *  =E2=80=A2  1 when the timer was active
> > + *  =E2=80=A2 -1 when the timer is currently executing the callback fu=
nction and
> >   *    cannot be stopped =20
>=20
> So I have taken some grief for letting non-ASCII stuff into the docs
> before; I can only imagine that those who object would be even more
> unhappy to see it in a C source file.  I'm all for fixing the warning, but
> I think we shouldn't start introducing exotic characters at this point...

According to:
	http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#bullet-=
lists

The ASCII options are: "-", "+" or "*".

Both signs ('-' and '+') aren't too nice here, due to "-1".

So, what's left is '*'.

I remember someone once complained about having something like:

	* * -1 when the ...

But if you think we shouldn't use UTF-8 chars, be it.

Feel free to replace it at the patch, or if you prefer, I'll send a new
version tomorrow.

Thanks,
Mauro
