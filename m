Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8838ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920C0222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568185407;
	bh=KHMiHQSVMrPZ+NrnVGJZgjz+3LvakSIMk7I2HwLLups=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q9F/n4WbNKJT6ftf+UtK1bg0rxTFAU3IQII2V49uvs8Vsxo4aYrl3DgRAheapAhKM
	 CLCP/3IYcp9DnpcUO0gHuOfIy+ACIDMSAp7qtNy5bDIswpjkBxQFyURKaHNA6zsOZC
	 1gPj19Nob13P3izlgdV3IvL8USYopxAGsuLle7kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfIKHD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfIKHD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:03:26 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 751E2222BF;
        Wed, 11 Sep 2019 07:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568185405;
        bh=KHMiHQSVMrPZ+NrnVGJZgjz+3LvakSIMk7I2HwLLups=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZuk2zkcPvu0woCKqtj3weurQ7xKWtYR8DTA13MEIuHCb+eSPa451G8boYuE65Y4v
         2trrQcIG0P8GUr3NXXYvbBSOsrku2o6Yh4lQvgBFax8lR5YejUJdjOHaOzVrNDME2R
         Am5Js/c52wIg0m5PQkixc5a0lQlDMc3+rnVhsVxE=
Date:   Wed, 11 Sep 2019 15:03:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     clang-built-linux@googlegroups.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: imx-weim: remove __init from 2 functions
Message-ID: <20190911070314.GE17142@dragon>
References: <20190826095828.8948-1-ilie.halip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826095828.8948-1-ilie.halip@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 12:58:28PM +0300, Ilie Halip wrote:
> A previous commit removed __init from weim_probe(), but this attribute is
> still present for other functions called from it. Thus, these warnings
> are triggered:
>     WARNING: Section mismatch in reference from the function weim_probe() to the function .init.text:imx_weim_gpr_setup()
>     WARNING: Section mismatch in reference from the function weim_probe() to the function .init.text:weim_timing_setup()
> 
> Remove the __init attribute from these functions as well, since they
> don't seem to be used anywhere else.
> 
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: clang-built-linux@googlegroups.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied, thanks.
