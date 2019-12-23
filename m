Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0085C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C53820733
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 03:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577073329;
	bh=KCMQZhD1mVjLDJIA293/6aCmpbbUlV0yYWK8z7gdVk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MGuJx04eGjCCb6QYGIyyugd5QWH5sETwHUp8hEgi1gBCzok/KQLFSiEgIdWcGLeZG
	 otUAVZ6cGbK2Fs4FxMXJknJdiRCMZJ4D4oNjrYaAIbaEsAHjWMBgXstY8HAgamKTIB
	 utt7EWvA5Oiq5LrzCod4oxLyEUrCQdU+IdCZ0uZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLWDz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 22:55:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfLWDz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 22:55:28 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E9320709;
        Mon, 23 Dec 2019 03:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577073328;
        bh=KCMQZhD1mVjLDJIA293/6aCmpbbUlV0yYWK8z7gdVk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ln9P1t9FQ9aBOjULON7v2ti0QyMxmLICTm3RTlLByf3znwQG4JK7PKRPb9/5QiHTK
         zxtQy/06479Vd5qY+Z2LkJNV3bpWduX7VgUm8nwRsVW6ASQejsr6i6LIwBbe9WTXrV
         0eEHwNM6/M2I7LwcG20lM6Mf5qatzvmRE3seT47k=
Date:   Mon, 23 Dec 2019 11:55:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Jun Li <jun.li@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8m: drop "fsl,aips-bus" and
 "fsl,imx8mq-aips-bus"
Message-ID: <20191223035503.GJ11523@dragon>
References: <1576120601-28698-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576120601-28698-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 03:19:25AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There is no binding doc for these compatible string
> "fsl,imx8mq-aips-bus" and "fsl,aips-bus", "simple-bus" is enough
> for aips usage, so drop the upper two.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
