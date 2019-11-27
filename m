Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC18EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67A4204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfK0Irj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:47:39 -0500
Received: from ns.iliad.fr ([212.27.33.1]:54898 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfK0Irj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:47:39 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id D0DA9211BE;
        Wed, 27 Nov 2019 09:47:37 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id B85982119A;
        Wed, 27 Nov 2019 09:47:37 +0100 (CET)
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_AT803X_PHY from m to y
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?Q?Andr=c3=a9_Draszik?= <git@andred.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <1572848275-30941-1-git-send-email-peng.fan@nxp.com>
 <20191126145450.GB5108@optiplex>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <e39c043d-d098-283d-97b0-2a44aefec2f1@free.fr>
Date:   Wed, 27 Nov 2019 09:47:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126145450.GB5108@optiplex>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Nov 27 09:47:37 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2019 15:54, Oliver Graute wrote:

> this patch broke my imx8qm nfs setup. With the generic phy driver my
> board is booting fine. But with the AT803X_PHY=y enabled  I'm running
> into the following phy issue. So on my side it looks inverse as on
> yours. What is the best proposal to fix this?
> 
> [    5.550442] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [    5.573206] Sending DHCP requests ...... timed out!
> [   95.339702] IP-Config: Retrying forever (NFS root)...
> [   95.348873] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
> [   99.438443] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [   99.461206] Sending DHCP requests ...... timed out!

Which DTS are you using?

I bet one dollar that 6d4cd041f0af triggered a latent bug in the DTS.

Regards.
