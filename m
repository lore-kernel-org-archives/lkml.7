Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74498C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D416214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfLLRE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:04:57 -0500
Received: from muru.com ([72.249.23.125]:46416 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729927AbfLLRE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:04:57 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CF91980C0;
        Thu, 12 Dec 2019 17:05:34 +0000 (UTC)
Date:   Thu, 12 Dec 2019 09:04:52 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Caleb Robey <c-robey@ti.com>, linux-omap@vger.kernel.org,
        Jason Kridner <jkridner@gmail.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        "Andrew F . Davis" <afd@ti.com>, Tom Rini <trini@konsulko.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: am5729: beaglebone-ai: adding device tree
Message-ID: <20191212170452.GV35479@atomide.com>
References: <20191120220559.18914-1-c-robey@ti.com>
 <41c73bc1-99ae-6797-5bb7-7acc0f6518c0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41c73bc1-99ae-6797-5bb7-7acc0f6518c0@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [191121 11:08]:
> 
> 
> On 21/11/2019 00:05, Caleb Robey wrote:
> > From: Jason Kridner <jdk@ti.com>
> > 
> > BeagleBoard.org BeagleBone AI is an open source hardware single
> > board computer based on the Texas Instruments AM5729 SoC featuring
> > dual-core 1.5GHz Arm Cortex-A15 processor, dual-core C66 digital
> > signal processor (DSP), quad-core embedded vision engine (EVE),
> > Arm Cortex-M4 processors, dual programmable realtime unit
> > industrial control subsystems and more. The board features 1GB
> > DDR3L, USB3.0 Type-C, USB HS Type-A, microHDMI, 16GB eMMC flash,
> > 1G Ethernet, 802.11ac 2/5GHz, Bluetooth, and BeagleBone expansion
> > headers.
> > 
> > For more information, refer to:
> > https://beaglebone.ai
> > 
> > This patch introduces the BeagleBone AI device tree.
> > 
> > Note that the device use the "ti,tpd12s016" component which is
> > software compatible with "ti,tpd12s015". Thus we only use the
> > latter driver.
> 
> Ah. thanks. I see my comments resolved here.
> no more comments to net part from my side.

Just FYI, Jason had one pending comment on the earlier version
about the compatible property to use.

So I'm assuming there will be a new version posted, tagging
this one as read.

Regards,

Tony
