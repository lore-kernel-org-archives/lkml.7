Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16A6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B5F20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfDPGKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:10:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48194 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfDPGKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:10:00 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D235F260FF2;
        Tue, 16 Apr 2019 07:09:58 +0100 (BST)
Date:   Tue, 16 Apr 2019 08:09:56 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <vitor.soares@synopsys.com>
Cc:     linux-i3c@lists.infradead.org, joao.pinto@synopsys.com,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH 3/3] i3c: dw: Add limited bus mode support
Message-ID: <20190416080956.10d89020@collabora.com>
In-Reply-To: <8cf1b180c31c5908d667285fa4880167a5e80c8c.1555350118.git.vitor.soares@synopsys.com>
References: <cover.1555350118.git.vitor.soares@synopsys.com>
        <8cf1b180c31c5908d667285fa4880167a5e80c8c.1555350118.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Przemek

On Mon, 15 Apr 2019 20:46:43 +0200
Vitor Soares <vitor.soares@synopsys.com> wrote:

> This patch add limited bus mode support for DesignWare i3c master
> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> ---
>  drivers/i3c/master/dw-i3c-master.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 0b01607..4005508 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -650,6 +650,7 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
>  
>  	switch (bus->mode) {
>  	case I3C_BUS_MODE_MIXED_FAST:
> +	case I3C_BUS_MODE_MIXED_LIMITED:
>  		ret = dw_i2c_clk_cfg(master);
>  		if (ret)
>  			return ret;

Przemek, you might want to do the same thing in the Cadence driver.
