Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BDBC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DB8217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563434073;
	bh=9J/UArI4Ztjw2ar/HnzHxBARiZ7Et7nhhnVy5Y1gJko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wv0zYKHYCMYY0VvW2JKyCLiVagSb/mg78yhBQfBxl7m+2E07UZxSmoqCQHG+rwJvJ
	 uPmpUPnE+l50HXybtZMsXKRFxm37/wbYZRLER5rjM4qt/n0HCej/oBxdiQnEZmo8rw
	 OkCE994QUYNfbSrJOP3fpzZ5Edu3Jijk0ls3zbjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbfGRHOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfGRHOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:14:32 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE64B20880;
        Thu, 18 Jul 2019 07:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563434071;
        bh=9J/UArI4Ztjw2ar/HnzHxBARiZ7Et7nhhnVy5Y1gJko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1pOVdorM6isyvwSj/vR9YcdgjHSexgzmSmBK53TVr6NgF9to+f/OZkPnlwMmKleUm
         dwv0gaasDPa4V1W2iVYbz0jrc1qTAfGoEnaP7ds88nJXIFjcowN9g5gqL6t6kYocz1
         Y4KiiaZ9m0w8YCXWHlu7xVITUEcMp9n5yfAoYlsg=
Date:   Thu, 18 Jul 2019 15:14:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] soc: imx8: Add i.MX8MQ UID(unique identifier) support
Message-ID: <20190718071411.GK3738@dragon>
References: <20190626074415.18224-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626074415.18224-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:44:14PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add i.MX8MQ SoC UID(unique identifier) support, user
> can read it from sysfs:
> 
> root@imx8mqevk:~# cat /sys/devices/soc0/soc_uid
> D56911D6F060954B
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
