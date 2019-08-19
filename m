Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08510C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4392086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566220185;
	bh=WNIq2PRwEGgUzdRSpB8DEXjutvanCvj07VyhRwkg7Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F2Pwo1+s8hfmr3zZFd3C4OJE/aqjMuumI38FwqNzqKfOfEZ5VDOLqO8xtACAa8RtW
	 nORsCLM9c+hN9b0HLjhcxRn4K8z06fTgDq3+zPe3tgDO2CpLKSlpMSkQxS8s6S2Cw0
	 kjj5ksorshJYr2LgZnDLmkm7srGQH901CWtv8wog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfHSNJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfHSNJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:09:44 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C61C720843;
        Mon, 19 Aug 2019 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566220184;
        bh=WNIq2PRwEGgUzdRSpB8DEXjutvanCvj07VyhRwkg7Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOpeK4QjF8DvEY5sIvrWacbakhKKqR+RjgEEc+YDrgNbC08Ac7X8ZfGQMgH5ZhunU
         Ys7VKIS7cPP8KT3ZozILOUDZaMyoHUOwcYCBwdpj+nZ2eP7B5TQkcu68Ht5wuaWN0W
         /rhK5za9uAgSwcIv6B1x4YWpd2uw34gluM2TV32A=
Date:   Mon, 19 Aug 2019 15:09:30 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mn: Add gpio-ranges property
Message-ID: <20190819130929.GG5999@X250>
References: <1565837850-1373-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565837850-1373-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:57:30PM -0400, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add "gpio-ranges" property to establish connections between GPIOs
> and PINs on i.MX8MN pinctrl driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
