Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12A0C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E3721911
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563850689;
	bh=UknProSrEIRPd0jYMHFIAsZDt83gqHVAA5eZleizxsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xABd9AeksgPaKy3u0wSbbsev7cY+Mol5d8RfLX9hqGGhghIKq6AcGqrWzHmXNovg/
	 6QL32xvW8LbFsOFU90xrU7KsTGJUD4QxiOFdnbGi0yUUWlNvpWrAJ2ADqoUe+JdbBH
	 7EQvCa2c2uNYpZwdUx7kUSX4VEDLQjlbpeXt/uVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfGWC6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfGWC6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:58:08 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA3C820840;
        Tue, 23 Jul 2019 02:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563850687;
        bh=UknProSrEIRPd0jYMHFIAsZDt83gqHVAA5eZleizxsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6pDCiYuzt6tOG8GAyvzd3Z3tX2jnwNWqv6vjr132PVO9cA/uW1Gdg6dacnYjpfPD
         FTTUtrQmHCdVl+uS7SgFNW8O5z1xI1CMYZltQv9sMmysunBtvPSrLA3kbwRaiSzGWZ
         NH/VY/b7/wo08WQ4GColImABCLX6x56NtooU1mtM=
Date:   Tue, 23 Jul 2019 10:57:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, viresh.kumar@linaro.org,
        daniel.baluta@nxp.com, ping.bai@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V4 2/2] arm64: dts: imx8mm: Add "fsl,imx8mq-src" as src's
 fallback compatible
Message-ID: <20190723025738.GK3738@dragon>
References: <20190705085406.22483-1-Anson.Huang@nxp.com>
 <20190705085406.22483-2-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705085406.22483-2-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 04:54:06PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> i.MX8MM can reuse i.MX8MQ's src driver, add "fsl,imx8mq-src" as
> src's fallback compatible to enable it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied this one, thanks.
