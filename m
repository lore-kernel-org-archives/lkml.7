Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD1EC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823F6206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566469923;
	bh=WYIKxIQ7oy3ZoJ+E7cJvJ9ZZFpLwfR4vZhiDaWwVt6E=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=sR8D7iQSAtLeNTOfDBcr7aKWzw5XLw8rYF+LL5JzblWx79tH4UojGibkNzwXKOrtR
	 QOs6nbjbtnkp3ww6Y0OZgtUcPEE000Nnm206QjM8eqJ4nMwiq/stmQ3YjkP0TDi6qh
	 VdiBQ4XqULtsvHKUS8pk/S5YXpDwCBFFDFRml1kQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbfHVKcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:32:02 -0400
Received: from foss.arm.com ([217.140.110.172]:43376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfHVKcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:32:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEE8915AD;
        Thu, 22 Aug 2019 03:32:01 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 188B93F246;
        Thu, 22 Aug 2019 03:31:58 -0700 (PDT)
Subject: Re: [PATCH v2 00/20] Initial support for Marvell MMP3 SoC
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <20190822092643.593488-1-lkundrak@v3.sk>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <244fdc87-0fe5-be79-d9cd-2395d0ac3f57@kernel.org>
Date:   Thu, 22 Aug 2019 11:31:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822092643.593488-1-lkundrak@v3.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2019 10:26, Lubomir Rintel wrote:
> Hi, 
> 
> this is a second spin of a patch set that adds support for the Marvell
> MMP3 processor. MMP3 is used in OLPC XO-4 laptops, Panasonic Toughpad
> FZ-A1 tablet and Dell Wyse 3020 Tx0D thin clients. 
> 
> Compared to v1, there's a handful of fixes in response to reviews. Patch
> 02/20 is new. Details in individual patches.
>  
> Apart from the adjustments in mach-mmp/, the patch makes necessary 
> changes to the irqchip driver and adds an USB2 PHY driver. The latter 
> has a dependency on the mach-mmp/ changes, so it can't be submitted 
> separately.
>  
> The patch set has been tested to work on Wyse Tx0D and not ruin MMP2 
> support on XO-1.75. 

How do you want this series to be merged? I'm happy to take the irqchip
related patches as well as the corresponding DT change (once reviewed)
through my tree.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
