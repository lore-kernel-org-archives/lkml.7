Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCFACA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7E9214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572268087;
	bh=eN/t8vEWe/l66u2wjNSnil60tzYkWczNbhhncntG/Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WX246HuU7QrerBTKzl8entYpVA939EgODKR3WbycN6R/IJpLuYMi/hU351uKPk8kn
	 7DvWJdSSNONWHn9saFIVXPbKZqL/CHKXYQIWV3ihuDLyG8wXRyH3EZDucqA+sliM0T
	 inF8WdRpQH0Cr2rHjDwQaZVwceIFZj835cUJEk6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbfJ1NIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388578AbfJ1NIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:08:06 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C3B320717;
        Mon, 28 Oct 2019 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572268085;
        bh=eN/t8vEWe/l66u2wjNSnil60tzYkWczNbhhncntG/Qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfkGtUdc9OP38mduRSaP02AMOobq0kjRV6BLT/zrP1C7FrZmLgeZHvo0m0ie71UHm
         LWJ8gu0J128Zy0RjjMH5ewZpCMqpsTw1ComTsNYRxfdXotnteA5mSV60+6r4u5RIog
         pvgl+7uUOKkBe4ZV31SnYN/7z2viBWJcmeuR2JJY=
Date:   Mon, 28 Oct 2019 21:07:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, ping.bai@nxp.com, jun.li@nxp.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: imx8mn: Change compatible string for sdma
Message-ID: <20191028130734.GK16985@dragon>
References: <1571992807-31378-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571992807-31378-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 04:40:07PM +0800, Shengjiu Wang wrote:
> SDMA in i.MX8MN should use same configuration as i.MX8MQ
> So need to change compatible string to be "fsl,imx8mq-sdma".
> 
> Fixes: 6c3debcbae47 ("arm64: dts: freescale: Add i.MX8MN dtsi support")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Updated subject like below, and applied the patch.

  arm64: dts: imx8mn: fix compatible string for sdma

Shawn
