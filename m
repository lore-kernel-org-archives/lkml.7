Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1A9C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5917217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558412838;
	bh=CaQYy8zLGUxtK1g5/hR8MTqS4yBQ6Eapkbwj5DmiKwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rw2ViVOxbwYNRfiDz0oBFB1Dxcl0zqF+CfPdmbQi6tFQInKFFWbNjOgxff7RB5z21
	 Y8tLGSaDLiWBL87XZ24rW4IVZfDwPYqSBIvb5D93Ym/4tzeAwLw/8DY/8gEZWa02mK
	 5DLThrwHUj0yXPCwHlg+lAXR9tCAwLVWx0nteZjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEUE1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfEUE1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:27:17 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B3E321743;
        Tue, 21 May 2019 04:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558412836;
        bh=CaQYy8zLGUxtK1g5/hR8MTqS4yBQ6Eapkbwj5DmiKwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xeA5/GZtRxzoLqFAjLtBPjjUsGRY70NwBAoUyibh8uYdhBQXq04us+JLxAJfY78eo
         /oA0xIUOVzYXZibHwNVQrcGalZeKoFeN6pWZfGGQvjU/TDxtYxotxhApCWUCTrpEyo
         jvCEIe+EpuQdn10DZPMNAb7KX5CquRB4VjvwKJ7s=
Date:   Tue, 21 May 2019 09:57:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Dan Williams <dan.j.williams@intel.com>, od@zcrc.me,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: jz4780: Use SPDX license notifier
Message-ID: <20190521042713.GJ15118@vkoul-mobl>
References: <20190504213432.6356-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190504213432.6356-1-paul@crapouillou.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-19, 23:34, Paul Cercueil wrote:
> Use SPDX license notifier instead of plain text in the header.

Applied, thanks

-- 
~Vinod
