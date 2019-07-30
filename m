Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A02FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8DA2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564471208;
	bh=9y/PgAzXo/m4joi54xT8C0Iz0DdA8XYDsZHcV0xUO/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p+cDPrVqF8llX9+UqtJm10JZsa0fa7+YNn0yyB8WaXvf0qOOqflJNgesIBYTvWp/5
	 Yx8cBWLldKell/p+f2ZFWLDf8W7IalMMvxX5nTbUtjH3vps+9LuOWGCZCPpdE0mDRg
	 273m0QBNP40Mm68KOXMV685XUktd+5AfC/6K9Dbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfG3HUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbfG3HUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:20:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47BE8205F4;
        Tue, 30 Jul 2019 07:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564471205;
        bh=9y/PgAzXo/m4joi54xT8C0Iz0DdA8XYDsZHcV0xUO/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdwyT9ZG7X9tDjx/BvLfCtHEWCuoh0oEvIRDutVVHHYuqo4FMoW7f4cjet4QQHQ1Y
         Pyu0SYue2LwM4uZG8/c6zuyy076SrXJYnKcEViTbzumnG/beEhJFGWZuFQOvKYOnF3
         0ISVore9s6e7RACEyqeWKiBMFsIZVKWf6wkxbX0A=
Date:   Tue, 30 Jul 2019 09:20:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 01/22] staging: erofs: update source file headers
Message-ID: <20190730072003.GA31548@kroah.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-2-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729065159.62378-2-gaoxiang25@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 02:51:38PM +0800, Gao Xiang wrote:
> - Use the correct style for all SPDX License Identifiers;
> - Get rid of the unnecessary license boilerplate;
> - Use "GPL-2.0-only" instead of "GPL-2.0" suggested-by Stephen.

Note, either tag works just fine, they are identical.  I'll take this,
but just be aware of this in the future please.

thanks,

greg k-h
