Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CF1CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 14:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5F8218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 14:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571580354;
	bh=U933TxoQrEvEqmsssmgD3G/Fg8+/vhTubrytkuZvyRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=btHITf0xQH8rpifniZaeNL4nQFHJ9w2SvalQt4OoEtEedB6HLZyI/f9wTYI1gvI+j
	 9L7KjzzlhlrYn29E0L3PO1vFQTmDMxjGYOuesRJ8zapNQFREEtDRWUk34ZiYJ4lNzh
	 v3+uTDzU62xSNAWPkzh7ySafWE8nuMwWnbxY3v/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfJTOFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 10:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfJTOFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 10:05:53 -0400
Received: from localhost (unknown [106.51.108.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6654E218BA;
        Sun, 20 Oct 2019 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571580352;
        bh=U933TxoQrEvEqmsssmgD3G/Fg8+/vhTubrytkuZvyRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKNPdxdy1+dpHw4IeDpb5QmttdOuwwXJtb1Qz0IDzJX1CJHLL4aD1RX9vvD6cCNzJ
         hLhpnqsY8f4XdE5AA9rnXEFbn2DXlkD9qySXAYbSzBsrTf6psK7ISomReDKX+p2271
         i8ECSX7hcBflF2w6SIqdqwTBQLEDIQCcb5KxiPL4=
Date:   Sun, 20 Oct 2019 19:35:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        nick.graumann@gmail.com, andrea.merello@gmail.com,
        appana.durga.rao@xilinx.com, mcgrof@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next 0/7] dmaengine: xilinx_dma: AXI DMA driver
 improvements
Message-ID: <20191020140543.GV2654@vkoul-mobl>
References: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-19, 20:18, Radhey Shyam Pandey wrote:
> This patchset adds callback result, descriptor residue
> calculation and some regression fixes.

Applied, thanks

-- 
~Vinod
