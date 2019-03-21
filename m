Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26762C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FFB218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553137341;
	bh=R58evYrD6Bc19cFmMUfCmsa3o3WLL/24hBa3cDJqjzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wQ45LcaZLtQdMr0KMW0jXogcrt05DF+w1YmhUwH/B1Y5HUVgTExLTaJYANh2TZnxj
	 Ed7qEpmb54NH87sYFv+muTOnUDnQCEHjLETIW+0Qo1e4POeP/abqFOGaK3eI0u69iZ
	 KBOx8zx24ZhrvtA3WXx4V7afN65KqHmgQB4YZuIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfCUDCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfCUDCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:02:19 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4603320811;
        Thu, 21 Mar 2019 03:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553137338;
        bh=R58evYrD6Bc19cFmMUfCmsa3o3WLL/24hBa3cDJqjzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHf8kahfLAaSB1L7I2HYcQZvZIL8/3JPCL+g1mXAiUGUSbM7kFNnoi9ZEjtXNhbZG
         d8EfITNpcVXw9M//7hqE3zYrtk6L7i31pLicsCXBTT7bwuBp3X/AWCUqdR+mS/cmZg
         Q7+/g6FXljM0b4kcEzv5NHuQ7qWjEKq4Emt/Y9eE=
Date:   Thu, 21 Mar 2019 11:01:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6ull: Use the correct style for SPDX
 License Identifier
Message-ID: <20190321030152.GB12513@dragon>
References: <20190311142700.GA5867@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311142700.GA5867@nishad>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 07:57:04PM +0530, Nishad Kamdar wrote:
> This patch corrects the SPDX License Identifier style
> in imx6ull-pinfunc-snvs.h.
> 
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46
> and making some manual changes.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Applied, thanks.
