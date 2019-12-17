Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44034C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC79206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="mKw9XDiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfLQVEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:04:55 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48736 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbfLQVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576616688; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QOCv7eVNMACKKz7lfH6wYRKxNtDZzpuNrspVQ6O0QQ=;
        b=mKw9XDiMoPdJp+qPGz4pc9mh/sJyqsiCv9+SX2ZpGxifxy5pYgdgWaT7Ytb2a2uuLWHO0R
        V+97nxHzSFtE9owWbIqk1jz2Z5P5ebHzuUdV5l2WGcIko4h2akD2/lOzxzllWu6bxabJvx
        DYI899pw4n6b6p9UCOVKXedJCaHaC+I=
Date:   Tue, 17 Dec 2019 22:04:38 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 2/7] usb: musb: dma: Add support for shared IRQ
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Message-Id: <1576616678.3.0@crapouillou.net>
In-Reply-To: <20191217144206.GM16429@iaqt7>
References: <20191210171110.62141-1-paul@crapouillou.net>
        <20191210171110.62141-2-paul@crapouillou.net> <20191211185224.GD16429@iaqt7>
        <20191217144206.GM16429@iaqt7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,


Le mar., d=E9c. 17, 2019 at 08:42, Bin Liu <b-liu@ti.com> a =E9crit :
> Hi Paul,
>=20
> On Wed, Dec 11, 2019 at 12:52:24PM -0600, Bin Liu wrote:
>>  On Tue, Dec 10, 2019 at 06:11:05PM +0100, Paul Cercueil wrote:
>>  > The implementation of the Inventra IP in some of the Ingenic=20
>> JZ47xx SoCs
>>  > does not use a separate IRQ line for DMA transfers.
>>  >
>>  > Allow these SoCs to be supported by adding a flag=20
>> 'dma_share_usb_irq'
>>  > in the struct musb. If set, no extra IRQ line is required, and=20
>> the musb
>>  > glue will need to call the API function=20
>> musbhs_dma_controller_irq()
>>  > within its interrupt handler.
>>  >
>>  > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > Tested-by: Artur Rojek <contact@artur-rojek.eu>
>>  > ---
>>=20
>>  Queued for usb-next. Thanks.
>=20
> I removed this and the next patch [3/7] in this series from my queue.
> Sorry. Ming Guo has posted a series "Add MediaTek MUSB Controller
> Driver" which has done the similar implementation [1] but without=20
> adding
> the flag in struct musb. Can you please check if you can use Ming's
> implementation instead? The patch of his musb glue driver which uses=20
> the
> implementation is [2], just for your reference.

Sure. Were these patches merged? What tree do they apply to? They don't=20
apply cleanly on -rc2.

-Paul


>=20
> [1] https://marc.info/?l=3Dlinux-usb&m=3D157602930627195&w=3D2
> [2] https://marc.info/?l=3Dlinux-usb&m=3D157602932427210&w=3D2
>=20
> Thanks,
> -Bin.

=

