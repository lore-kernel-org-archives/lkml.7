Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65485C742D3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFE2208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YGIlTbL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGLQ1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:27:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:45895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfGLQ1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562948844;
        bh=Nrxdsq4Qz0JpkUNEaKvb3REo5DtrYOkqiocoF0y/Nw8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YGIlTbL3QWOJ/ZGD1VUgkTH0g6QZvyDu5GV2gPz04VZXuU5oXg6w0TrKSSIkejggX
         yn5reGhglGnP3DR+uyJhQdH4JOUlh7qozebmhWIoMPeic3iua7StC/wzRGtQp+UWfO
         rGUpcFvbAFHhUHZkuDU64h/J7u9dslnqt60PT0KI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.18] ([82.19.195.159]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MAhWl-1hbmAi3LrP-00BvRI; Fri, 12
 Jul 2019 18:27:23 +0200
Subject: Re: Asus C101P Chromeboot fails to boot with Linux 5.2
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <59042b09-7651-be1d-347f-0dc4aa02a91b@gmx.co.uk>
 <CANBLGcyO5wAHgSVjYFB+hcp+SzaKY9d0QJm-hxqnSYbZ4Yv97g@mail.gmail.com>
From:   Alex Dewar <alex.dewar@gmx.co.uk>
Message-ID: <862e98f3-8a89-a05e-1e85-e6f6004da32b@gmx.co.uk>
Date:   Fri, 12 Jul 2019 17:27:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANBLGcyO5wAHgSVjYFB+hcp+SzaKY9d0QJm-hxqnSYbZ4Yv97g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VKCQbKmJn1u/4Hr5rr8Okbv4QiPFlB4+uWWdIip/BmbgmpbvHQu
 IXhflMR1Z138nShCwQEIKRXFIHzPb2fzwPMlv7CLPGwp3D24IM8ev/dE6BHV97MF2EHM6Nx
 4kA0oTryaMTtWPDuRJgC8MbGO5Lo74d2hyQdXRFwrlQpbUAPbtPimAYXeNDDyhu/gbxD9hq
 KQ48goZm2o9MfgiRHbffQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t0mzbLbiGS4=:9sL3a9qUnFKP57KYZ+ddiq
 UbbiPOt9hGGz21cb7eGb0zVPAmlbbx++CGeHH4SRKMcdlwtF3Kqz6WVr9jkhFhfR3XRzIdd94
 iImgCr0dumgILni2v474de/WHj8R+4XNDHWeCESt/vhb7DO+J87DMMaz9cBDogsWsWqw0/1A6
 rRNMSUUEfWM8tJjYkW84WsSgMR0/zqzlCpEdwMBwmcDi1TQAY37QE/ucnvQkRF2Z4c6fQJKvP
 NX+4qm9c5atEHFSgY/G0asX5ZLxb6q8s9ptB9iD8s/9vooiZ/F9K25guDJpZ59t5PhnpVHTfB
 1lKpvZS2/ghcXotFNuODn/KTl3d+TKBlP48ho23Mn3E0hhKCm0AWlU3Vq/zuxd5rFgakuG64Z
 w9SfS4Czj/9SZYmaqa5Tv+NMa/kLhB4I5rPxXkSefA/aaUb8AnTSw41yees9AVyaE7Wwg7113
 mlGfMMfO1CI0F0nFuc+xnbWlcZXGQ+q5ZqJj5DBMviCn+pq8HEIoxLH06W4M/xqVIjchISl+Y
 PtxOZ7bCdt/4iKmiUoIhRMdoezAzs0wJSvy48Kt4VZ7TSiRURP3+sf96AOGrfXhS0Hkan7+Pd
 NCq4GyKLYFMZY6IxW/rcEnLBQofEcevsj3BKlQXEtTwZ6GMeTkSRZFUAD0H2F8phgE7IKxoqz
 i42aJy89zqR3+cvwYcr2oov/GbT0pXH9z/V/SFqjGwgob0gUDMZs62CGn9/Hegp3J/8c/Ji45
 jlBtoCabalf4yQIvuzUL3+moTBARFtHuDTAVWcn9ER9Hq9Kpi3EidNM5p+dH718kLBBY6fHMg
 IfFHM/dcW5RdPOCKlCntmExS+xyqeanWGmC7v5dm7uv9sneXrnZ556l4k1oIZSebVKkI7gwKK
 cYqNHMmC3wb9kCnEOU1EzIFKvYKOQbgY3mbiSaDHG8kfb5BBMN2qFkr7GPfyvh3cC9TtSTemO
 wAc5vG/VSThMRziZ07zo50gO0IlLgewOhcl7McWzsVr9UM9of9Vkb9RLh2YTxmUZvLJV8a/DZ
 XWQMoBVRO7I4EXlrrhIT7nG17eAZbwJUquFJYyEBY0J/cCiDh5lGBEyIKmt+ao3b0lqtinWjy
 eYvH0p38406BpkaBJg0eKdFpkrBqsMER4Lp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

I've tried booting with: audit=3D0 console=3Dtty0 console=3DttyS2,115200n8
earlyprintk=3DttyS2,115200n8 init=3D/sbin/init root=3DPARTUUID=3D%U/PARTNR=
OFF=3D1
rootwait rw noinitrd

Now I don't get the audit messages, but no other message is displayed
either. It just alternates between a flashing cursor and a multicoloured
square in the middle of the screen. The system isn't totally
unresponsive though. If I press the power button it still shuts down
properly.

I've just tested it again and confirmed that it does boot with the
v5.1.11 kernel.

Best,
Alex
