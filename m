Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EBDC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2B2256DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Jw4Ud/Fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfE3KMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 06:12:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:34109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfE3KMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 06:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559211164;
        bh=hj0JmJoKrbKo0kNtrEQyUbV6+9Oj1+AD3IrDjQ8FxeU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Jw4Ud/Fjb4uivkmC1rP8mTV8OprkDC72UMplmzzNOOlbVGIcxPOtIHkhsKlA3RHiZ
         8d6TEB6LV9Cj3dUmMcL3TK/vWOE+izdMRsQLxhLlKbNDVKw61JmHwC9XpFTxY+emK+
         kOzXC9p5Wnq2/IAkKJsMztDThkBojQiiprlW0Q9c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.166] ([37.4.249.160]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvqW-1gvIo13STe-00b0KZ; Thu, 30
 May 2019 12:12:43 +0200
Subject: Re: [PATCH 0/7] ARM: dts: Broadcom: Fix W=1 DTC warnings
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Brian Norris <computersforpeace@gmail.com>
References: <20190528230134.27007-1-f.fainelli@gmail.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <070047b5-a101-e7b3-9ef3-7afc765921d9@gmx.net>
Date:   Thu, 30 May 2019 12:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528230134.27007-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:8bKgMOPWa8LkhAvg01EzpUp+5SMkw19C68RsVzKXMI0izuMs8p+
 zCr1oY7LfL0012BFijFabgcgORBAQIKZ4lH/xhTrR1kg6VfFh1a22Y9JLQcO26ZHGKc8U3r
 YiGYAss+CCWrVQYkDS7B6jOsVEr5B86wYUTpSkH1BZvkeXFmYcmc9KpFxHnSI5wR0aMXMRZ
 AbNAkWECobdv9zULa10Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oTZVT7i2Iig=:3pvE6Z2N+KE3/BtfvG6R2R
 1sfzHsY6UmbKDUaCW5YVoaAOIU4K/Tom9EC+bfy/BOeGeO/8Qn/3cv5e6EV9z0k04egYfGWIg
 X92U+26aL84nhbqLfuuDR5gTyuXgGYt/lxYeddByJ/RGZTf+Q2kv8PDspGJOEyrtBJQsK4A7g
 ZQVqAgth0BGIfirZnWO1iIGNMs6tjMLpCYawD6CgRyx1Cd+BM59acTvv5F4rvO0mbxYw2DUvC
 9BU1MQRsWaqCYwr5WTPyNpzwLPzt4w5ANAm0XWLdcICdI09wHrXnHs9hsM8lIUScyaLHvDyRb
 xlqWtRMHB5BuFpg2Q4hXBazWfW5Co036gHuc5DuBIfyYByzvBGKmbInjohR8GtyCvRUJbxrvr
 oFd7YGbFd2K9aFhJIDswZ22qEuZeHJ2QXr6wvXC2Zy/l4ML4cge94HnrimBkfamE5nRU1f6Jx
 Cs5QEj0sEmRQFwTzCPPSN8rWTAjxJkQsoA3E76ym9ljSusvy6SXW0IK97xXEUwZy2e4m37Xx3
 It3k8zlsKI810yREsr1d3VriRad85H6Zqs0XUu7vpym+AI5MiLj25b6vAzsWFJ6kWIzli1b3X
 7CpLwVO9X/2hgmAGDn/sno6bzK1yxhJGbbLCMOSgQ8qE4xAIrF+bpIDgcqvFdNXRvinieW3kH
 rINfaraZb6o/7fxCqqlO5J5f3T2NyJRvhKJshSAijxKq00SSH/u3gTlP9EwZxnssPWMI0vUlL
 qJspZIz/4nAeHVB8e5koO++/S9+VhehO73CuFaW0yeytcx3/Io47LP4P1HibQ2xXvj5daCf90
 KE9m9CP2wMM5U+p877GwYzgxRWTM8w2OwbwDqgP5bZGGwYlAywmZI+SX+T24lzdrIpgpgpoxy
 oNtl7aUfskwQWRocJ20hFQA7rbohcwgNkKIbptumsnraw+KohGJrxlwXnwWGqXD4XptvfLMn5
 nzY3fcfQzM5/v7omahjVqPe5vVTKgNV2t7uAtYVKZrEN0f6+J0m3s
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Am 29.05.19 um 01:01 schrieb Florian Fainelli:
> Hi all,
>
> This patch series attempts to fix the most obvious W=3D1 DTC warnings fo=
r
> Broadcom SoCs DTS files. Stefan, if you could do the same for all
> bcm283* that would be fantastic.

we tried to fix as much as possible in the past. So there are only those
left, which i don't know how to fix it properly (and without breaking
things):

arch/arm/boot/dts/bcm283x.dtsi:54.6-651.4: Warning
(unit_address_vs_reg): /soc: node has a reg or ranges property, but no
unit name

This from the SoC specific dtsi files which add values for the ranges /
dma-ranges.

soc {
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ranges =3D <0x7e000000 0x20000000 0x=
02000000>;
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dma-ranges =3D <0x40000000 0x0000000=
0 0x20000000>;
};

arch/arm/boot/dts/bcm283x.dtsi:648.12-650.5: Warning (simple_bus_reg):
/soc/gpu: missing or empty reg/ranges property

This comes from the following simple bus child node:

vc4: gpu {
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 compatible =3D "b=
rcm,bcm2835-vc4";
};

This issue should also exists in bcm-cygnus.dtsi. From the hardware side
the GPU is part of the SoC, but maybe we should move this node out of
the SoC simple bus?

Stefan

