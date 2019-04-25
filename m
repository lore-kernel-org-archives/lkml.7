Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D6DC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF33A20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556224616;
	bh=D/aetGspEa4iKmE1wZ5Oa7qv24S1Ji/rM7c4P7rrzlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PoJzsfWQPQCuhLQYng8Q5p/I5UTJMLAEl6dlRaDKvfoC6aXke4u4hWnkSB4p4IP0O
	 OJiIpQE3NI6X9b0Jiu5oeg3M0PQ0wpuaURKfEOLf16w8ytAUF2lUWkSUxtXoyoxyaR
	 TPrt5XrWtazn/Bv6wLbd8WGM076HdCj9bFa6yaxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbfDYUgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387662AbfDYUgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:36:55 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64246206A3;
        Thu, 25 Apr 2019 20:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556224614;
        bh=D/aetGspEa4iKmE1wZ5Oa7qv24S1Ji/rM7c4P7rrzlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTcaFAeFpvxaIwIUX+wT+bBpOHkOlF5lyrDATkb1VqSkh9bSV+FsQGVW+OTpWTpWS
         24SXORQtHKat5MTx2PUhePxzaYwIuvjrQVBXHDDyAZnp2vb8DS34YvR+DVQs8BFKXr
         ZCLzQPn3mtSHxAY3Tx4EhupAgc9B3VucUTUPDFN8=
Date:   Thu, 25 Apr 2019 22:36:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Patrick Venture <venture@google.com>
Cc:     arnd@arndb.de, joel@jms.id.au, andrew@aj.id.au,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arm@kernel.org
Subject: Re: [PATCH] fixup! drivers/misc: Add Aspeed P2A control driver
Message-ID: <20190425203652.GA23304@kroah.com>
References: <20190425202347.83880-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425202347.83880-1-venture@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 01:23:47PM -0700, Patrick Venture wrote:
> Fixup compiler warnings:
>  - 108 warning: ISO C90 forbids mixed declarations and code
>  - 264 warning: unused variable 'value'
>  - 335 warning: unused variable 'res'
> 
> Signed-off-by: Patrick Venture <venture@google.com>

Reported-by: kbuild...

I'll go add it, next time please do it yourself.

thanks,

greg k-h
