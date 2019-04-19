Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14801C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F8921736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555702671;
	bh=q2jfCBmfZMQSBrXXUgFxRTNdSTHqV46wBgVJZACn5UA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bOtDoTM8qvm2OAVuznkz9Pg8CuuZk9gAA5zEpMSyatw1Fof7HD6PfWn4k3/k7WxHv
	 cPZOIeYRu2dLYDkL8mG4I9rcUtK6q3z8XLQtRLHIEQBtAvtLdHsmSFiVFiSzgc4ORK
	 LOKptTZb6rBtfx0AiYhytIF6cFrrV4z5zgI1E2X0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfDSThu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfDSThu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:37:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B1232171F;
        Fri, 19 Apr 2019 19:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555702669;
        bh=q2jfCBmfZMQSBrXXUgFxRTNdSTHqV46wBgVJZACn5UA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E48tLVZsgDQlM755+PWXKz+rXlefZDlvX1RkRSZ7C6fJ8t0wFSY1zpzAYgES3+Dkd
         vZelgQ5Im7nHoXDGxydmPQRwHf97+beuvlSIG4UK8EUYxhO1n1vrAg0fDYgdntlkc2
         VmLVxTed34ujIeU3d9mkC+EJO7ozm7IPUAUKowiM=
Date:   Fri, 19 Apr 2019 21:37:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     crag0715@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hayeswang@realtek.com, mario_limonciello@dell.com,
        "Crag.Wang" <crag.wang@dell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Glass <sjg@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        David Chen <david.chen7@dell.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Charles Hyde <charles.hyde@dell.corp-partner.google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/1] r8152: sync sa_family with the media type of network
 device
Message-ID: <20190419193747.GA29188@kroah.com>
References: <20190419084547.26220-1-crag0715@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419084547.26220-1-crag0715@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 04:45:46PM +0800, crag0715@gmail.com wrote:
> From: "Crag.Wang" <crag.wang@dell.com>
> 
> Without this patch the socket address family sporadically gets wrong
> value ends up the dev_set_mac_address() fails to set the desired MAC
> address.
> 
> Change-Id: Ib48a303730bee81667a2859be32e48cc8a66f277

No need for this line here, I don't think you ran checkpatch.pl on your
change before sending it out :(
