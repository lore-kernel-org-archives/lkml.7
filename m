Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA9C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7939B20882
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557714190;
	bh=wPmdNDDmDeMcDq4UPXlESBwTLYnhR866lL7F4b+Io/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L0tiLevuz9mxpzLsMKdJ8K3L+o493TsXiQmySYyyYGYminbp63tdHijQgNr+XzDxE
	 F/pybbnpIXp4NLb3WM7CzYTpKdeRIA+iGZ1qVBgyHoJ2aK0f9a8Iv5IzaTHcUuZRO0
	 imgdHI9gX04Kqg0/o75W8MBPjp0Yp9x04PmZLGYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfEMCXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 22:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfEMCXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 22:23:09 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DA9C20879;
        Mon, 13 May 2019 02:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557714188;
        bh=wPmdNDDmDeMcDq4UPXlESBwTLYnhR866lL7F4b+Io/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qD9TjAfynEKJk+HMyKNd8JEtD0nblsMPYCkbtrN6NLbGdmMwy3lmyvC5ks03yHmle
         BwMreLXlB2oBWd0b8AIjrr0n+WEAq5cjDJ4NF0YtPB+V56zA9D2P3OAwd2eYHLllSB
         lfQ78Z0oyCpTXmVVSAqTAPlLYUBJ8EG7k+F+blvg=
Date:   Mon, 13 May 2019 10:22:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mq: Add a node for irqsteer
Message-ID: <20190513022235.GQ15856@dragon>
References: <72b64db0a3ae682d1c6f435fecf7876de2f57bc3.1556644355.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72b64db0a3ae682d1c6f435fecf7876de2f57bc3.1556644355.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 07:15:55PM +0200, Guido Günther wrote:
> Add a node for the irqsteer interrupt controller found on the iMX8MQ
> SoC.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
