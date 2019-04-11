Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96913C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6355D217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554961661;
	bh=tH7i+4uv6nWXJwM52omNbaq1oNTjJ6urtpiAEUXxYx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l+VPxcVwLlHmxGhyJTunZG7oNPrF4VScee5mNRP5CFMBTUZBqsEePye3DDz2BwCg5
	 6dGNZYdEUejZz5i31gZfrVyAVJecgmsKqmpTZFSX/rw8LSYh+wQCVD3Ct/MnvpFO5S
	 WMTwqhxuYAupirE6J8cCSP7ImzlMKu8MPQomhfNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDKFrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfDKFrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:47:39 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA9F20850;
        Thu, 11 Apr 2019 05:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554961659;
        bh=tH7i+4uv6nWXJwM52omNbaq1oNTjJ6urtpiAEUXxYx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiUUDQkPjilENM46KtPa7h7hvKF49cGe+1RY2kT1ESDQmlEHTLBcPHjKr3smX5v8u
         is/r4A65DGSWAAMjlz+W9wjd4iESyyT3D6h4t9rP+pbQN+1ByzvmW+oBClN5FkDMLE
         7uZAW2AMSSBmWrpVnQRFCFIK8AIto/VKWeSQiC4A=
Date:   Thu, 11 Apr 2019 13:47:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, adam.ford@logicpd.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ARM: dts: imx6q-logicpd: Shutdown LCD regulator
 during suspend
Message-ID: <20190411054724.GU26817@dragon>
References: <20190402192547.4538-1-aford173@gmail.com>
 <20190402192547.4538-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402192547.4538-2-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:25:46PM -0500, Adam Ford wrote:
> The LCD power sequencer is very finicky.  The backlight cannot
> be driven until after the sequencer is done.  Until now, the
> regulators were marked with 'regulator-always-on' to make sure
> it came up before the backlight.  This patch allows the LCD
> regulators to power down and prevent the backlight from being
> used again until the sequencer is ready.  This reduces
> standby power consumption by ~100mW.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
