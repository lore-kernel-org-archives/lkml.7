Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD560C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0AF2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563220360;
	bh=gxWfqk2TgbmVUUJUbnwv6soEpFM9DgBPHEioAh21gCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MoAHKsb5DfzKkeldea99xKRLMYbjFfXG+S0pY0ZVvRBsNswO5c3BVcbiNRttu5cMW
	 PUxVrqXgaR7gaolBilDoPISVQ4DocWXhiuHmyk382yf9CassC9wpsh4O5cdMeUMxUs
	 8bqN9cqm3ZWSxMOnUa4LbKnwgjtfjbqJf1daTF2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbfGOTwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729525AbfGOTwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:52:38 -0400
Received: from localhost (unknown [88.128.80.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5000F20659;
        Mon, 15 Jul 2019 19:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563220358;
        bh=gxWfqk2TgbmVUUJUbnwv6soEpFM9DgBPHEioAh21gCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpm/P1/+QZgp5xABfY/e94F1TRKCO0D/4+v7mXye5cSZ3f108oeue9Is7DpS1bo2j
         fxZO+NtV/xf2MvTOM+Yop4499twk2oq8D0sG4N6WUdkoGierOw8ibXamvsZL1fy3Jr
         OfI7eqSZHL4S9ah/EPmWsc4r7lYMg4ayi+6r1g74=
Date:   Mon, 15 Jul 2019 21:34:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     linux-kernel@vger.kernel.org, ruxandra.radulescu@nxp.com,
        Razvan Stefanescu <razvan.stefanescu@nxp.com>
Subject: Re: [PATCH v2 5/6] staging: fsl-dpaa2/ethsw: Add switch driver
 documentation
Message-ID: <20190715193431.GA15581@kroah.com>
References: <1562336836-17119-1-git-send-email-ioana.ciornei@nxp.com>
 <1562336836-17119-6-git-send-email-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562336836-17119-6-git-send-email-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 05:27:15PM +0300, Ioana Ciornei wrote:
> From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
> 
> Add a switch driver entry in the dpaa2 overview documentation.
> 
> Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
>  - none
> 
>  .../networking/device_drivers/freescale/dpaa2/overview.rst          | 6 ++++++
>  MAINTAINERS                                                         | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst b/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
> index d638b5a8aadd..7b7f35908890 100644
> --- a/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
> +++ b/Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
> @@ -393,6 +393,12 @@ interfaces needed to connect the DPAA2 network interface to
>  the network stack.
>  Each DPNI corresponds to a Linux network interface.
>  
> +Ethernet L2 Switch driver
> +-------------------------
> +The Ethernet L2 Switch driver is bound to a DPSW and makes use of the
> +switchdev support in kernel.
> +Each switch port has a corresponding Linux network interface.
> +
>  MAC driver
>  ----------
>  An Ethernet PHY is an off-chip, board specific component and is managed
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c0a02dccc869..5c51be8e281c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4938,6 +4938,7 @@ M:	Ioana Ciornei <ioana.ciornei@nxp.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	drivers/staging/fsl-dpaa2/ethsw
> +F:	Documentation/networking/device_drivers/freescale/dpaa2/overview.rst
>  
>  DPAA2 PTP CLOCK DRIVER
>  M:	Yangbo Lu <yangbo.lu@nxp.com>
> -- 
> 1.9.1
> 

This patch did not apply :(
