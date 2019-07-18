Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61E8C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE7721783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563437721;
	bh=NXP1dxMRStA2YoZIugG0Hfaixlo5PPncW8E/6st36ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j8o52kzloW8jWpjuZeCmFzB7Ijo/VQ2a5VuCwpW1rX+1E+HyhBZSqI/5kWBStB8uq
	 qh6k5EKgKZH5EtHXkCJ2RnyX1TdWmYLonjo65uogWc5d+Fq4ClwoLlhPmsmLX3+cXS
	 ohDZjC+tIQY58Aq9uQQu/03+Me/fUa5VGVScS5jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389337AbfGRIPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbfGRIPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:15:20 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 255832173B;
        Thu, 18 Jul 2019 08:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563437719;
        bh=NXP1dxMRStA2YoZIugG0Hfaixlo5PPncW8E/6st36ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFFbhUW1Vk4qL91O8zs/wnRq17O2v+nBsHGqgNG1fQWGrH76f7mvP2R8Fzq8e0jws
         nryRGuJnwg0srh9I6wgqTg54lCEYY9fNeXVts1t/ZXEfRX1qrFbdz0HcMW2DavFY88
         Y686nLMjxJanA3xR7TH7pP7OBl0GBuEQrV8JKmms=
Date:   Thu, 18 Jul 2019 16:14:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, ping.bai@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, angus@akkea.ca, ccaione@baylibre.com,
        agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: Add gpio-ranges property
Message-ID: <20190718081456.GN3738@dragon>
References: <20190702014400.33554-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702014400.33554-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 09:43:59AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add "gpio-ranges" property to establish connections between GPIOs
> and PINs on i.MX8MQ pinctrl driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
