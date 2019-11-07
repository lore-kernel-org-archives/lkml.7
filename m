Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23390C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD6A2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbfKGM7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:59:42 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55297 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGM7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:59:42 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iShNt-0008Ok-BL; Thu, 07 Nov 2019 13:59:33 +0100
Message-ID: <1bacac547977493e50bb1fadfaf4b9ad5b4fdf0c.camel@pengutronix.de>
Subject: Re: [PATCH v5 0/3] reset: npcm: add NPCM reset driver support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Tomer Maimon <tmaimon77@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, yuenn@google.com, venture@google.com,
        benjaminfair@google.com, avifishman70@gmail.com, joel@jms.id.au
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Thu, 07 Nov 2019 13:59:32 +0100
In-Reply-To: <20191106145331.25740-1-tmaimon77@gmail.com>
References: <20191106145331.25740-1-tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

On Wed, 2019-11-06 at 16:53 +0200, Tomer Maimon wrote:
> This patch set adds reset controller support 
> for the Nuvoton NPCM Baseboard Management Controller (BMC).
> 
> Apart of controlling all NPCM BMC reset module lines the NPCM reset driver
> support NPCM BMC software reset to restarting the NPCM BMC.
> 
> Supporting NPCM USB-PHY reset as follow:
> 
> NPCM BMC USB-PHY connected to two modules USB device (UDC) and USB host.
> 
> If we will restart the USB-PHY at the UDC probe and later the 
> USB host probe will restart USB-PHY again it will disable the UDC
> and vice versa.
> 
> The solution is to reset the USB-PHY at the reset probe stage before 
> the UDC and the USB host are initializing.
> 
> NPCM reset driver tested on NPCM750 evaluation board.
> 
> Addressed comments from:.
>  - Philipp Zabel
> 
> Changes since version 4:
>  - Check for stored GCR string in the of_device_id->data to gain
>    GCR regmap access. 
>  - Adding check if the user used undefined reset pins
>    in the of_xlate function.
>  - Remove nr_resets initialization since it of_xlate replaced 
>    with the custom version.

Thanks, all three applied to reset/next with Rob's R-b.

regards
Philipp

