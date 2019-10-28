Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CE7CA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04B42086D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572243671;
	bh=1oraWkvGzB9i9YIhUnpN2CmrzqBkmrHglcy6dngSph0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jr0vPam2rbYUsj9Bq3VnV6sI2v0pkENzBLjee02vv+VViCFDSEsZj5EzRaj22ioGN
	 sYplXoUb6MI5BQeJ8Ljst9vSrnSoURcHrG9XDBHbt401frAXHnohPRktkj/NhZepT+
	 CHu/4DhoBWKZmHaai1op43BLtBZQ7pQWlSnNBaOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfJ1GUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 02:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbfJ1GUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 02:20:54 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5550F20659;
        Mon, 28 Oct 2019 06:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572243654;
        bh=1oraWkvGzB9i9YIhUnpN2CmrzqBkmrHglcy6dngSph0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BicByxo3CtsNd7n/zsZKv1iyV6JhcfcHGWYQ6toEw4HYp1HWwf7zGtiZ6WLZxEYpb
         P1bALq/KSNVc02swIBd3gab1fH1XhxspQ6klaRekMPG5hBpghjKgeuuuGVXKw70daW
         vKQl7R8Fur/w07XWZylLF1GAFOxm6fa853rKSfgI=
Date:   Mon, 28 Oct 2019 14:20:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: imx6qdl-zii-rdu2: Fix accelerometer
 interrupt-names
Message-ID: <20191028062033.GN16985@dragon>
References: <20191022040500.18548-1-andrew.smirnov@gmail.com>
 <20191022040500.18548-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022040500.18548-2-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:04:59PM -0700, Andrey Smirnov wrote:
> According to Documentation/devicetree/bindings/iio/accel/mma8452.txt,
> the correct interrupt-names are "INT1" and "INT2", so fix them
> accordingly.
> 
> While at it, modify the node to only specify "INT2" since providing
> two interrupts is not necessary or useful (the driver will only use
> one).
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> [andrew.smirnov@gmail.com modified the patch to drop INT1]
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org,
> Cc: linux-kernel@vger.kernel.org

Applied, thanks.
