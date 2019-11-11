Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AD9C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381782067B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573452727;
	bh=LXWYG1ROjwSH1hn5KYvqLWtCtUw0B3W+w0MZMaAcIaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Obv8iBEv540UCkCB1QhvcJbY7q4VocTrcGN89yvBu6wSNuwblumKPDEqkloN+VY87
	 tf8Q9pBCwGANb2wsArOFSMYT+CxfAeDcB9IBb0SS+k0+amVpeBIE0G/CjZ9L6M8MMR
	 pWYPodiRhVEBNax2UTwlGQY098Hw6OaIEs4/9deU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKKGMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:12:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfKKGMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:12:05 -0500
Received: from localhost (unknown [106.201.42.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EE6A2067B;
        Mon, 11 Nov 2019 06:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573452725;
        bh=LXWYG1ROjwSH1hn5KYvqLWtCtUw0B3W+w0MZMaAcIaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsnMSCFw5ZbH23zLhgAFCwVg2FwK5kCYILOEY/l88c2/tQn3gFEdKtlk33mBg9g2s
         z76+MU+MyTYq5lhTxgbkUjLpv8zwtT63VYdiVEXHjuhKuYNo+CsAcCs1ao2cduNY/W
         T21t7yjRDnOuRFezqAU7K6ee7PAD95SVrXme2VgU=
Date:   Mon, 11 Nov 2019 11:41:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v4 14/15] dmaengine: ti: New driver for K3 UDMA -
 split#6: Kconfig and Makefile
Message-ID: <20191111061159.GR952516@vkoul-mobl>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-15-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101084135.14811-15-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +config TI_K3_UDMA
> +	tristate "Texas Instruments UDMA support"
> +	depends on ARCH_K3 || COMPILE_TEST
> +	depends on TI_SCI_PROTOCOL
> +	depends on TI_SCI_INTA_IRQCHIP
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	select TI_K3_RINGACC
> +	select TI_K3_PSIL
> +	default y

Again no default y!

-- 
~Vinod
