Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232EAC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4FB2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578556371;
	bh=qJ73lHGBY5+mUbmxJ+Wm95EZIzgEZEVAiXIja75jIB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w5oT0v5X97z9BxyFyS9FMDM3Zh8yScm0PzecUNTMhpsrgToQ3cE+LoXH1zgCvgnqk
	 RV/9B4t5KaSSGuzXUsrXxf1tvAqo1ex8iTookK8hOkrdEp4e6SQj/g0Lu0chhs4hnq
	 SAii+jZTKT9fHKMrcB1jH0STp+roxgCBfEHrx+nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgAIHwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbgAIHwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:52:49 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC84206ED;
        Thu,  9 Jan 2020 07:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578556369;
        bh=qJ73lHGBY5+mUbmxJ+Wm95EZIzgEZEVAiXIja75jIB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDTK/dBKA/QpBD/ga1bHfAPUl2jLxcrVaTb6p8PaWV2k3UbsX4k1r46Mt9Jm+dqLg
         3k6It8V8wT0Hoj0XTpLYVbATPJkeClLK3422ZzjrqbIMCxUYCnslGekLIOsltEm6wy
         VCBYT67PfGHqlUB/k220CL6XqHY0Zn6utWFpikPw=
Date:   Thu, 9 Jan 2020 15:52:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, l.stach@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] soc: imx: Add i.MX8MP SoC driver support
Message-ID: <20200109075239.GF4456@T480>
References: <1577342402-12329-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577342402-12329-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 02:40:02PM +0800, Anson Huang wrote:
> Add i.MX8MP SoC driver support:
> 
> root@imx8mpevk:~# cat /sys/devices/soc0/family
> Freescale i.MX
> 
> root@imx8mpevk:~# cat /sys/devices/soc0/machine
> FSL i.MX8MP EVK
> 
> root@imx8mpevk:~# cat /sys/devices/soc0/soc_id
> i.MX8MP
> 
> root@imx8mpevk:~# cat /sys/devices/soc0/revision
> 1.0
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
