Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8277C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3CC208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 22:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="i0yJjUJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfGLWHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 18:07:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:48299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbfGLWHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 18:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562969259;
        bh=fq3Eu2ziIA671I7SsmDCF6l1LQRFKArhSLSl56LX2rE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=i0yJjUJOIPQQBV5nUDzcy6lcuiN7rQx29HsMp5wlv6/vesemvblZ+W9nQ4nMMc6q2
         guUpTeEeT9vn/x5V0m4iZ548l15BakVVxtibcVwGdfDjeyvwdMC0R7eqwpUujM7C85
         SNDMWbWQJ6eGwFBPl2MG8AA8lwnCY+emlev3DV1I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.18] ([82.19.195.159]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCsQ4-1hdIGB1sga-008olC; Sat, 13
 Jul 2019 00:07:39 +0200
Subject: Re: Asus C101P Chromeboot fails to boot with Linux 5.2
From:   Alex Dewar <alex.dewar@gmx.co.uk>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <59042b09-7651-be1d-347f-0dc4aa02a91b@gmx.co.uk>
 <CANBLGcyO5wAHgSVjYFB+hcp+SzaKY9d0QJm-hxqnSYbZ4Yv97g@mail.gmail.com>
 <862e98f3-8a89-a05e-1e85-e6f6004da32b@gmx.co.uk>
Message-ID: <5fe66d5d-0624-323f-3bf8-56134ca85eca@gmx.co.uk>
Date:   Fri, 12 Jul 2019 23:07:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <862e98f3-8a89-a05e-1e85-e6f6004da32b@gmx.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wM6J7pCtfh2xM9icqBRa8aCSzjrU4kNCO9rWjhjgxXlj1P34JwA
 s2sLTX6BkjnBIeUDAYpI0G7I9TSJfUy6Mc2HEGBP+Z8WQUoFiRsGlBqtVHJtbX/7AeCL3h+
 3Nrn1KH6hcjKZbTsmxpNK5FLggvEq2ejKQCmxu9gB4+QcabipEirpdj9LpDrZ6yrqt5gms+
 uLy9VPtyC8f9GRW8+GLig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uc0Z/ZQQ3QM=:x7qcb3W6leQ49tXe59YmvK
 dbpxxswm5QMx2N6gQz3JnrgUHezku28Jjowo8HE23fOWTUIRUWqPPMmqPJGRSJ6Es5ffl5zHP
 t4U8/ftDE9RmYtdhNeahPEC5QqT59m0ZRocLm2RHVCi3xoyrvwmZw+DxJSXIgKAL4LLJ0gjku
 LQfcBqiOQH0mRihOqLT2h+gA3zSRBYgyvj/n1t7+rGRb8zHKGUMC10LexjsZKPELFjQ6cL99N
 Ty7HSAyZ2AY9CVJpyhE3dbqs3F+/QW3J9TIYfUXS3ehkV04FNwkyzX5zM9YDpGhZT075BXKKV
 tKvIfjN43UVRQobDa+MsRimMp8aU4h41WAXmUK7o9gcpY88ni3oxof+9mI41zAfbyzGd6Intx
 0p+kbthPMgWuVTrPyTj3YnQQ4NWL9arCxBdU5Hns3xWkt0Keya924xp0a0KparYfc+TbRQ8gf
 umTOYKibTIZOZJEmZ137d0KlEfvdRY8qoGv4abUrpaIuTUU7iqi6k+256XXwBUdmNkun5qrkR
 ldBFYlae8cO+Ckxt8gwuvy0rh/QCjIkHKDj9yTLMQ5hOom/3zkO8aMzl4om/2ce+LJjPTE4Q+
 11RftmSHaHc7dGsOaxdoScTiYnZQrHnr5h5LstJ+vBVwIJ9kqyhSmMG303cFpD0phlu07LQHv
 P7UCYwjiN/whfIb9ZTIibWPoNyd/jSjg4iqRQN6vnDgOl5e10n2Od8TeiGZ3e+3s4e81s0Z9/
 zwpcYmvJ23ripEc2G83B8r5EEmJdAW/TayJ879MZcnFuYsSokmnqONAvtq1doP80/L1jADlvv
 YxwE3W0AAY+pCB6yRhkNNG6uUQbA2vmBD4LevCYWm9oVg/zQk0bs2L1voMbHkAGIgbfVpCjOK
 0SEEPF2fovMPtoB4QzODt4rdFmjzOyZp6TaC7V7UfOu67Rr93ycSWAYpmQgWi8DwETyhm18UY
 9Ywy+Nk6nWDzAgMItqeS1Tm8nnOMs9Lp3IFoQEz93wkIb2658+HDxBUFjyI529xiYci5rwV+f
 8hwc+M9K0XUvtNCZ6C1o8Kcyh7MLs/BViux7V6qq91T13PPxr6I8FWr2U2Xr6xqMGei3n+ZIc
 JSDiwaYWLtE8S9F2C0I5x+h1jDsvDfdYZp7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just built v5.1 and v5.2 from source, without the Arch patches, and
get the same result: 5.1 boots and 5.2 doesn't. I tried adding
ignore_loglevel, but still just get a blinking cursor. So it's
definitely a regression.

I can have a go at bisecting this if it would help? Or is there
something else we could try first?

Alex
