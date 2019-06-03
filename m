Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329EFC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1758254C3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559564907;
	bh=Q7XTglqgkL4y/gFcouih5iV15wbgH5eaZ/ov+vzMl+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qXyzHGLCf8xk2cvOFEwxJ4l/09CX2f/2zFA+33S6ukDktqEhj1XlGT3Vl4G123exl
	 jUb+I5x9ksi/dubXIqh3rzhwBkSO+NQ9JWR4xLC10InOhcY4nn8IGOj1gygezhVVMA
	 aF20AVA2elaYflJnTA1FMwSxWR6lDOLAIiYHtx5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfFCM20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfFCM2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:28:25 -0400
Received: from dragon (li1232-89.members.linode.com [45.79.133.89])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48F1253BF;
        Mon,  3 Jun 2019 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559564905;
        bh=Q7XTglqgkL4y/gFcouih5iV15wbgH5eaZ/ov+vzMl+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZ4SyD/01O7BEZ+1kG1AHPt0HVsLYRnYTcAHBgCkaKhzTeh9HkZz22NTrnr1Wunfa
         LZjmkibRfjILv1ukV4VUdcrWM/bIkhLQsdZVNvll5eOqP3Ywzq0N19NaF7ysQ7xn3v
         Ry5+9bd2YYqkyOI6aRlZppg415DeBwQPMg51RrKs=
Date:   Mon, 3 Jun 2019 20:28:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND] arm64: defconfig: Enable CONFIG_QORIQ_THERMAL
Message-ID: <20190603122810.GA16651@dragon>
References: <1558658123-8797-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558658123-8797-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:40:37AM +0000, Anson Huang wrote:
> i.MX8MQ needs CONFIG_QORIQ_THERMAL for thermal support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
