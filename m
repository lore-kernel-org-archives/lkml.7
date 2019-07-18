Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5CBC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B7821783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563437061;
	bh=E0bLEAP3B1LCOK+JmfNMki+fkUB1oBDmiJFqCk7d3z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Avv5JzzLFW+2JVvqez7fNr6yjxkmQCVz9KDTntAV3oDregRHlVKnRSojVkl+qe6GL
	 kwt/YWAvb4IvYRlPmttnwEJvoiTHPiycl34ZhoDJ80pG/LiU8N3jgKdz0lAyOGFOgD
	 x36vVu7NFNvAs8OQWBF9yunlyKjSYRBhKuPUm0YI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389325AbfGRIEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbfGRIEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:04:20 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84F5D208C0;
        Thu, 18 Jul 2019 08:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563437059;
        bh=E0bLEAP3B1LCOK+JmfNMki+fkUB1oBDmiJFqCk7d3z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USpNpihtlTs5cwv+eEh3e1xNwu3qmdbLx7FNEBHVdjr6KnddtNezQJ6nvWZGKxlvR
         /fJNvvgg3LFmupkj2VGQMcbCRVvN+OQW4Rz3cU+jVJMKWuQeIVRklIxTUVlxi/63Zm
         4KhuoE3Zvl85Z7YSE55/hIQ39qAv/rP78deAwS4c=
Date:   Thu, 18 Jul 2019 16:03:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        viresh.kumar@linaro.org, ping.bai@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, abel.vesa@nxp.com,
        andrew.smirnov@gmail.com, ccaione@baylibre.com, angus@akkea.ca,
        agx@sigxcpu.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mm: Correct OPP table according
 to latest datasheet
Message-ID: <20190718080356.GL3738@dragon>
References: <20190629102157.8026-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629102157.8026-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 06:21:56PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> According to latest datasheet (Rev.0.2, 04/2019) from below links,
> 1.8GHz is ONLY available for consumer part, so the market segment
> bits for 1.8GHz opp should ONLY available for consumer part accordingly.
> 
> https://www.nxp.com/docs/en/data-sheet/IMX8MMIEC.pdf
> https://www.nxp.com/docs/en/data-sheet/IMX8MMCEC.pdf
> 
> Fixes: f403a26c865b (arm64: dts: imx8mm: Add cpu speed grading and all OPPs)
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
