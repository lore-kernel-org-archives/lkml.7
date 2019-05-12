Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F33C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78AF2184B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557623442;
	bh=RWaalJ8Tf6DtlXzEk0oSOzhtIpzEEkzuQkE+7wQA0SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TNX45xeM5jamnIjmIgbj8QWdoBOPh0LWvTp/DJtpWsYBZqS56gnE0H2o01PKDymZ5
	 wND4mvKOe7fX/NpmRhsYtKoV7pZ3f/czTwbN8OYknBQOgmGezoIJGFNWuuHZkT73gg
	 HPJCCF1LNLNhz5xADE4U8mSO5J/FEIGLdsAoC1PY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfELBKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:10:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfELBKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:10:41 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C622146F;
        Sun, 12 May 2019 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557623440;
        bh=RWaalJ8Tf6DtlXzEk0oSOzhtIpzEEkzuQkE+7wQA0SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WK4JB9O3G7litIKaqLekPmCsgvcnhkxATFM2us4gJrcowGnthqRGjmaA92sS5i17a
         bkKUjxPoVSzJzy8UVV9q6Y/zKzsDHQTkrVXAMhNTN+7v0vYrKA+Y3ehHo7xPOYZDwC
         rgcreIbQu++0fvra8PX5JN8QVxBwE4vEHFW7lWSA=
Date:   Sun, 12 May 2019 09:10:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_THERMAL_STATISTICS
Message-ID: <20190512011009.GJ15856@dragon>
References: <1557490722-21657-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557490722-21657-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 12:23:42PM +0000, Anson Huang wrote:
> Enable CONFIG_THERMAL_STATISTICS to extend the sysfs interface
> for thermal cooling devices and expose some useful statistics.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
