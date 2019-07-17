Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E721C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192CA21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563345766;
	bh=gdDuhx3XH8+TSHfY6ArJLp5Y6SaNs0xxYcyAMFH/vBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kHXb9/JidpDq+Ppy8ztCH7kPXXA7Wt6NcgnQhARfV4qxjf3tIcQmTo7cBXpkuH0f5
	 SVWiLfB4KMj6Rjd6OvDkQ6uKK+POPohShBW+2BCFrl4yRJ9JloEpTlBPZm/a1PMr7+
	 zvD/Fv8XMHyEY35NIVNByTk2cZraHUw6FNTWxDB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGQGmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfGQGmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:42:44 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE5092173B;
        Wed, 17 Jul 2019 06:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563345763;
        bh=gdDuhx3XH8+TSHfY6ArJLp5Y6SaNs0xxYcyAMFH/vBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSCitkGDSY4+BuSrf+dmfLSE7mRzd9XYhEbtmGyeE0CftZrcflTe6SHbBzEyQk72f
         NuMkjdmBKJstGxN9dX4ZgNL/GtiAuPDZJE3+7xsH913J0sP6ZpKAsZxXQjCwGM3p8T
         bmMWqKwSQKuvGPaIHoAwJBsgqAP0XIZPbEQFWzbQ=
Date:   Wed, 17 Jul 2019 14:42:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     yibin.gong@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, broonie@kernel.org, festevam@gmail.com,
        vkoul@kernel.org, dan.j.williams@intel.com,
        u.kleine-koenig@pengutronix.de, catalin.marinas@arm.com,
        l.stach@pengutronix.de, will.deacon@arm.com,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 13/15] ARM: dts: imx6sll: correct sdma compatible
Message-ID: <20190717064226.GB3738@dragon>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-14-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610081753.11422-14-yibin.gong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 04:17:51PM +0800, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> Correct sdma compatible since ecspi errata ERR009165 has been fixed
> on i.mx6sll as i.mx6ul.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Applied, thanks.
