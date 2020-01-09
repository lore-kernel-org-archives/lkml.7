Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D87C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB04206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578567371;
	bh=CVoVzIKw0x3G9IXLdrus5Zspkz3FD6tHvezgywdNuIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1bNA53eB1UDetTD0JeEKyTxoPwHTlwXt7NyMtOe24p4aIoYPKKGR9c4czuU95TSqR
	 8N3RDfEgSRbX2Zb7R06rqMXkLxq5l0/utOE8FCEgvMO5MyYmv26ZMnWoRlNktvrcrB
	 PYFi9V8vvsZHGBWUeE0XNr9f7wp/AGTZsG7UI+KI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgAIK4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:56:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgAIK4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:56:08 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A4F20673;
        Thu,  9 Jan 2020 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578567367;
        bh=CVoVzIKw0x3G9IXLdrus5Zspkz3FD6tHvezgywdNuIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2hoVVGc1ZDBO9v7R82ULszeZil1O9gIki5/aOwclQ8MVARULm6KJOXSp9SapMKR3
         ApyITRYcWS0zNByv8v8fS37gzV/+bSSB9l1HwDg/wApJr+yQIebDWokZ2KMQC3dkaI
         nWj/54dijvGdHTn7Hp4UvJO9hB4JqF1T+2DuTrmc=
Date:   Thu, 9 Jan 2020 18:55:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, daniel.baluta@nxp.com,
        leonard.crestez@nxp.com, shengjiu.wang@nxp.com, ping.bai@nxp.com,
        jun.li@nxp.com, aford173@gmail.com, peng.fan@nxp.com,
        abel.vesa@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: Memory node should be in board DT
Message-ID: <20200109105558.GT4456@T480>
References: <1578468329-9983-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578468329-9983-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 03:25:28PM +0800, Anson Huang wrote:
> Memory address/size depends on board design, so memory node should
> be in board DT.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
