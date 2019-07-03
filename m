Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16A9C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976D9218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GP5yP5Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfGCIvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:51:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:46665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfGCIvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562143879;
        bh=9PB186LEloBouYC1p2ldmUewg113AS/sk7TTgnQz8eE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GP5yP5IwXwZWTpXfe8SA3N/3zIgAF+n+xBPjg9pP/80VsehK5SJFrQkblA+mcm8DL
         sUdghrvHHHWKKaCfmCJ0D3UG6/YDOjOQpxkP1ZLW5p34Vlg8nDHz2GbATIjAq4iZnF
         HMkkGm05EwVq93gDCm9rVb23E/04+chH5Y0S9mZk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.158.204] ([217.61.158.204]) by web-mail.gmx.net
 (3c-app-gmx-bs07.server.lan [172.19.170.56]) (via HTTP); Wed, 3 Jul 2019
 10:51:18 +0200
MIME-Version: 1.0
Message-ID: <trinity-ca99ab22-eda4-42dd-b6eb-8e4bb5c99165-1562143878858@3c-app-gmx-bs07>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Matthias Brugger" <matthias.bgg@gmail.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Josef Friedl" <josef.friedl@speed.at>,
        "Sean Wang" <sean.wang@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: Aw: Re: [PATCH 3/3] add driver and MAINTAINERS for poweroff
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 3 Jul 2019 10:51:18 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <c1358da0-60a4-49dd-71a8-77e90178c9c9@gmail.com>
References: <20190702094045.3652-1-frank-w@public-files.de>
 <20190702094045.3652-4-frank-w@public-files.de>
 <c1358da0-60a4-49dd-71a8-77e90178c9c9@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:JPZTCh1ZfJHpWzb5eYAk5s1kOodanJvlOtH0JoIL8Th5cL5eBNXN53MDJZG4Tiea1rQbA
 ZPZUQ2sgDFECxxKapNnBOheINb976QRPW6Wr+OzxgmAp/lN91irS9iqxWTnAZKTjmXV12PyN+sy4
 NbqHa0eaADVQOZFLcZBw3UAFT3quKZoGm9gT5BJ8AnNIp6Q2+Xhtg56dlrva6jfmPpBj/aPTgVlv
 qN998m7tH0wsHPJGQ0k3O8vu3SoNVkokqEOBJ0FoektvVCYGUVcdxc8BFFzZ+UHMiman3Qxnb3Kr
 1I=
X-UI-Out-Filterresults: notjunk:1;V03:K0:1DICHQPpQTI=:A+NaXAfFhjiJt8kS1grdXD
 I8q+xw9r5eK5Hs0XxMcq9YAmZoEbhl5ngXLZirqdMYPNCsnaKMeVeOGCf9SfEUioYjkiIUQZB
 TiTU8Tw6t6rLww2mYVN1zH/UGj6ISVUDdFgBQzicUwLNh7UP13UCGyLB+vaa+JHKeyjJhppkh
 BOkc62et0yP0yk/E6tM1TaT+Q8NjGJhKTNSJ4AR2VqJJKLaFVhE/S5qmusGjjOrn7imr1sP2J
 YWSqbIRWftYdT90MSZWM/nf5wB0aEcYxrwElx37L5KD4b1WAMyQSQCHqKYDuqkDnO6nhM4tzb
 VnWUJ/TP7MdswuWgS3pfMJr5XBXJkMnvTgVk0LTfAtgRqeIz2VeNu6nQ/ixPwXb91Wj7ozvzq
 yFfBYU/ahOjjVvEO01PVk+8Mkmf//BE6fUQMqH98N5YHiAXJiP9SzCkZ1r7FFSAa6+hJC3nJs
 pr6O7q1FU1E5qaHAM6+fUin6y8Ub+D5hgJ4C7Mhe7dAnun5Ww3Kx9D39Vl4lk6sFiVxJbDO1j
 SFZGpLKXUGusvNivSBCQDEA6xIf6PV3Cx3dTQdyTIE5iXnp/dPMTYDFgVmWmyZNl89b1elkg9
 sbM2p9+6MwlcJiHH4VvESL7N3bbu3YQlskn0BljRWyD9FjsUmDrJRvl1abkbvjegDrIJ3Ue/u
 BODs=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias

thank you for first look on this. Patchseries is originally from Josef Fri=
edl i got some time ago for getting poweroff working on bananapi r2. There=
 it works and maybe on another devices too.

drivers/rtc/rtc-mt6397.c and drivers/rtc/rtc-mt7622.c look very differentl=
y on a diff (you've commented in part 1/3)

maybe code is compatible but i have not the knowledge to compare this...ma=
ybe sean (sorry, that i missed you) or ryder can say a word about the comp=
atibility.

> Fix the commit message. MAINTAINERS get normally send a independent patc=
h.
> Split patches between RTC and PWRC.
> If not a new patch it should be stated in the commit message at least.

i will try to split this

> > + * Author: Tianping.Fang <tianping.fang@mediatek.com>
> > + *        Sean Wang <sean.wang@mediatek.com>
>
> You are the author of this file, aren't you?

no, afaik these is code taken from rtc-mt6397.c and put in a separate head=
er-file to use it in multiple c-files.

sidenote on encoding/word-wrap. i use only "git sendemail" which afaik cal=
ls sendmail (no other mta like thunderbird or similar) on ubuntu 18.4....c=
urently have no idea how to fix this...have searched before, but not yet f=
ound anything. if you have an idea please give me a hint.

regards Frank
