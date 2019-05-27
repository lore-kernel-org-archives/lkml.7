Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCD8C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 05:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CD821726
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 05:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558936460;
	bh=kTw1vIy63CpClmQ1NgX+q/BmbQU4gJ8nmM5rDKV/lig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SXmoeJkB87Wt/9VmuPHl8awxGXqDyJG5sWBpoUUHzyf5TpxTbFmzlR74WoU6wjuS0
	 0aWCWUTZ1tB3YEj4HyF4MBNova7v2gh9pc9VQN0R4lVbi/YxfygV6vJwF1gC4qtvSv
	 qbx10moBCHs2mHrijxyod+NjYNHJ++xqTeK+/iDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfE0FyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 01:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfE0FyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 01:54:18 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87701206BA;
        Mon, 27 May 2019 05:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558936458;
        bh=kTw1vIy63CpClmQ1NgX+q/BmbQU4gJ8nmM5rDKV/lig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFCIi4/VcdUahYdnkFYtl1U+KJI/g4FzbMitep4L3JOecatzJ3BTr/U5hNAFtmhDF
         4E+VOFNyj4QYLeLswDpKeiIQJ+qfDT8UDMc4KMXNUatvAHKrLJNSav99Q8b/i13KLU
         V3Wc8MHZY/TRrT7YRa0Y2QLyJd46EbA9GzIEahUw=
Date:   Mon, 27 May 2019 11:24:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     dan.j.williams@intel.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/8] Add matching device node validation in DMA engine
 core
Message-ID: <20190527055414.GB15118@vkoul-mobl>
References: <cover.1558351667.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558351667.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-05-19, 19:32, Baolin Wang wrote:
> Hi,
> 
> This patch set adds a device node validation in DMA engine core, that will
> help some drivers to remove the duplicate device node validation in each
> driver.

Applied all, thanks

-- 
~Vinod
