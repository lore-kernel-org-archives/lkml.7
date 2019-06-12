Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FAAC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA1020896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560361226;
	bh=lrCzFlpYQEwoJZehEIwDCK9L/KuYMrr2u3g+nanQjfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SNacbRqLdC5aeqwi8hXmyFeljUlvLHHGkSKpu3yVwnjmtHej5ofWVF8IdkuIFgxND
	 l4YRxXd7E/ZGjovWfSlZicPIThzdtxTo81bfBhy1VO5A8ZrgoYCHZLXG4vf4JTW589
	 qzIooI7rUE1hL8hG7khkYUvUDxSGMvUJUH6w0vvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfFLRk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:40:26 -0400
Received: from casper.infradead.org ([85.118.1.10]:37624 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfFLRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QttHRjHJ7MdlFs6psyes3YVzvNlpLf2MWMHYPysLwuw=; b=QddYO1C9EJA++Jit0trZp/JUNF
        3wVeuwLM40EQ05IVR/ZKCgmmPouY6r5zSG+wmAaz1KZ5W5tzKVwYSr0Sa2M/r5RGDbAUMyWFebE51
        yUdq8Cevmj2flA/1vVfKKTtjyWhpFG/F+mk7tba3WWhkJ39a3kKwoxJ/Si70HAjOFrvOAbbwxKbOG
        sHKz4WruU56R1I4yQ+aDgF1epxWJUU/4Fi6IiwSL+HFDUMlbw055MCsq2e+Te1UTA9/dlCvQLbmZr
        zLdQ31mezeTlD2m8JCZ4WmNrfzKeg3e3Hl5RmZArBYmv2kVUs0v/Q29KZE+KZPnOxyIxgAA3ZJ6Rb
        IioY5hIQ==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7ER-0000RS-UF; Wed, 12 Jun 2019 17:40:20 +0000
Date:   Wed, 12 Jun 2019 14:40:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 33/33] docs: EDID/HOWTO.txt: convert it and rename to
 howto.rst
Message-ID: <20190612144015.033247db@coco.lan>
In-Reply-To: <20190611093701.44344d00@lwn.net>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
        <74bec0b5b7c32c8d84adbaf9ff208803475198e5.1560045490.git.mchehab+samsung@kernel.org>
        <20190611083731.GS21222@phenom.ffwll.local>
        <20190611060215.232af2bb@coco.lan>
        <20190611093701.44344d00@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 11 Jun 2019 09:37:01 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Tue, 11 Jun 2019 06:02:15 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
>=20
> > Jon, please correct me if I' wrong, bu I guess the plan is to place the=
m=20
> > somewhere under Documentation/admin-guide/. =20
>=20
> That makes sense to me.
>=20
> > If so, perhaps creating a Documentation/admin-guide/drm dir there and=20
> > place docs like EDID/HOWTO.txt, svga.txt, etc would work. =20
>=20
> Maybe "graphics" or "display" rather than "drm", which may not entirely
> applicable to all of those docs or as familiar to all admins?

It is up to Daniel/David to decide. Personally, I agree with you that
either "graphics" or "display" would be better at the admin guide.

>=20
> > Btw, that's one of the reasons[1] why I opted to keep the files where t=
hey
> > are: properly organizing the converted documents call for such kind
> > of discussions. On my experience, discussing names and directory locati=
ons
> > can generate warm discussions and take a lot of time to reach consensus=
. =20
>=20
> Moving docs is a pain; my life would certainly be easier if I were happy
> to just let everything lie where it fell :)  But it's far from the hardest
> problem we solve in kernel development, I assume we can figure it out.

Yeah, it is doable. I'm happy to write the rename patches and even try
to split some documents at the places I'm more familiar with, but, IMHO,
we should do some discussions before some of such renames.

For example, Daniel said that:

> > > Yeah atm we're doing a bad job of keeping the kapi and uapi parts
> > > separate. But the plan at least is to move all the gpu related uapi s=
tuff
> > > into Documentation/gpu/drm-uapi.rst. Not sure there's value in moving=
 that
> > > out of the gpu folder ...

=46rom the conversions I've made so far, almost all driver subsystems
put everything under Documentation/<subsystem: kAPI, uAPI, admin info,
driver-specific technical info.

It should be doable to place kAPI and uAPI on different books, but there
will be lots of cross-reference links between them, on properly-written
docs.

However, other admin-guide stuff under drivers are usually in the middle
of the documents. For example, on media, we have some at the uAPI guide,
like the Device Naming item:

	https://linuxtv.org/downloads/v4l-dvb-apis-new/uapi/v4l/open.html#device-n=
aming

But splitting it from uAPI guide is not an easy task.

At the driver's specific documentation is even messier.

Ok, splitting is doable, but require lots of dedication, and I'm not
convinced if it would make much difference in practice.

Thanks,
Mauro
