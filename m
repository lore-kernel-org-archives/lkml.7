Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C60FC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC7520665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560444992;
	bh=E3BVSamBEJXWxz5OabhY2ueDy3SNwdh0BFD9+FBsprM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cYQRa55ERiz8vXSOJaQ+b6EZTSNtjSetFALCqx5fG3DvSGWXnhWdkSheeyrkmZ77u
	 kTy44NStfB2+RkRT1SBhxgLZswCtPjeo+sdWoZwn05abhXTDr1IkPBe1LC7Ne71Foi
	 ZRnomN9vvdRkERwQd2ZJrGTtMsxjnbyc0YXDzHX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbfFMQ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729970AbfFMBjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 21:39:09 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E1520B7C;
        Thu, 13 Jun 2019 01:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560389948;
        bh=E3BVSamBEJXWxz5OabhY2ueDy3SNwdh0BFD9+FBsprM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxQ1w6A2RQZRn7b7ecknRx0Tz6fy2EaASij1/HQZci8yLHrzeuqzCkPKS2yn9QJEN
         nK8YNrAuZ2hBU4KK+VbD874D5qOGlu97wBEGAwClolQhR8FDBmoSBTZWEWX4arbYZ2
         +Y/MTKIdfKPfrpKHr7UTrB2d2B5BCjattasT3JrQ=
Date:   Thu, 13 Jun 2019 09:38:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, narmstrong@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/2] Variscite DART-6UL SoM support
Message-ID: <20190613013830.GC20747@dragon>
References: <1559839624-12286-1-git-send-email-oliver.graute@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559839624-12286-1-git-send-email-oliver.graute@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 06:47:00PM +0200, Oliver Graute wrote:
> Need feedback to the following patches which adds support for a DART-6UL Board
> 
> Product Page: https://www.variscite.com/product/evaluation-kits/dart-6ul-kits
> 
> Oliver Graute (2):
>   ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
>   ARM: dts: Add support for i.MX6 UltraLite DART Variscite Customboard

It's already v3?  I did not find previous versions.  What's changed
since previous versions?

Shawn

> 
>  arch/arm/boot/dts/Makefile                         |   1 +
>  .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 458 +++++++++++++++++++++
>  arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts    | 209 ++++++++++
>  3 files changed, 668 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
>  create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
> 
> -- 
> 2.7.4
> 
