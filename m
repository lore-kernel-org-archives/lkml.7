Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88651CA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6164D21855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572711976;
	bh=k/sDqPTnGhcmW4scNowy5rX8/89BOxdEbBpnqJbiYdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xhKayWlvkdM0Vkpzf9DE7hYUyNCyrTRbWxDq4yKcoH8hJizIqhUA7PIWwGPjwBv9B
	 TWzGCIy4tugHd29RDgbHD0OOdUsAmT9YHAl/Xar6O14ImkgtyXm0oa7NR+TRU9BUZY
	 HZYXuhgIhDfoGjlt0WFIbhOYtYIk5r9X+nTrZ/0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfKBQ0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 12:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfKBQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 12:26:14 -0400
Received: from localhost (unknown [106.206.20.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21CEB2084D;
        Sat,  2 Nov 2019 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572711974;
        bh=k/sDqPTnGhcmW4scNowy5rX8/89BOxdEbBpnqJbiYdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmpbAjbUo83bdQOi989IpwPnCe7yppQibcebQh0NrbnnsS539wX4EbX+37d4OIYT5
         KVluvYQ233CN3p4Ds/OVVyD6SkFX9gZbgPZAdfyHRe07f7FQ/45dwAu8d9zXGuTVIC
         XxC9tkKNV2E3RRb/Dwj+K12M2dWcsg/O2mtC7mzM=
Date:   Sat, 2 Nov 2019 21:56:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, Peng Ma <peng.ma@nxp.com>,
        Wen He <wen.he_1@nxp.com>, Jiaheng Fan <jiaheng.fan@nxp.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT] dmaengine: fsl-qdma: Handle invalid qdma-queue0 IRQ
Message-ID: <20191102162606.GC2695@vkoul-mobl.Dlink>
References: <20191004150826.6656-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004150826.6656-1-krzk@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-10-19, 17:08, Krzysztof Kozlowski wrote:
> platform_get_irq_byname() might return -errno which later would be cast
> to an unsigned int and used in IRQ handling code leading to usage of
> wrong ID and errors about wrong irq_base.

Applied, thanks

-- 
~Vinod
