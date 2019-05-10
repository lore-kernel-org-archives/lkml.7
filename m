Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FC6C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC2F2182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557458984;
	bh=ubGfRjTtDMEutzD5VqoWgK8VhK2vlpDqI8+UnRha5SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z2RCaNcpGgJptLY5s+4pmve/VDkVc9Dykjvh/sLCSPWh8AooI3YHYGbhCzYRagpfi
	 GCuUSul3RpL6OREJqumduzY/MRzTqA6K811z9JoZhlsxJC1EqtEcen3SYiDTBwsCBC
	 wwwqhZPglFPi+lazCwk1/Eo/vobuBZ0YwMLTKBIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfEJD3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 23:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfEJD3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:29:43 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A3D52084A;
        Fri, 10 May 2019 03:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557458982;
        bh=ubGfRjTtDMEutzD5VqoWgK8VhK2vlpDqI8+UnRha5SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfEVBJIPxj5OqTJIYVykGxHqfqsiW4IffIXD4X/iesRS7gg14kkT95ElXmWpLuJrE
         dKBQEeUCE4PLO/t8hgW942KJ0TQeAbyyYp4faHLc2BZiECtanuh9GS9nnrqpqa3nGa
         flImr4Vb4LVaOoa8LfdsNx98mHJWMCdp4NwWuVFg=
Date:   Fri, 10 May 2019 11:29:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Enable
 CONFIG_THERMAL_STATISTICS
Message-ID: <20190510032917.GG15856@dragon>
References: <1556076113-4593-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556076113-4593-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:27:13AM +0000, Anson Huang wrote:
> Enable CONFIG_THERMAL_STATISTICS to extend the sysfs interface
> for thermal cooling devices and expose some useful statistics.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I don't apply patch using base64 encoding.

Shawn
