Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2DCC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C37C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576487072;
	bh=JZKi27/ADaNAzPibrndV9zbPjqCG/CF7QSyH9Sw9OOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=euzupZZJAhRlcr7bqxfovwplPm7u4UgJFVTSaeBs9USukuqDr2d66lUuck8Gtuee2
	 V0q+mm4FF6klY85kDsn23lm2eauvauVnHola8UBNkUI5XUAETpN/KxLPLKCCaajXLQ
	 a36X+IeoVYhIXcOZC26pc735zvAq+G8X3FrXPKqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfLPJEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfLPJEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:04:30 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B95320725;
        Mon, 16 Dec 2019 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576487070;
        bh=JZKi27/ADaNAzPibrndV9zbPjqCG/CF7QSyH9Sw9OOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBify21WH5NuGIv32G3ec1YFei8ezros3sCjbqD0guUjT1sUfjxBuABgAmXTRt73S
         qTbAb4L8PChAfeJCMXgxYCF4dM2muGBeKIN6un2odFUdRJBnSmASyAZFrZQbx1s2N+
         bRF9pdjeNMi0qNqL41bG04Ck4uVyBkKx4YoU3D+E=
Date:   Mon, 16 Dec 2019 11:04:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     info@metux.net, linux-kernel@vger.kernel.org, jchapman@katalix.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH] net: l2tp: remove unneeded MODULE_VERSION() usage
Message-ID: <20191216090426.GA66555@unreal>
References: <20191212133613.25376-1-info@metux.net>
 <20191212.110354.354662228217900367.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212.110354.354662228217900367.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:03:54AM -0800, David Miller wrote:
> From: "Enrico Weigelt, metux IT consult" <info@metux.net>
> Date: Thu, 12 Dec 2019 14:36:13 +0100
>
> > Remove MODULE_VERSION(), as it isn't needed at all: the only version
> > making sense is the kernel version.
> >
> > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
>
> Is there a plan to remove MODULE_VERSION across the entire kernel tree?
>
> Where is that documented?
>
> Otherwise what gave you the reason to make this change in the first place?

Dave, see this conversation which I had two years ago with positive
responses from many respectable developers.
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2017-June/004421.html

Greg's response:
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2017-June/004441.html
Linus's response:
https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2017-June/004426.html

Thanks

>
> No context, no high level explanation of what's going on, so it's hard
> to review and decide whether to accept your change sorry.
>
> At the least, you will have to write a more complete commit log message.
