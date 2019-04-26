Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A8C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370AE2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 12:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556281220;
	bh=mI9NdfFsgl0gKR9CQdoIUjjAQi/KrcMbW3F4PVK9fZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rj3+ZTrjqg54hGxKDUqkjcUjM8z8EosLkV35Vlk1CnoPeQqK2K7MM0bPHW6AXykul
	 MFDj7VzuUxogsvCH7WB/UQNC7P9kgBZD4K/zwaiuxHaTu/P3HFesq+/uKSOOvsghjL
	 htYE5tYbZAjfMl41sJ0CTCn8QZzWjzUiMK8A8F60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfDZMUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfDZMUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 08:20:18 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F2B5206BF;
        Fri, 26 Apr 2019 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556281218;
        bh=mI9NdfFsgl0gKR9CQdoIUjjAQi/KrcMbW3F4PVK9fZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUkY5KhGq4oZKd17Ar7Kzry44pZYTuvk3BKjOrF8xD8IAQYdr5ClR3U3BJRDFPI0i
         724LqqlAPc0pPHETH2v3If5sJeebKVwi3jzciK2UMwaV+X/V8UdrvEc5/hrZMmo6ZN
         jh1PwEYsvJhaoMseP1xw/lzVTZ6POA75A5auBAXA=
Date:   Fri, 26 Apr 2019 17:50:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-dma: dmaengine: stm32-dma: use
 platform_get_irq()
Message-ID: <20190426122012.GD28103@vkoul-mobl>
References: <1556097685-7236-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556097685-7236-1-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-19, 11:21, Fabien Dessenne wrote:
> platform_get_resource(pdev, IORESOURCE_IRQ) is not recommended for
> requesting IRQ's resources, as they can be not ready yet. Using
> platform_get_irq() instead is preferred for getting IRQ even if it was
> not retrieved earlier.

Applied, thanks

-- 
~Vinod
