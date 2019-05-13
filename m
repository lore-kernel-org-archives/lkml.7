Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3EBC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0313621537
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Gr6lUiLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfEMPfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:35:39 -0400
Received: from node.akkea.ca ([192.155.83.177]:38478 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbfEMPfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:35:38 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 38E244E204B; Mon, 13 May 2019 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557761738; bh=IA5QAKvFGl/GldPEQRgRzpBt5N4v+SgzFVD8uRxNccQ=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=Gr6lUiLUBt9Z2GOjRtJI5PlFgszE/UujExaNo5g6icub4nEHuS/ux+ZfMt6SYEMS8
         ry99GHzRa1x4enT/IOYkAM7FqhxRIV8OWYf6u2+BpanqGQoQPJLboa8dRxZhC7VJQ/
         KEpFFo4MgOEHr90KjPnImdi/poHDRSw4y/lXWaMQ=
To:     Joe Perches <joe@perches.com>
Subject: Re: [PATCH v9 1/3] arm64: dts: fsl: librem5: Add a device tree for  the Librem5 devkit
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 May 2019 08:35:38 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org
In-Reply-To: <0f355f524122cb4dd6388431495a9d182e3ed9d6.camel@perches.com>
References: <20190513145539.28174-1-angus@akkea.ca>
 <20190513145539.28174-2-angus@akkea.ca>
 <0f355f524122cb4dd6388431495a9d182e3ed9d6.camel@perches.com>
Message-ID: <11c9a715ee0599e50359eb5ad5bd093e@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 2019-05-13 08:11, Joe Perches wrote:
> On Mon, 2019-05-13 at 07:55 -0700, Angus Ainslie (Purism) wrote:
>> This is for the development kit board for the Librem 5. The current 
>> level
>> of support yields a working console and is able to boot userspace from
>> the network or eMMC.
> []
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts 
>> b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> new file mode 100644
> 
> Perhaps add an entry in the MAINTAINERS file for this
> .dts file similar to other freescale boards?

The MAINTAINERS files has this entry

ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
M:  Shawn Guo <shawnguo@kernel.org>
M:  Sascha Hauer <s.hauer@pengutronix.de>
R:  Pengutronix Kernel Team <kernel@pengutronix.de>
R:  Fabio Estevam <festevam@gmail.com>
R:  NXP Linux Team <linux-imx@nxp.com>
L:  linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
S:  Maintained
T:  git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
N:  imx
N:  mxs
X:  drivers/media/i2c/


Shouldn't the "N: imx" cover this board already ?

Maybe I misunderstood, are you suggesting I add an new entry for "F: 
arch/arm64/boot/dts/freescale/*" ?

Thanks
Angus
