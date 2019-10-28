Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3B4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17902086D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572243674;
	bh=7KjOTQXNF6D5WHveWXFYCsb/3lubN3EseXC8iIzWeNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iUHoI5kyCucJeXcydBTzSwEqYgw3hYgEmpsDg6Zv/wZQ+K79vnLn6IJyxvtPP2XUy
	 sfq97vK8Na4+Z4wMvch8WGQmF5AkPIwBxAzXZ180r/pcq4xeQVBpCviLkjqUxoJyXN
	 EHGopgtNidSeglFzYOoW5zQ1XxAT6P0B+V3h3HnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbfJ1GVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 02:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbfJ1GVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 02:21:13 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17A4620659;
        Mon, 28 Oct 2019 06:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572243672;
        bh=7KjOTQXNF6D5WHveWXFYCsb/3lubN3EseXC8iIzWeNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xnF2K7tN1n24TDs5uBBaJVtfyLwz9eGUTE+k/nTPcuUtPkeMPsvXE8JR1D26hADNW
         LFTccm/VcpUq73FoN+yKylVLvioASQyK71fieHti5P7k6lJpkZJ0DWPFf2dX54dvTD
         CXMRoNnkRaBDcZa88myug/MWuJmq0mgQvpUj2LKE=
Date:   Mon, 28 Oct 2019 14:20:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: imx6qdl-zii-rdu2: Specify supplies for
 accelerometer
Message-ID: <20191028062053.GO16985@dragon>
References: <20191022040500.18548-1-andrew.smirnov@gmail.com>
 <20191022040500.18548-3-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022040500.18548-3-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:05:00PM -0700, Andrey Smirnov wrote:
> Specify 'vdd' and 'vddio' supplies for accelerometer to avoid warnings
> during boot.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org,
> Cc: linux-kernel@vger.kernel.org

Applied, thanks.
