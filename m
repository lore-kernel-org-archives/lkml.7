Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA77C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 07:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4187D2173C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 07:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565509882;
	bh=92tTRkyX6XNn8bPjK+nC4h0WKVoRxC7qPIcA/w90siQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OgXcNksJq+iJGnj1d+2eC/GMfCMWgdA9RR4zcb68xiAD5XpsW8WmEY1cr32c91HLB
	 bcIPi+ReaxmtUnwCux9cZGlgLWj1TobbhJoNfY8bME+y6l89RI7RW7GViDIW+Am38w
	 QrC8EIqhCt3gl7BtUBypQFFA9knKO6pbf30lA7Io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfHKHvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 03:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfHKHvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 03:51:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B55F216F4;
        Sun, 11 Aug 2019 07:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565509879;
        bh=92tTRkyX6XNn8bPjK+nC4h0WKVoRxC7qPIcA/w90siQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKkshs1XQ/Vq7zriEJ6wCZMITxpHTbpxARustYa9oCGpTAqFzWDYesRRoqTtdDzJq
         DCT4JaQpIzMkZBN6uM9VIgv6/RgtARIqmWcyPFCrzXax3xHsM4R0C+RFMFwGODW8J0
         lGVZILv2P32AeBA4UnpGAjJCetjsFASCu0m5v8lg=
Date:   Sun, 11 Aug 2019 09:51:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Subject: Re: [PATCH v2] habanalabs: print to kernel log when reset is finished
Message-ID: <20190811075116.GA6508@kroah.com>
References: <20190811074653.5655-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811074653.5655-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 10:46:53AM +0300, Oded Gabbay wrote:
> Now that we don't print the queue testing messages, we need to print when
> the reset is finished so whoever looks at the kernel log will know the
> reset process was finished successfully and the driver is not stuck.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
