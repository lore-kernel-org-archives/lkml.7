Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFDCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C66020879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553493151;
	bh=Tm8xsFJ1h70kuVTeJ2u9+VOTCZy/EI6v4sV8z7lKh/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g2KaQc2VCq6w9pOT5rDK+7BfJ0XUJQ0HyD6msuCBuCt1qIvtlC2HPc3tG6knGbAZx
	 VFHsmXj2LF94WeodefDUA3ka4TzPXz6X/TFrOIoPQAHs8xg64yEofT+LkjupyaOdbB
	 NxfoNRd3gqiMRtQSHwcwArdJM8fRiSLauumyiPHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfCYFwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbfCYFwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:52:30 -0400
Received: from localhost (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD7FE20879;
        Mon, 25 Mar 2019 05:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553493149;
        bh=Tm8xsFJ1h70kuVTeJ2u9+VOTCZy/EI6v4sV8z7lKh/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rBcdjLELgQ9zlrQ3zr79ab7Wx4BEdBcPmMvrjvni1CACKpWkeuQHd3xWMJYpCOfHw
         VGzhTB5byjzArMfdLyiAEYJUG3Ivxbn0ERFS7eD5qmio7prp5rsr1PzImVn+KuZX1Q
         Y6xCaW4tEqANOD8ic0LaXCg7KghfzLYVaeBwNEsM=
Date:   Mon, 25 Mar 2019 11:22:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jeff Xie <chongguiguzi@gmail.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma:xgene-dma:move spin_lock_bh to spin_lock in tasklet
Message-ID: <20190325055223.GL5348@vkoul-mobl>
References: <1553013919-29504-1-git-send-email-chongguiguzi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553013919-29504-1-git-send-email-chongguiguzi@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-19, 00:45, Jeff Xie wrote:
> It is unnecessary to call spin_lock_bh in a tasklet.

1. Please use the right subsystem name, dmaengine: xxx (you cna find
that by git log on that subsystem)

2. Space after each :, like dmaengine: xgene-dma: move...

3. Please explain a bit more about the change on why it is unnecessary
:)

Nevertheless, I have fixed 1 & 2 above and applied it
 
-- 
~Vinod
