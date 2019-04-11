Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC468C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79108217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554961584;
	bh=rWOJWFqoVaL6GQnhuWFhYvGlry+GoYc1vLswJA0hUvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MD9RZGY9jK0d8mjYQrFxVe+dWn41PxVY2uXDm2aIHUyXA+U1ikeLc7XtjQiZAvanr
	 B8LrpLI/TMR7BPrWNVIclIO2SaXoiS0/JpcmYpZxtE9+AEgPVqUgMnGPUC1roKJJBj
	 ORlTEnB1QWZqL3/hQV1dxz0DKV5qXPuhLDXWzi50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDKFqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfDKFqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:46:23 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B0F2083E;
        Thu, 11 Apr 2019 05:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554961582;
        bh=rWOJWFqoVaL6GQnhuWFhYvGlry+GoYc1vLswJA0hUvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TjFGM12ODPzoxS9lv6jSreoTQ2dWt35Mm0SmmRoj3cpGLdS/I/DwLVNnJUYK+nNSj
         4tQPl3FL6A69SV++/F9jiDQHKgXG8LHxVI7Bw2hm+683ip6ZC90egzV2gp53W7aRHn
         7xmIZ4sLhbQCWw+QP7WCdOGTp8rZQExJaR4WGi4w=
Date:   Thu, 11 Apr 2019 13:46:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, adam.ford@logicpd.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ARM: dts: imx6q-logicpd: Enable Analog audio capture
Message-ID: <20190411054604.GT26817@dragon>
References: <20190402192547.4538-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402192547.4538-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:25:45PM -0500, Adam Ford wrote:
> The original submission had functional audio out and was based
> on reviewing other boards using the same wm8962 codec. However,
> the Logic PD board uses an analog microphone which was being
> disabled for a digital mic.  This patch corrects that and
> explicitly sets the gpio-cfg pins all to 0x0000 which allows the
> analog microphone to capture audio.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
