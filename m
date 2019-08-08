Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDE3C32754
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DD9214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565271199;
	bh=ItdyOog//IGZbQXPEDS/rq8kS831yi3bvAZtUvSenv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ueUAgJfkXya8G/8/928FInZeG6WQzWq5PHxw4ieEiJQpThcallUt49u73ppFNO7l2
	 ndjaDjDX932MKwIe3VqGjirKleMmzGs0SpNg/9Zqo8pJkrF0j6VNzk6fHD33/kpxfF
	 APc5faO/dJgXcCaNmwn5M+tvH6Zwe//y49Wi4Peo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbfHHNdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733087AbfHHNdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:33:18 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA1021479;
        Thu,  8 Aug 2019 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565271197;
        bh=ItdyOog//IGZbQXPEDS/rq8kS831yi3bvAZtUvSenv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c46Um6Va7v3CnH2hgePtURNEK1/WTamfNLKJyBSYedEYWEpP7GIVXXbfhIceURtJz
         roB1fS8vKETVoGDhCU7XkpGSH6kdk8JUdHiMNF56bfum4v0LcMUUUZx7bOR4FzrIqc
         bs8PZJIOc/5Lu9mocbm8zL4YHxslJ7pnEsj4O0lg=
Date:   Thu, 8 Aug 2019 19:02:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     dmaengine@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fsl-edma: implement .device_synchronize
 callback
Message-ID: <20190808133206.GB12733@vkoul-mobl.Dlink>
References: <20190731173659.14778-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731173659.14778-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-07-19, 10:36, Andrey Smirnov wrote:
> Implement .device_synchronize callback in order to be able to use
> dmaengine_terminate_sync() and other primitives relying on said
> callback.

Applied, thanks

-- 
~Vinod
