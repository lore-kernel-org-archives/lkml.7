Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D11C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9138206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 01:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577064918;
	bh=jQLYVwMMyYcEWqK6/IFzR9AduPaoKnyANcTsHakSj9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cjRYxCXdnBToP3yg9aWqVUp/YVcFK8Obn7ZMztJL1gLQDJAWbGtrk7gjTzbROSBxn
	 viJe0miMyX4eDAxSIVfx0HFzi5BMQRfwqiJ844ZlvSzluekoATEZBCcpx72WW1XZ/p
	 NO0xicvYbsWy8nDILXJ9xUPSrrUENHFr4mEOZiGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLWBfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 20:35:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfLWBfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:35:17 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58163206B7;
        Mon, 23 Dec 2019 01:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577064916;
        bh=jQLYVwMMyYcEWqK6/IFzR9AduPaoKnyANcTsHakSj9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOfCSlmgZbNgN0s0MwtUZUTBnVJDpD7si/VSXf+mKY6hxK2+7U9JaqoqJbLUbhkJ0
         J4XHl1AMtvjKcSBxuc41z4RercNfc3q3Q3X6x1hokywtQFTTMzXw3SVFP120X4sS7u
         nQcHplv5uA5fEpq6tU4WKWRchoYZwSZFVSU8G8Vw=
Date:   Mon, 23 Dec 2019 09:34:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: imx: Add GW5907 board support
Message-ID: <20191223013451.GB11523@dragon>
References: <20191205220825.22915-1-rjones@gateworks.com>
 <20191212195212.30433-1-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212195212.30433-1-rjones@gateworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:52:12AM -0800, Robert Jones wrote:
> The Gateworks GW5907 is an IMX6 SoC based single board computer with:
>  - IMX6Q or IMX6DL
>  - 32bit DDR3 DRAM
>  - FEC GbE Phy
>  - bi-color front-panel LED
>  - 256MB NAND boot device
>  - Gateworks System Controller (hwmon, pushbutton controller, EEPROM)
>  - Digital IO expander (pca9555)
>  - Joystick 12bit adc (ads1015)
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Robert Jones <rjones@gateworks.com>

It doesn't apply to my imx/dt branch.  Please rebase and resend.  Also
could you make a patch series to include this one and the other 3 adding
GW5910, GW5912 and GW5913 support?

Shawn
