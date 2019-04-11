Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75CAC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80E9217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554952197;
	bh=ek9UYPosvGOLeDPqpTQp8gSihqraz7ayczv8wP3zfE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sTkyxg6/uQ2FEeV4p4zPhooPXF4BgTO1ctUXsbF32KeNSkBtySZL4hScvSvF+V5TS
	 EVOkAEL5bDbwb/q3CT1nZjzTwawi+u0pA/BN51W5TQWGtp3ibAF9i/Zpqbdulj962J
	 sinzACzHDdo17WTmNJq2Vgs6bavVsO64n1/vBRGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDKDJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfDKDJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:09:55 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C52420818;
        Thu, 11 Apr 2019 03:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554952195;
        bh=ek9UYPosvGOLeDPqpTQp8gSihqraz7ayczv8wP3zfE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHi0IwIsNtjPoTJ+zORwK6ZWIAcvuxuO1F4ehMt/Mq6mZhzQqldLiZQ+Asnz3XRAT
         OH+dJSQZxK1aT9cl85VhqkQkyLRxWEvrnsDY7ICG+dKUUmPZANVH7iroiDcD9P1hyi
         LuIQd1cOjMLnreNaT0ojjhU+36vBUTUNEx9lPVRw=
Date:   Thu, 11 Apr 2019 11:09:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] PCIE support for i.MX8MQ (DT changes)
Message-ID: <20190411030932.GO26817@dragon>
References: <20190405173004.13277-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405173004.13277-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 10:29:59AM -0700, Andrey Smirnov wrote:
> Andrey Smirnov (5):
>   arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
>   arm64: dts: imx8mq: Add a node for SRC IP block
>   arm64: dts: imx8mq: Combine PCIE power domains
>   arm64: dts: imx8mq: Add nodes for PCIe IP blocks
>   arm64: dts: imx8mq-evk: Enable PCIE0 interface

Applied all, thanks.
