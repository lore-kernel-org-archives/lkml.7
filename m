Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DEFC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3972080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560841989;
	bh=iSzPbJOxtUpG63TXwYWTX8utSWETqRhTDTXN4LMFPKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LmopmtiJrvrG/639lgAZpIiZJgv8xPaOYyTfmFJhVzqfbYpq1t5/LiM/5OVtbgchS
	 wAARr2cQat7/Lz8WFz7NygTdb9kjvgqU7szvwmt3G5hXCfwowoYvOJwKGlmNqadLh6
	 osZocQb/W2aBiA+Z8jJNIyFEyW5Ckc0A5En7v5LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfFRHNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfFRHNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:13:08 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F00DE20679;
        Tue, 18 Jun 2019 07:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560841987;
        bh=iSzPbJOxtUpG63TXwYWTX8utSWETqRhTDTXN4LMFPKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1dES81Pzw/AzeY3PeaMwfrxTHwVwe6MN+8JHE6Ab3tMbWm6vQYPxghH7tzqAupzo
         cvAdEiq+SUEPxVa9ZY2ggTDLKVIMv0tOeLClBlQEZuSN4cmoRk+hCEE/8YmHDU+NTg
         2RsHvYJcFQIoOozSxtTullHSStHDrmSLQdkLja4w=
Date:   Tue, 18 Jun 2019 15:12:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        ccaione@baylibre.com, abel.vesa@nxp.com, baruch@tkos.co.il,
        daniel.baluta@nxp.com, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mq-evk: Enable SNVS power key
Message-ID: <20190618071210.GF29881@dragon>
References: <20190613010227.46860-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613010227.46860-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 09:02:27AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Enable SNVS power key for i.MX8MQ EVK board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
