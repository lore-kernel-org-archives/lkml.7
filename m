Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466A8C04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C72220833
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558321218;
	bh=jfXJLpbE4kXVGEV+hjaGh9tglvbqgZpjqOPGuhlXhw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z5KRx2+dQUaP3IflFPnL5IsBVqMX123SXwZhdJwcQ4/QYMFz/3h4Ic1+5FLu0l+Cj
	 hpzGyEDtaYs8ephL06hHWdZ5dCgdrarFHYkWwDYfQhE0i0eyBSHZKH0etiFIsS8PjQ
	 ojQ1q1xgnlRTmKmiAP4uSaPaJywxwswe4ZyW9uEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfETDAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 23:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfETDAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:00:16 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B5D20644;
        Mon, 20 May 2019 03:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558321216;
        bh=jfXJLpbE4kXVGEV+hjaGh9tglvbqgZpjqOPGuhlXhw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q04B34MHld4TgcGDc2o8fyDiFEHWoWvO3RVgFsIzdQXhPoJ5V8FHCymqVcamGjl17
         cL2yBja8Ycz72rJgso+rQEPMEjf5HZcsDa+kQrSbmG9bcOQW3i2gdSKw9Yl4n6V4oC
         IqowJfnhugvmFMzNVO0J3SVwxICZoSaSQxBU7G+I=
Date:   Mon, 20 May 2019 10:59:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND] ARM: dts: imx6ul: add clock-frequency to CPU node
Message-ID: <20190520025927.GM15856@dragon>
References: <1557651135-12109-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557651135-12109-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 08:57:16AM +0000, Anson Huang wrote:
> Add clock-frequency property to CPU node. Avoids warnings like
> "/cpus/cpu@0 missing clock-frequency property" for "arm,cortex-a7".
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
