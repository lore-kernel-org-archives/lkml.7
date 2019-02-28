Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5375FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183CF20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367456;
	bh=lFZpZabLIkW1w9/bdoqJvKtAYrJqMAbo/gUxTuReLfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QtUAp2n0rTav2yCsdl557KsZElTDicf2gyqYA9c4haA0MdTocn5C44hfsTtwc65Bx
	 8ETShlbf6KFJ6tYNJvDQyhPL3M7yi0SOGoXNKnCDDWfQNHNx9kNrqXmKcqFiElq7FL
	 N4P89RiF+4BsRSxzMrt7d5cY0PjK5wzyHDry7zVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbfB1PYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:24:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731079AbfB1PYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:24:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E71220C01;
        Thu, 28 Feb 2019 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551367449;
        bh=lFZpZabLIkW1w9/bdoqJvKtAYrJqMAbo/gUxTuReLfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VaWRW12lw/E4Gl2zimLq6FAJuLqb0l9uzNZFcvXg4rMeQOrf+VdpRW59W0rtayRZe
         G/i/U42Js6DYjq5rGwg/VHfc9BmvkiI0dMu9RmVzWhZgjMsYOyhes7SWKxyLOjer+p
         LWJg/J8sXXD2HKXsiGx3pbvRnDibUHz8Xl3k9BxQ=
Date:   Thu, 28 Feb 2019 16:24:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        devel@driverdev.osuosl.org, Martijn Coenen <maco@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH AUTOSEL 4.20 36/81] binder: fix
 CONFIG_ANDROID_BINDER_DEVICES
Message-ID: <20190228152407.GB8481@kroah.com>
References: <20190228150813.10256-1-sashal@kernel.org>
 <20190228150813.10256-36-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228150813.10256-36-sashal@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:07:28AM -0500, Sasha Levin wrote:
> From: Christian Brauner <christian@brauner.io>
> 
> [ Upstream commit 793c8232937610ae00bc174b87d7fc324346eaea ]
> 
> Several users have tried to only rely on binderfs to provide binder devices
> and set CONFIG_ANDROID_BINDER_DEVICES="" empty. This is a great use-case of
> binderfs and one that was always intended to work. However, this is
> currently not possible since setting CONFIG_ANDROID_BINDER_DEVICES="" emtpy
> will simply panic the kernel:

There is no binderfs on 4.20, so this patch is not needed on anything
older than 5.0.

Please drop it from your queues.

thanks,

greg k-h
