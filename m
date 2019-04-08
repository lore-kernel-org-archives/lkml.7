Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0536C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3C8217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfDHRZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:25:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:53261 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfDHRZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:25:43 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44dHPd0dB8z1rFs3;
        Mon,  8 Apr 2019 19:25:41 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44dHPc6qmVz1qr5x;
        Mon,  8 Apr 2019 19:25:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 4aq2fPtyRxGG; Mon,  8 Apr 2019 19:25:39 +0200 (CEST)
X-Auth-Info: QveEscH+ZzQPb2xV0OJ73UVDiWInbztvsfBMqEWaf5I=
Received: from crub (p508B6C31.dip0.t-ipconnect.de [80.139.108.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  8 Apr 2019 19:25:39 +0200 (CEST)
Date:   Mon, 8 Apr 2019 19:25:39 +0200
From:   Anatolij Gustschin <agust@denx.de>
To:     atull@kernel.org, mdf@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org
Subject: Re: [PATCH v4 3/3] fpga: Add fpga manager driver for ARRI Altera
 FPP
Message-ID: <20190408192539.590410bb@crub>
In-Reply-To: <20190221202506.17744-4-agust@denx.de>
References: <20190221202506.17744-1-agust@denx.de>
        <20190221202506.17744-4-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Feb 2019 21:25:06 +0100
Anatolij Gustschin agust@denx.de wrote:
...
> .../ABI/testing/sysfs-driver-ftdi-fifo-fpp    |   7 +
> drivers/fpga/Kconfig                          |   7 +
> drivers/fpga/Makefile                         |   1 +
> drivers/fpga/ftdi-fifo-fpp.c                  | 594 ++++++++++++++++++
> 4 files changed, 609 insertions(+)
> create mode 100644 Documentation/ABI/testing/sysfs-driver-ftdi-fifo-fpp
> create mode 100644 drivers/fpga/ftdi-fifo-fpp.c

Ping. Any comments to this driver?

Thanks,
Anatolij
