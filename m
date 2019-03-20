Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AEFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EA9218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553112760;
	bh=QhOO7jP0eURE/aVg3aB9twZMAOzjw1AVsuQcatciFdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GWVkcLhEY+FlPyM4jqwDsSm3KqgO5qsw5mgbMK4Ckb2TRuP5P/4u3JWNxlthKAOJL
	 f6gWuZknQagBsate7AKIdLTtkFcN9VdQX8z7o4u5TIdXp9flsWHqd3fJ4qEqIMeCRZ
	 lqxf1bHQIeV8ARK1z9QoVEAqGrUC84gE8KT82ca4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfCTUMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfCTUMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:12:38 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8F6A21873;
        Wed, 20 Mar 2019 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553112758;
        bh=QhOO7jP0eURE/aVg3aB9twZMAOzjw1AVsuQcatciFdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0SVFqVhFRC8n42j/c8x2jpMQVKtQfhYRvtdEids2HewbPVqt/58HbeRYYZOOADIKm
         P0zxmexdqoZstqfJnTEs3JY+0hJzw82REg4IsCkyYIfaImvrznbo/hxyJDqEanJQ6c
         KSFnE0wIQ22zhNBVMSHE9m4TYrvqrs5BXJPzcSjI=
Date:   Wed, 20 Mar 2019 21:12:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] parport: ieee1284: mark expected switch fall-through
Message-ID: <20190320201235.GA11793@kroah.com>
References: <20190212174318.GA22735@embeddedor>
 <4d221d8f-f4d0-90f7-dccf-3af67d4b0c53@embeddedor.com>
 <7b9bcd42-47fa-05cd-2e92-0124109f9aa2@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9bcd42-47fa-05cd-2e92-0124109f9aa2@embeddedor.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 03:06:04PM -0500, Gustavo A. R. Silva wrote:
> Greg,
> 
> Can you take this, please?

Will do, give me a week or so to catch up...

thanks,

greg k-h
