Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE49BC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838132183E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554951654;
	bh=zBQrX9nTHca4CgA7sweFUdR5ylhwlTvu1yWsk1pswvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2wVTu5ohtWuC2eVjn4trEGi5QJ00bDi2j7MfeTsx1SXYQ3aqDEh0RIytK5hWezNek
	 hcBdmJewkbH+5go1hMrRZjFJqXFUB6hCxrlG3OMiU1JgSSIIkJBWVQ2UfGPCwfuxCS
	 g+qcUwSbcsfBPM0Qa1rs0LBRWTtvrIwyudYaBK34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDKDAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbfDKDAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:00:53 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EA9020818;
        Thu, 11 Apr 2019 03:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554951652;
        bh=zBQrX9nTHca4CgA7sweFUdR5ylhwlTvu1yWsk1pswvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1yb8zwhbrulbsDYfFxouzkl1Tdp8ImavcjKeBK/A7HeYfTq2KqrcXkmxFYMLP21e7
         ui9GwgCrWP523/hNkEZqYTDwIxsYVQn8hgmg/za8fuIQUqVWz96U7vYnkW6LJVYU7+
         sY117zk5R8gh1aimgBLP8wfxakTRDSSFmkSJJYfw=
Date:   Thu, 11 Apr 2019 11:00:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Teo Hall <teo.hall@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8qxp: Add lpuart1/lpuart2/lpuart3 nodes
Message-ID: <20190411030034.GN26817@dragon>
References: <20190330170725.24360-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330170725.24360-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 05:07:44PM +0000, Daniel Baluta wrote:
> lpuart nodes are part of the ADMA subsystem. See Audio DMA
> memory map in iMX8 QXP RM [1]
> 
> This patch is based on the dtsi file initially submitted by
> Teo Hall in i.MX NXP internal tree.
> 
> [1] https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
> 
> Signed-off-by: Teo Hall <teo.hall@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
