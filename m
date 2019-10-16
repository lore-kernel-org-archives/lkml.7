Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFB2ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F3A218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391452AbfJPIIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:08:05 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34287 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfJPIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:08:04 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 770F6C000C;
        Wed, 16 Oct 2019 08:08:02 +0000 (UTC)
Date:   Wed, 16 Oct 2019 10:08:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add new Overkiz Kizbox3 support
Message-ID: <20191016080802.GY3125@piout.net>
References: <20191011125022.16329-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011125022.16329-1-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2019 14:50:19+0200, Kamel Bouhara wrote:
> Add support for the Kizbox3 Overkiz SAS boards.
> Those boards are based on the Atmel SAMA5D27 SoC.
> 
> Kamel Bouhara (3):
>   dt-bindings: Add vendor prefix for Overkiz SAS
>   dt-bindings: arm: at91: Document Kizbox3 HS board binding
>   ARM: at91: add Overkiz KIZBOX3 board
> 
>  .../devicetree/bindings/arm/atmel-at91.yaml   |   7 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/at91-kizbox3-hs.dts         | 309 +++++++++++++
>  arch/arm/boot/dts/at91-kizbox3_common.dtsi    | 412 ++++++++++++++++++
>  5 files changed, 731 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-kizbox3-hs.dts
>  create mode 100644 arch/arm/boot/dts/at91-kizbox3_common.dtsi
> 

All applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
