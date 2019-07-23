Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE67C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6618B223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563868810;
	bh=E5hVssuZ6CZ0pvbWaiPrRrdaj4qYQ6lYexAw+U+Hh3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h+6uptfIpGVK8ALXqeEjJaD1GNB32uIYuYLrKKaNyBiXpfsWOgkrRlgzLETSTlPQJ
	 bk/rkYTI/1Gysrf/LOFD3o9ADkAwLKnRFoEObd91Uk4QsiTY3FELCkxS839voNkjH5
	 UNfJkoriF+qOHjnZuXAQU3n9Ht38KmskIC1o+22o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGWIAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfGWIAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:00:08 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 927C82239F;
        Tue, 23 Jul 2019 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563868808;
        bh=E5hVssuZ6CZ0pvbWaiPrRrdaj4qYQ6lYexAw+U+Hh3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMM8HxVuSR3M8pB/0rGd6k6eRPUBVkSqyXXiy61KPH3sCjw8KUaUaIswX9dwgho/t
         KVfifc7d6BIWadcvqeZLLmgxBcAEqezt1eZmUQAsAGaWulswknuy+7UMslfAzKwf20
         gGl7Yit5O5oEPN/nrG9RfHCyU2hxnlGw2crJ6f5Q=
Date:   Tue, 23 Jul 2019 15:59:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, paul.olaru@nxp.com, aisheng.dong@nxp.com,
        leonard.crestez@nxp.com, anson.huang@nxp.com, peng.fan@nxp.com,
        Frank.Li@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 1/3] clk: imx8: Add DSP related clocks
Message-ID: <20190723075933.GN15632@dragon>
References: <20190718151346.3523-1-daniel.baluta@nxp.com>
 <20190718151346.3523-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718151346.3523-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 06:13:44PM +0300, Daniel Baluta wrote:
> i.MX8QXP contains Hifi4 DSP. There are four clocks
> associated with DSP:
>   * dsp_lpcg_core_clk
>   * dsp_lpcg_ipg_clk
>   * dsp_lpcg_adb_aclk
>   * ocram_lpcg_ipg_clk
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

I already picked this one up, so you do not need to include it in the
series any more.

Shawn
