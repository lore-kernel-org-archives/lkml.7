Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF1C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40808214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569353750;
	bh=yqLbfyP3s05vZswu1l3DHL96kMMX6o89wcVspUz5tXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MRP354cfcGmcoog/e4t1dfDrQfAQdp5EDKD14CKvYO9/1PlNLzp4XBJVGSX/1qTVa
	 NVoNHd9tINS7zIGG0JItKU5ldiiw2vtSRF8eMgu3bB4sI0vTLFh2IEOz/0aHLXy3Bk
	 Z4SsDA3fgU/rycxxymfGVz/n4tIkbPUxse3cpQbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfIXTft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfIXTft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:35:49 -0400
Received: from localhost (unknown [12.206.46.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47744214AF;
        Tue, 24 Sep 2019 19:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569353748;
        bh=yqLbfyP3s05vZswu1l3DHL96kMMX6o89wcVspUz5tXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imZX4t9J5RJWMYVJzBZ1BB+v90CW6xi1fSsCmfUFF274dlU4Q3jNpZgd/JztMhSLb
         msSBY399rrkEmrj/aLfx4XVOGRP8YjTAnYPi7T/LnUSsfTfEzUG9kCNSmVO/1VUEk0
         TnsV8GIJFV48IQWGuWaali3tdgOXWOGklts1xCVo=
Date:   Tue, 24 Sep 2019 12:34:46 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [EXT] Re: [V4 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Message-ID: <20190924193446.GF3824@vkoul-mobl>
References: <20190613101341.21169-1-peng.ma@nxp.com>
 <20190613101341.21169-2-peng.ma@nxp.com>
 <20190624164556.GD2962@vkoul-mobl>
 <VI1PR04MB443142772665BB29B909DFF4EDB10@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB443142772665BB29B909DFF4EDB10@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Peng,

On 11-09-19, 02:01, Peng Ma wrote:
> Hi Vinod,
> 
> I send those series patchs(V5) on June 25, 2019. I haven't received any comments yet. Their current state
> is "Not Applicable", so please let me know what I need to do next.
> Thanks very much for your comments.
> 
> Patch link:
> https://patchwork.kernel.org/patch/11015035/
> https://patchwork.kernel.org/patch/11015033/

Am sorry this looks to have missed by me and my script updated the
status.

Can you please resend me after rc1 is out and I will review it and do
the needful

-- 
~Vinod
