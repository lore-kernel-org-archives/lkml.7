Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EC4C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900B1206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="eZtyIf2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLTR1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:27:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:34718 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfLTR1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576862819; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rrfULylWxJ5AKndB/E0V/BbDNAHOuII4vx/5CnImQ8=;
        b=eZtyIf2XJWyLMt2gN+k9D9nYNHOvcyKQp/EVPXVKNiZW/Agxkuyfc8XC7FZ58F3iVPc/xp
        gtwd2sCcWpH63otDi4vUgTpUIKcI6NLAMkyi2qbuti3JqIiXaoEZPqbclLnJ1ggJOsVzsR
        TnyQf+2y0Ulz9YeQJMtTF2g/e9khIFc=
Date:   Fri, 20 Dec 2019 18:26:54 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [BUG] CI20: interrupt-controller@10001000 didn't like hwirq-0x0 
 to VIRQ8 mapping (rc=-19)
To:     Marc Zyngier <maz@kernel.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        MIPS Creator CI20 Development 
        <mips-creator-ci20-dev@googlegroups.com>,
        Zhou Yanjie <zhouyanjie@zoho.com>
Message-Id: <1576862814.3.2@crapouillou.net>
In-Reply-To: <4ea8fd0952b940b37a174fded9b5ebda@www.loen.fr>
References: <8BA39E30-53CB-47DB-8890-465ACB760402@goldelico.com>
        <1576861276.3.1@crapouillou.net>
        <4ea8fd0952b940b37a174fded9b5ebda@www.loen.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

I wasn't aware of the bug, that's why there is no tag.
I can send a V2 with a fix tag (and Cc linux-stable) if Nikolaus=20
reports it working.

-Paul


Le ven., d=E9c. 20, 2019 at 17:09, Marc Zyngier <maz@kernel.org> a=20
=E9crit :
> On 2019-12-20 17:01, Paul Cercueil wrote:
>> Hi Nikolaus,
>>=20
>> Try with this: https://lkml.org/lkml/2019/11/22/1831
>>=20
>> And don't hesitate to add your Tested-by :)
>=20
> Is that an actual fix? It wasn't tagged as such, which is why
> I didn't send it right away... It'd  be good to find out.
>=20
> Thanks,
>=20
>         M.
> --
> Jazz is not dead. It just smells funny...

=

