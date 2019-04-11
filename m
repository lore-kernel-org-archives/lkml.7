Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD48C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196452184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554961707;
	bh=TvxOj6O79Kk2M2035vp0L3tuY4OgNRzFIM+0V4KMuBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PgCZDr1pbVhoXRc9cBdBlWYrJ5AriqkUjAIXLXvGRuFZPGM/PADLhg+6UdhOPZQl2
	 1aeZbND2lFMz0fKz3FjrmDL7cHghknZytv/93R91sfnxswPn/LXinkDMO18jEhRM5l
	 vEEZjTAcFfaTSHLzNf05bW/EiOytqJ5Lgf2RZTYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDKFsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfDKFsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:48:24 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2A220850;
        Thu, 11 Apr 2019 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554961703;
        bh=TvxOj6O79Kk2M2035vp0L3tuY4OgNRzFIM+0V4KMuBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vA6j69nk/O4urqhPodElNUIV+yd8Y3AaTTnusY+3EP/LLkApwzMZsSXwA+18vRpi/
         M03xDjsKuZii3407W1hdygXcyE4RAsylaqflh/O+kWO6hkBbQNCI8oCaq19gTCeUdb
         L9J9ioAL3XCQivm83wbuDaulcf9qv921Qd9LXH2E=
Date:   Thu, 11 Apr 2019 13:48:06 +0800
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
Subject: Re: [PATCH] ARM: dts: imx6q-logicpd: Reduce inrush current on USBH1
Message-ID: <20190411054805.GV26817@dragon>
References: <20190402193204.4745-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402193204.4745-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:32:04PM -0500, Adam Ford wrote:
> Some USB peripherals draw more power, and the sourcing regulator
> take a little time to turn on.  This patch fixes an issue where
> some devices occasionally do not get detected, because the power
> isn't quite ready when communication starts, so we add a bit
> of a delay.
> 
> Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic PD
> i.MX6QD EVM")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
