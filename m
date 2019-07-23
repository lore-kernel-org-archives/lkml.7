Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF90C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551E72239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 05:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563860427;
	bh=+j2AOuISZmiPQxHemG/b+OJjdIwmlnQX7SnFfbIvn7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jQyyk/vW1tfLywI7VUao/aPwfbNoSDx/9sdvrGTSbWFlqszBTC9IhS4HOgP87ckQc
	 Bf56Iw52ZHEgzfWT6DP+ptGSYSPaQ3aTAH6V2fp0ZewXXhjnxUwlt+6rDXd7rSD/fb
	 O69mNwNgFCcPe3/eQlB758QZqoowPGJ+xeVEIJGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfGWFk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 01:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729349AbfGWFkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 01:40:25 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2600C2229A;
        Tue, 23 Jul 2019 05:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563860424;
        bh=+j2AOuISZmiPQxHemG/b+OJjdIwmlnQX7SnFfbIvn7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1sE6Dd8kroxZni3hrIzECi1WLHUUBaNidsUd5f4AswbX4xlfhFmlZZwkRB0Vg+ir7
         /3ScQzQIzZFHSIJMaNljs5QPRp3XJz6hxwC1LPYwhCBUh+1yqsV2gInf1+c3lvGqik
         1dPCPFeZFHUShI9MvWE++oBb5tQeSRFU0+gxL88Q=
Date:   Tue, 23 Jul 2019 13:39:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     s.hauer@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, martyn.welch@collabora.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/10] Add further support for PHYTEC phyBOARD-Segin
Message-ID: <20190723053951.GN3738@dragon>
References: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:19:17AM +0200, Stefan Riedmueller wrote:
> This patchstack adjusts the already existing naming for the PHYTEC
> phyBOARD-Segin to the PHYTEC naming scheme that is already used with the
> phyCORE-i.MX 6 and the phyBOARD-Mira.
> 
> Furthermore it introduces some small fixes and adds support for the PHYTEC
> phyCORE-i.MX 6ULL which also comes with the phyBORAD-Segin. It comes in a
> full featured option with either NAND flash or eMMC and a low cost option
> only with NAND flash.
> 
> Stefan Riedmueller (10):
>   ARM: dts: imx6ul: phyboard-segin: Rename dts to PHYTEC name scheme
>   ARM: dts: imx6ul: segin: Add boot media to dts filename
>   ARM: dts: imx6ul: segin: Reduce eth drive strength
>   ARM: dts: imx6ul: segin: Fix LED naming for phyCORE and PEB-EVAL-01
>   ARM: dts: imx6ul: segin: Make FEC and ethphy configurable in dts
>   ARM: dts: imx6ul: segin: Only enable NAND if it is populated
>   ARM: dts: imx6ul: phycore: Add eMMC at usdhc2
>   ARM: dts: imx6ul: segin: Move ECSPI interface to board include file
>   ARM: dts: imx6ul: segin: Move machine include to dts files
>   ARM: dts: imx6ull: Add support for PHYTEC phyBOARD-Segin with i.MX
>     6ULL

I applied the series, but please send a follow-up patch for those
undocumented board compatibles.

Shawn
