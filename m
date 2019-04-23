Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6185C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C7A20896
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555985577;
	bh=MQkv6ow7heCYEuAJ3cwpJEQoeCTRmZyrVFUXLELcntM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f5dcCPfFu7meqcvU4odcpnXds4Sx36nhF0LyEv1nABuI86GCobtUhpsIqP9eppR1m
	 BsP+6F5eLQWZcdkf+hYW6k1p0P1IW/odHHTrIgfCLXsqUohzn3uxBGFRo8qs3MX72a
	 XDYJ6AhVUcEqROtYo+p45JkfAxUKQ3FCMwCQEU6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfDWCM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbfDWCMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:12:55 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 178DD2077C;
        Tue, 23 Apr 2019 02:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555985575;
        bh=MQkv6ow7heCYEuAJ3cwpJEQoeCTRmZyrVFUXLELcntM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GL3XtCn2h6elziIXAOq1FLBFrY460XjDL6jXOoHlQGTkn2wB7TmbuwDRxO8zBq2mA
         5bACSupGWAJTKCt6RM17YDuhFLaI+drHA0oIyUZoCnqcnk1SOv2ueXNqDv1GgKgt6b
         Ce/L0eyWsalNtPr5xkIFB0xLgp+4J8+B7ZuO08xE=
Date:   Tue, 23 Apr 2019 10:12:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20190423021235.GE16166@dragon>
References: <20190423084501.15824b18@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423084501.15824b18@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Apr 23, 2019 at 08:45:01AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the imx-mxs tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arch/arm/boot/dts/imx7d-zii-rpu2.dts:46.12-50.4: Warning (io_channels_property): /iio-hwmon: Missing property '#io-channel-cells' in node /soc/aips-bus@30400000/adc@30610000 or bad phandle (referred from io-channels[0])
> 
> Caused by commit
> 
>   69ab5392f517 ("ARM: dts: Add support for ZII i.MX7 RPU2 board")

Fixed.  Thanks for reporting.

Shawn
