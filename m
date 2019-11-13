Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A34C17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A8B20818
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKMKJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:09:42 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:47017 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfKMKJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:09:41 -0500
Received: from windsurf (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2DC7010000F;
        Wed, 13 Nov 2019 10:09:38 +0000 (UTC)
Date:   Wed, 13 Nov 2019 11:09:38 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/13] ARM: at91: Kconfig: add sam9x60 pll config flag
Message-ID: <20191113110938.5e7ee5cd@windsurf>
In-Reply-To: <1573635069-30883-2-git-send-email-claudiu.beznea@microchip.com>
References: <1573635069-30883-1-git-send-email-claudiu.beznea@microchip.com>
        <1573635069-30883-2-git-send-email-claudiu.beznea@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 10:50:57 +0200
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Add SAM9X60's pll config flag.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

You should explain why this flag is needed, because as it is, this flag
is here, then selected in your PATCH 2/13, but not used anywhere.

Could you clarify this ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
