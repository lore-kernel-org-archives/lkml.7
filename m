Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE5EC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB92063F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561340845;
	bh=4nvZp6iXSVydigSn7lGWLwxqlvENp3j62806CqZD/NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x0E/4iVCOWdiloYVH3YorrVrZHUfZ0rSiSUvmKMI/kn4vqKLRzMPBLXmRnij6xARS
	 wFMm8O1TOWi9uMSUnHgCYJHx6yWZhA2jjukXDxlWDHmhPUfGeXXDWMHbqPIjDrOX/T
	 dKkc51GMqBg6WRSDmm0M8Aa82zaGlQavmiKXtesQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfFXBrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfFXBrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:47:23 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C277522CEA;
        Mon, 24 Jun 2019 01:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561339760;
        bh=4nvZp6iXSVydigSn7lGWLwxqlvENp3j62806CqZD/NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mfEU6Sc1RAoevKpcSCGpMzSh0Vi+dgoiG6xE5H+OwvrBvsGnvlPo/g6jRRAtOmJf2
         GfGRD/gpTyNOfaG1hK4qfP8ekwgev8BiWDZic2KfJuUh3hryaHsf7oxRBIMioZKspE
         7DltZxx3wT08P3MQOiamPFipM7rnAb9okCLDRaPQ=
Date:   Mon, 24 Jun 2019 09:29:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] soc: imx: Add i.MX8MN SoC driver support
Message-ID: <20190624012757.GH3800@dragon>
References: <20190619010708.31412-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619010708.31412-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 09:07:08AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> This patch adds i.MX8MN SoC driver support:
> 
> root@imx8mnevk:~# cat /sys/devices/soc0/family
> Freescale i.MX
> 
> root@imx8mnevk:~# cat /sys/devices/soc0/machine
> NXP i.MX8MNano DDR4 EVK board
> 
> root@imx8mnevk:~# cat /sys/devices/soc0/soc_id
> i.MX8MN
> 
> root@imx8mnevk:~# cat /sys/devices/soc0/revision
> 1.0
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
