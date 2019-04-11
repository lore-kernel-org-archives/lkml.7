Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E314C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E08521841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554968083;
	bh=bSprz5PlLcdDdW1vrGKjZixQhlog93geXRE8o9xic68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QNKKr6bH7TePR/r0uqJ5B8bYrDv66b16LKYSoTh6CJz/liGNcYv27GVIyJ0gbRiTz
	 /MWg0cWT0vEqy8pJuPYO3v3HnXQ95qvg65VNHEkweE5ubgEqZs+/EncuDhLYLDjz6/
	 NObhD2NJ/6/eHhDOz/ieWHYDwOOwaxvo2kZ8te1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDKHem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKHel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:34:41 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E011B20873;
        Thu, 11 Apr 2019 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554968081;
        bh=bSprz5PlLcdDdW1vrGKjZixQhlog93geXRE8o9xic68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIAFUEF2++9SYhXSMGD1rVh0/5+wpVcO/47UrDvN7Jmx9IDIvqFmkOzDxzdtLpD3j
         ffe3Ax3Rm88n89ExVt53ZNrmTwZuLGZc+1T9QfQfeP6xKZSQspKJPl9+NVjx3DyYzb
         WofHOnAvdT0JRqKvWkc9dIhBjc09uhVM9anSiBDw=
Date:   Thu, 11 Apr 2019 15:34:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V7 3/4] arm64: dts: freescale: imx8qxp: enable scu
 general irq channel
Message-ID: <20190411073420.GD3050@dragon>
References: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
 <1554785675-8090-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554785675-8090-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 05:00:01AM +0000, Anson Huang wrote:
> On i.MX8QXP, SCU uses MU1 general interrupt channel #3 to notify
> user for IRQs of RTC alarm, thermal alarm and WDOG etc., mailbox
> RX doorbell mode is used for this function, this patch adds
> support for it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Prefix 'arm64: dts: imx8qxp:' would be good enough, and no need for
'freescale' in there.

I fixed it up and applied the patch.

Shawn
