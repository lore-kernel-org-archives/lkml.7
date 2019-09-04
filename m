Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930A0C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B772339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567581405;
	bh=f8EZZerqx22BqB3RzsXbmB/o3MYtSOE4T3XPD3UXaF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oeqSMhtRBNKz/vhi3R4dFB1xn8EyIoq8LFJaikTlQKpu/z/FPGSn8YwN18ToNHTv7
	 cTYi8K+mN/c5AT1oGgiQt2psVaiRxHlJfdZP0eHfTlNCZitmulpG0ATKVdgsHKX7E4
	 sRfkpEAZt0CUYbPBj8zk07LA6Kqom2MDUjUgf1tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfIDHQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfIDHQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:16:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F4972339D;
        Wed,  4 Sep 2019 07:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567581403;
        bh=f8EZZerqx22BqB3RzsXbmB/o3MYtSOE4T3XPD3UXaF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOH9JjFruJCTTp6kIevTzvliq7OO6RNlAwGbxMUKh1HPeKn6iGeK7F5qysATWd/MA
         1mb63cLoc7GFYiZaVbE4/QFb6uqSKTiUUfrZIN+fcJN00gJCbVebCy7ZfVliaTw2fX
         C1F/6C8502bHkcoajUicecgDdGdYoCHK8gGfazwg=
Date:   Wed, 4 Sep 2019 09:16:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        arnd@arndb.de, jeyu@kernel.org, joel@joelfernandes.org,
        lucas.de.marchi@gmail.com, maco@android.com, sspatil@google.com,
        will@kernel.org, yamada.masahiro@socionext.com,
        linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4 09/12] docs: Add documentation for Symbol Namespaces
Message-ID: <20190904071641.GD18791@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190903150638.242049-1-maennich@google.com>
 <20190903150638.242049-10-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903150638.242049-10-maennich@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:06:35PM +0100, Matthias Maennich wrote:
> Describe using Symbol Namespaces from a perspective of a user. I.e.
> module authors or subsystem maintainers.
> 
> Signed-off-by: Matthias Maennich <maennich@google.com>

Nice, it's good to have stuff to point people at.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
