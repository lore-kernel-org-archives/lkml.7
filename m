Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3FDC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62D520707
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgAFPQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:16:38 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:53044 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726436AbgAFPQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:16:37 -0500
Received: (qmail 1716 invoked by uid 2102); 6 Jan 2020 10:16:36 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jan 2020 10:16:36 -0500
Date:   Mon, 6 Jan 2020 10:16:36 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Dmitry Osipenko <digetx@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 20/20] usb: host: ehci-tegra: Remove unused fields
 from tegra_ehci_hcd
In-Reply-To: <20200106013416.9604-21-digetx@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2001061014430.1514-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020, Dmitry Osipenko wrote:

> There are few stale fields in tegra_ehci_hcd structure, let's remove them.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/host/ehci-tegra.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
> index 1eb94205a5ac..d6433f206c17 100644
> --- a/drivers/usb/host/ehci-tegra.c
> +++ b/drivers/usb/host/ehci-tegra.c
> @@ -42,12 +42,10 @@ struct tegra_ehci_soc_config {
>  };
>  
>  struct tegra_ehci_hcd {
> -	struct tegra_usb_phy *phy;
>  	struct clk *clk;
>  	struct reset_control *rst;
>  	int port_resuming;
>  	bool needs_double_reset;
> -	enum tegra_usb_phy_port_speed port_speed;
>  };
>  
>  static int tegra_reset_usb_controller(struct platform_device *pdev)

For patches 2, 19, and 20:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

It's nice to see that patch 2 makes the sequence of events in 
tegra_ehci_remove() exactly the same as the failure pathway in 
tegra_ehci_probe().

Alan Stern


