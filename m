Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A825C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DF6207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575459198;
	bh=/JHiz2KIdlsuSMIGuTWB++APfysh52tpv3cjf0DfXIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fPVk70FMUn4I6DZHs3+fN6d1s26Ka7kO2ustgA1mJ3xbJyAdqJjuTtjuCZCps88YZ
	 a/KauCkm34F5jHmp6JX15Fan12TFKAcfTDtUrR34ylOJIxNaJShBGDOZGoyxUCrydf
	 Ip8KuYnQMzt9weX+J4MfJ8x4Prhv8bIlzhYuwX2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfLDLdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfLDLdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:33:17 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 701C020637;
        Wed,  4 Dec 2019 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575459196;
        bh=/JHiz2KIdlsuSMIGuTWB++APfysh52tpv3cjf0DfXIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQFAdRPVtLGN6tVS4n8E+qoQTrGa7zC4pyb1tB2ytI54dTK+7rCiFuPKQV9vgRIS6
         +cCkba4E+ihxTkHZK8VVubQL5UGy5UWmdsE/KxjnAcjBjMudaENEODAkH7ZwYDj40S
         xw4GTwtiyRM/gEN/ZW6yEPpjWPwv2OueJTLTvCAc=
Date:   Wed, 4 Dec 2019 19:33:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Bobby Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx: ventana: add fxos8700 on gateworks boards
Message-ID: <20191204113307.GH3365@dragon>
References: <20191021205426.28825-1-rjones@gateworks.com>
 <CALAE=UAEFobA2SXOTJWAqexg+VNN_VTXGLGH+VwqqjKkuFwddg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAE=UAEFobA2SXOTJWAqexg+VNN_VTXGLGH+VwqqjKkuFwddg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 11:10:19AM -0800, Bobby Jones wrote:
> Hello Shawn,
> 
> I just wanted to follow up with this and see if you had a chance to
> look at this. I submitted this after responding to Marco on my initial
> submission but haven't heard anything since and didn't want it to fall
> through the cracks. It may be worth mentioning that both the bindings
> for the fxos8700 and lsm9ds1 have been accepted by iio.
> 
> In addition to this submission I have the following that I'd like to
> check in on as well:
> 
> [PATCH] ARM: dts: imx: imx6qdl-gw553x.dtsi: add lsm9ds1 iio imu/magn support
> [PATCH] ARM: dts: imx: Add GW5907
> [PATCH] ARM: dts: imx: Add GW5912
> [PATCH] ARM: dts: imx: Add GW5913
> [PATCH] ARM: dts: imx: Add GW5910
> 
> Please let me know if there's anything I can do. Thanks!

Hmm, did you copy me on those patches?  I cannot find them in my
mailbox.

Shawn
