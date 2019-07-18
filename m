Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1F4C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008D721783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563418175;
	bh=jdNPPY/nagQO4z4SbeSxOZ2+EDMQori7e6umb/X7wII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mh+50CKiCMJXpX4JEPo4gskgr3kxIJ0kj29a+yICwbdbmQoX7ndaGQHoDPGe7fTGQ
	 7mE0LCv2GOADvBQXc7pb8L/jejS1AbmnsZF1NgV8/5hWvLbCg4dHDHEcFvFg3fMBT7
	 yNwD4yJ2I8wvfzCFtiXJuVC0f3juTb2d/QU2sTUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbfGRCtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfGRCtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:49:33 -0400
Received: from X250 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B76E5205F4;
        Thu, 18 Jul 2019 02:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563418172;
        bh=jdNPPY/nagQO4z4SbeSxOZ2+EDMQori7e6umb/X7wII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2scJcYPaWEnC8O4BuYyROLVOluc2QUVDfFyzDltCMUOGU1YaYhJXRkUz6OdZ/MFIh
         tseMR2zXmwtg2wmQ+eP+MnVB1t+R6+CHVD+Og6kauZA4tWLC1cBk5JnS1SBMfQ5hsT
         V6tnMol1y6TXf44Mb9hc2xH6I9DoPfIRwsPgefFU=
Date:   Thu, 18 Jul 2019 10:49:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     yibin.gong@nxp.com
Cc:     robh@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        mark.rutland@arm.com, vkoul@kernel.org, dan.j.williams@intel.com,
        angelo@sysam.it, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v5 6/6] ARM: dts: imx7ulp: add edma device node
Message-ID: <20190718024920.GC11324@X250>
References: <20190625094324.19196-1-yibin.gong@nxp.com>
 <20190625094324.19196-7-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625094324.19196-7-yibin.gong@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 05:43:24PM +0800, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> Add edma device node in dts.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Applied, thanks.
