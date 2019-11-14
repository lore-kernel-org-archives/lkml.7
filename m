Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882BAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650BB206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxTyrN9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKNULN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:11:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33125 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726991AbfKNULN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573762271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VTSMW7yiszdsz9+obyoZO8enMubl8X2pXKrcjl0PUMI=;
        b=TxTyrN9ZExxoycdWx5XlYHU/ui9PTx8Yj9lbrVf5CK8ONDu9SveWFYU/AhEvpYK0MGP7Lf
        DB+IibyRkpJoCWrOlpZ43wk9ymYszX/nSpvW8Y6LURIXzRiCvCLnpyNLe924dtrinNT7/3
        4RBptn+w0XEU46aW3vgC0ISJ2w8hBEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-40nTPR-8OIWJANFhu8z5Yw-1; Thu, 14 Nov 2019 15:11:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66D7CDB60;
        Thu, 14 Nov 2019 20:11:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5779C60BE1;
        Thu, 14 Nov 2019 20:11:05 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B2F454BB5C;
        Thu, 14 Nov 2019 20:11:04 +0000 (UTC)
Date:   Thu, 14 Nov 2019 15:11:04 -0500 (EST)
From:   Jan Stancek <jstancek@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Brown <broonie@kernel.org>, lkft-triage@lists.linaro.org,
        LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>
Message-ID: <247236994.12271471.1573762264445.JavaMail.zimbra@redhat.com>
In-Reply-To: <CA+G9fYtpOaYDoUEzQuYxmKJLFH2GDvK3ipWienn-zHDB+nOMbg@mail.gmail.com>
References: <20191114193132.5de921a7@canb.auug.org.au> <CA+G9fYtpOaYDoUEzQuYxmKJLFH2GDvK3ipWienn-zHDB+nOMbg@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 14
MIME-Version: 1.0
X-Originating-IP: [10.40.204.254, 10.4.195.5]
Thread-Topic: linux-next: Tree for Nov 14
Thread-Index: YqTkoYhDRfL/aNkJZ5JfFnjXrrr8Bg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 40nTPR-8OIWJANFhu8z5Yw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> On Thu, 14 Nov 2019 at 14:01, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
> >
> > Hi all,
> > Changes since 20191113:
> > The y2038 tree gained a build failure for which I applied a patch.
> <trim>
> > The akpm-current tree gained a conflict against the y2038 tree.
> >
> > Non-merge commits (relative to Linus' tree): 10388
> >  9238 files changed, 397357 insertions(+), 174171 deletions(-)
>=20
> Results from Linaro=E2=80=99s test farm.
> Regressions detected on x86_64, and i386.
>=20
> LTP syscalls settimeofday01/02 failed on x86_64 and i386 running
> 5.4.0-rc7-next-20191114.
>=20
> Following  ltp-syscalls-tests failed.
>     * settimeofday01
>     * settimeofday02
>     * stime01
>     * stime02

Looks like typo in
adde74306a4b ("y2038: time: avoid timespec usage in settimeofday()")

-               if (!timeval_valid(&user_tv))
+               if (tv->tv_usec > USEC_PER_SEC)

was likely meant as:

-               if (!timeval_valid(&user_tv))
+               if (new_ts.tv_nsec > USEC_PER_SEC)

since tv is user pointer.

