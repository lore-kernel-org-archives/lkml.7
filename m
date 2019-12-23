Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4A1C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2488220709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577086654;
	bh=frMuERvhOc4pr13v4ZKKMbrcM0fjSe7l2O10OUZ4wU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mzrpUG9fX7v8yLGfIE6i8iJPAXgrgu2q4pO37iPQ4YOJ/MxtMh/H2miTUyW5KVJi4
	 rSmTTO6GY7j+ZxKkVf7tWCLSkOP2k0+JXepnVMUdxDSUaLQblLsYuud8CD1+WrQvIS
	 I6LwYdM2T0rQIY1R3YKQQJDBx5LmVdgvg8ybAmhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfLWHhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 02:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWHhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 02:37:33 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0381206CB;
        Mon, 23 Dec 2019 07:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577086652;
        bh=frMuERvhOc4pr13v4ZKKMbrcM0fjSe7l2O10OUZ4wU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3+AADcWyPZn4YRNip4q10FhpU+MoMvjOmHcfHGBVpf4pdGYP4o6ThNQgrFqvKWqS
         5YbrmJtJKZ9R9VeowdCZbhzKzEn7ZzpQSV4QUm8pfkvLcrQQgWXtkT/vSjYXSQi+Bc
         qAKruJuf6U+eNaAVpO1fduK7239STbprfnOI+VFo=
Date:   Mon, 23 Dec 2019 15:37:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm: Change SDMA1 ahb clock for imx8mm
Message-ID: <20191223073708.GS11523@dragon>
References: <20191216111530.29558-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216111530.29558-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 05:15:30AM -0600, Adam Ford wrote:
> Using SDMA1 with UART1 is causing a "Timeout waiting for CH0" error.
> This patch changes to ahb clock from SDMA1_ROOT to AHB which
> fixes the timeout error.
> 
> Fixes:  a05ea40eb384 ("arm64: dts: imx: Add i.mx8mm dtsi support")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
