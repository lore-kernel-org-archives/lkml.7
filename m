Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6729BCA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 00:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEDF222CD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 00:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572828699;
	bh=0cPXrS85ZFNq0IkzMuelys/+Yk/AanMHiImMkP3vTHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J3K43KmGab5poeVETrmpZxxhU/hC3uvEwFxuXL7aCrW/0ryVBU+uu4bMEMKGDWpBi
	 giXq8QgX+DetSmljz0m9QkZjsWyYquVSg0KdtXuX9SrNM5D4AOehWzySoirt7kBvZ8
	 hGdrsVtjB88FqB5Qm+SZXNYMx3c0PRGyOXrN6oDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfKDAvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 19:51:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:52524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbfKDAvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 19:51:37 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA170222CA;
        Mon,  4 Nov 2019 00:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572828697;
        bh=0cPXrS85ZFNq0IkzMuelys/+Yk/AanMHiImMkP3vTHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3fcrd5RjNk9WJIl1Kea4MTeMZiT4hoj6uZT561YIM3GlTk4L7qfgmg3wuE+tPP+q
         X8co1KYv/PjnTvUgn2VaSwmcQpANSmp+qPg4UXaVci9e4A77T2sS9gEKKTr91FlY/k
         +ifsMR1p3pkJ/2yfSDMz6OVuegJIP/F96NwuS/c4=
Date:   Mon, 4 Nov 2019 08:51:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for
 fec1
Message-ID: <20191104005108.GB24620@dragon>
References: <1571652977-4754-1-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB70239911C3C71E0503808F85EE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB70239911C3C71E0503808F85EE630@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 06:59:51PM +0000, Leonard Crestez wrote:
> On 21.10.2019 13:19, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > We should not rely on bootloader to configure the phy reset.
> > So introduce phy-reset-gpios property to let Linux handle phy reset
> > itself.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> 
> This broke NFS boot for me in next-20191031: board now hangs on DHCP.

I dropped both patches for now.

Shawn

> 
> It can be fixed by reverting this DT patch or by setting 
> CONFIG_AT803X_PHY to y instead of m.
> 
> Needing a phy module is not a bug but everybody will need to either 
> adjust .config or build modules into an initramfs somehow.
