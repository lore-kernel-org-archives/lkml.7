Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC56C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB97206C1
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564844221;
	bh=Un3lXCixRMwp1nYc0wJmK5BTO4HJ7DqaPwgspkZjIvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Io7yH2ZUc+q+Bq3C3p48px0T96+ddThsvXTK87PYwH+7sv4g/VoJqtlxwS1PnhWO3
	 D9wb8LleKEyFHH1fcv2YwOCAz5DNaogjWMSoInQBnBtqrhc4Df7ibQcem/OVTbcVfy
	 akXqk88VEGXbLmHn09wLGWRaKUxX7Hzi/iDFdOpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfHCO4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 10:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfHCO4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 10:56:53 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69D49206C1;
        Sat,  3 Aug 2019 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564844212;
        bh=Un3lXCixRMwp1nYc0wJmK5BTO4HJ7DqaPwgspkZjIvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wYxnaqUjohc/m81AGe1GVHAGECDZu8ownqOJvpQYHKh6SRlc6T6inVZ4AIf/zyfL0
         bcWKVUXnaKrlIQbUP+rgFDnnLlZhCUa2c6aVvxU2SFK/4U4DUL2mBtRZoSpGR6beyv
         ZIztYSYaVALiADVYxnFLZgjVoot8Lxl1kO8aV0eI=
Date:   Sat, 3 Aug 2019 16:56:45 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, ccaione@baylibre.com, abel.vesa@nxp.com,
        baruch@tkos.co.il, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: Unbypass audio_pll1
Message-ID: <20190803145644.GO8870@X250.getinternet.no>
References: <20190728140817.12509-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728140817.12509-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 05:08:17PM +0300, Daniel Baluta wrote:
> Making audio_pll1 parent of audio_pll1_bypass, will allow
> setting rates multiple of 8000 for children.
> 
> After unbypass clk hierarchy looks like this:
>  * osc_25m
>    * audio_pll1
>      * audio_pll1_bypass
>        * audio_pll1_out
>          * sai2
>            * sai2_root_clk
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
