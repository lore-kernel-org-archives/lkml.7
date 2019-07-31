Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282D7C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D20208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564573335;
	bh=HB7/0BwaEc6sX68xTXz1CtQQ7wV3B9leYzhMeTEKT8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g0gPLOIwlGWGdj5dylwF0+Ys1yFv1hpYyc8wpxOfWyzgA9hPd6qu8DYVy8x4hBkBt
	 5en1H+gnDliGgQ69gGQoQhH26fJMlcdxd0DuOkN4zv0CrW7tr4GwnjBrrhl1Bz3rbj
	 mB3tcnYszddAouysa7WvpqOHOE/cXp7gw6nAbyLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfGaLmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfGaLmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:42:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1443D2089E;
        Wed, 31 Jul 2019 11:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564573332;
        bh=HB7/0BwaEc6sX68xTXz1CtQQ7wV3B9leYzhMeTEKT8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhsywEioejSN00UEopG6RZRGpzzCtCGjepv2uh53EF9BpHvvQIyBGdy3fHP1UU0yy
         H9otRSi1/0tKJpm+pfrYIX8g3foOmml8DJbaSMyjch0n2y3c+WL2S5TSZtkK+iV/nd
         2t84fxrvm6bBirJ3Tnb6mD7gD9GaVNkcHNIld+I0=
Date:   Wed, 31 Jul 2019 13:42:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sudheer v <open.sudheer@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [patch v4 1/5] AST2500 DMA UART driver
Message-ID: <20190731114210.GA18474@kroah.com>
References: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
 <1564147640-30753-2-git-send-email-open.sudheer@gmail.com>
 <20190730154759.GA26425@kroah.com>
 <CAE-5=DQ8p9WAhjrmZ8ye8GjoHrcxkHkjJPRNRFtvgeF5SdqwVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-5=DQ8p9WAhjrmZ8ye8GjoHrcxkHkjJPRNRFtvgeF5SdqwVQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 05:06:08PM +0530, sudheer v wrote:
> Hi  Greg,
>  After modifying [ patch v4 1/5 ] , should i submit whole patchset as  v5 ?

Yes please.

thanks,

greg k-h
