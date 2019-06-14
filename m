Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8963DC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60688217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 05:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560491708;
	bh=kA/jnDLW9rkW9ntOAESoxVgQ4iuedrT2mhtDZqkxsqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OQ5I6ClAjQnv7bZenTJllM5Vw6gX3AkGRCJOY+36YA57HrN4RiPilJua+/5DLgpol
	 UmrMddVBnhtuTLTD8WglbtCe3WAz+Lbqx848mm1MCL9gVpH8OrxctfvsqTehaPXCn1
	 mGosHvyf/zjkyGpK8xEMg6mm5HcFUboqMCEGHssY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFNFzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 01:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNFzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 01:55:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3FA21473;
        Fri, 14 Jun 2019 05:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560491705;
        bh=kA/jnDLW9rkW9ntOAESoxVgQ4iuedrT2mhtDZqkxsqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2hPX8JbXFboXW6NuGbaTcYzvXF96aCHSJJ1GeA+zQKKbCUj1vzn1B00KY2PJlME5A
         kfOP80XnOtd1xtWRwJyF58VHFZZgJ9o8C/Lq8LRu3JC4XnGWl5b55CofUgfZTaRowY
         kqqEjUAw9hGYWqi1Z894Yx8bkrotzY4Dp/9XZVQg=
Date:   Fri, 14 Jun 2019 07:55:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dma: amba-pl08x: no need to cast away call to
 debugfs_create_file()
Message-ID: <20190614055503.GA1011@kroah.com>
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
 <20190614054613.GB2962@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614054613.GB2962@vkoul-mobl>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:16:13AM +0530, Vinod Koul wrote:
> On 12-06-19, 14:25, Greg Kroah-Hartman wrote:
> > No need to check the return value of debugfs_create_file(), so no need
> > to provide a fake "cast away" of the return value either.
> 
> Applied all after fixing the subsystem tag (dmaengine), thanks

Sorry about that, and thanks!

greg k-h
