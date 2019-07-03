Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B30C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55530218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562181655;
	bh=MVMDN4XhcFLvLmPxXPdmheT8Fyttmv50Wohokop0BGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tD5MT/5PZ9k3m1lnIrzXz/TB+N/i1ZKkSVWBXji2kKfBClsk5wxY3MYUOWHm4qdPs
	 HCCxWSRi4WfTcBVFxEOfHST+2fnJQvKjdkff0A2nupGycF4o9olcywU3ufasWl4zq9
	 MPTdEVkhIgZ4zrvPNyvw1/xZ8Qf6rNrnearwHRyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfGCTUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGCTUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:20:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A989F218A4;
        Wed,  3 Jul 2019 19:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562181653;
        bh=MVMDN4XhcFLvLmPxXPdmheT8Fyttmv50Wohokop0BGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAgPd92vSwKyiHcRoLri86VtfD+vNXaulegJ1l00GuU3GvKuvWSWvmFXhRLOx0f/F
         VSe8sQL1g6ifls0rVtnVq+QG7u8xUyzrqqYfTqtxF4v6Y1cSqK5WEIa/Oxr6Dcnz6g
         CcdoPuMzzaKz8uBkLR0sPeYZp14dxW27QAmIG7Po=
Date:   Wed, 3 Jul 2019 21:20:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, corbet@lwn.net,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] driver core: node: Fix warning while make xmldocs
Message-ID: <20190703192050.GA20873@kroah.com>
References: <20190624035807.20628-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624035807.20628-1-standby24x7@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 12:58:07PM +0900, Masanari Iida wrote:
> This patch fixes following warning while make xmldocs.
> ./drivers/base/node.c:690: warning: Excess function parameter
>  'mem_node' description in 'register_memory_node_under_compute_node'
> ./drivers/base/node.c:690: warning: Excess function parameter
>  'cpu_node' description in 'register_memory_node_under_compute_node'
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/node.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Someone sent this patch before you did, sorry.

greg k-h
