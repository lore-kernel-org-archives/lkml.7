Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EB3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831C622CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 22:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="PDYqxTCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfHSWLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:11:54 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45104 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbfHSWLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1566252710; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqWLyowqzjwfdo+DC8TzM6xUlZuVKDTABcsocNtg1mM=;
        b=PDYqxTCZs/HBJzujcq/hKKF+Pl1vYHBLRog2cKX60BG6jYHL8xQh/cZrnk0ZtK3K697mQk
        L7zfsKW/tFF4Y5JPBV8TY2iNKRMfV5R2BNSYx9ZUrGdFNvgY4pTuX31mXUz+oPbgjp/Unt
        NkcW1Xe6IIh1ZLlgdbNooXBGRZRjChE=
Date:   Tue, 20 Aug 2019 00:11:35 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: linux-next: Tree for Aug 19 (irqchip: irq-ingenic-tcu.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Message-Id: <1566252695.2037.0@crapouillou.net>
In-Reply-To: <ebcc8c55-3e77-bd3e-fa39-fed48d129250@infradead.org>
References: <20190819191832.03f1a579@canb.auug.org.au>
        <ebcc8c55-3e77-bd3e-fa39-fed48d129250@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

The fix was merged a couple of hours ago in mips-next.

Cheers
-Paul



Le mar. 20 ao=FBt 2019 =E0 0:06, Randy Dunlap <rdunlap@infradead.org> a=20
=E9crit :
> On 8/19/19 2:18 AM, Stephen Rothwell wrote:
>>  Hi all,
>>=20
>>  Changes since 20190816:
>>=20
>=20
> on i386:
>=20
> ld: drivers/irqchip/irq-ingenic-tcu.o: in function=20
> `ingenic_tcu_intc_cascade':
> irq-ingenic-tcu.c:(.text+0xb1): undefined reference to=20
> `irq_get_domain_generic_chip'
> ld: drivers/irqchip/irq-ingenic-tcu.o: in function=20
> `ingenic_tcu_irq_init':
> irq-ingenic-tcu.c:(.init.text+0x91): undefined reference to=20
> `irq_generic_chip_ops'
> ld: irq-ingenic-tcu.c:(.init.text+0xd2): undefined reference to=20
> `__irq_alloc_domain_generic_chips'
> ld: irq-ingenic-tcu.c:(.init.text+0xfb): undefined reference to=20
> `irq_get_domain_generic_chip'
>=20
>=20
> Full randconfig file is attached.Jason Cooper <jason@lakedaemon.net>
>=20
>=20
> --
> ~Randy

=

