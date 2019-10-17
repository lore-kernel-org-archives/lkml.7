Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6376ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60F62089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439326AbfJQJEb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:04:31 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:49693 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439193AbfJQJEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:04:31 -0400
Received: from windsurf (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 68FB3100007;
        Thu, 17 Oct 2019 09:04:28 +0000 (UTC)
Date:   Thu, 17 Oct 2019 11:04:27 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?S8Op?= =?UTF-8?B?dmlu?= RAYMOND 
        <k.raymond@overkiz.com>, Mickael GARDET <m.gardet@overkiz.com>
Subject: Re: [PATCH 2/2] ARM: dts: at91: add a common kizbox2 dtsi file
Message-ID: <20191017110427.66bccdfb@windsurf>
In-Reply-To: <20191017085405.12599-3-kamel.bouhara@bootlin.com>
References: <20191017085405.12599-1-kamel.bouhara@bootlin.com>
        <20191017085405.12599-3-kamel.bouhara@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kamel,

On Thu, 17 Oct 2019 10:54:05 +0200
Kamel Bouhara <kamel.bouhara@bootlin.com> wrote:

> There are three different boards available depending on the PCB
> (3 antennas support and several revison). Add a dtsi file to share
> common binding between all kizbox2 boards.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Kévin RAYMOND <k.raymond@overkiz.com>
> Signed-off-by: Mickael GARDET <m.gardet@overkiz.com>
> ---
>  arch/arm/boot/dts/Makefile                 |   6 +-
>  arch/arm/boot/dts/at91-kizbox.dts          | 173 +++++++-------

The changes to this file (change to use phandles) seem unrelated to the
current patch, unless I'm missing something.

>  arch/arm/boot/dts/at91-kizbox2-0.dts       |  17 ++
>  arch/arm/boot/dts/at91-kizbox2-1.dts       |  22 ++
>  arch/arm/boot/dts/at91-kizbox2-2.dts       |  26 +++
>  arch/arm/boot/dts/at91-kizbox2-3.dts       |  30 +++
>  arch/arm/boot/dts/at91-kizbox2-rev2.dts    |  34 +++
>  arch/arm/boot/dts/at91-kizbox2.dts         | 244 -------------------
>  arch/arm/boot/dts/at91-kizbox2_common.dtsi | 258 +++++++++++++++++++++

"-" seems to be a much more common separator for DT names, including in
this file, so what about at91-kizbox2-common.dtsi ?

> +// WMBUS (inverted with IO in the latest schematic)

I am not sure C++ comments are common in Device Tree files.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
