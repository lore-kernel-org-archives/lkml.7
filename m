Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BB5C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A41C24673
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576487616;
	bh=cgHM6DQAmErnkkVt7OBcXZu3FlYGXPlMp7gPv2Cv7Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W3eY/suy9YTT2dmsm7ms/7CUSaCQFKytEDS5LJZXF5XHhhsY9SQk0mmKNDmjzZyKQ
	 AGZB76jRiuOCNfkP+HW2OpW82p551H99cbjji3szINQ627gT+GwWYB9gXscAV5Whl6
	 FEzJcgLMQPykdIUCgoGEMBnh0EgoX6Yep9LWHzl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLPJNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:13:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfLPJNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:13:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A8E8207FF;
        Mon, 16 Dec 2019 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576487614;
        bh=cgHM6DQAmErnkkVt7OBcXZu3FlYGXPlMp7gPv2Cv7Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkFDo1N4BBIRfy0hdsT9UtcNmFs0mM8qPONCVseTjC8+IGqpKrYVttb30MExvlXRw
         aGkn1StenW2puws/d7ZECFjSzooA5BCQZXfyecv3kOrc33KWBBaQjYr2aNJAsWLB+6
         KWWV1gGMhzO4EprautC845H4GYhJg7yffMLATqwE=
Date:   Mon, 16 Dec 2019 10:13:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.5-rc2/3
Message-ID: <20191216091332.GA1164705@kroah.com>
References: <20191214133154.GA8663@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191214133154.GA8663@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 03:31:54PM +0200, Oded Gabbay wrote:
> Hello Greg,
> 
> This is habanalabs fixes pull request for 5.5-rc2/3.
> It contains two minor fixes, nothing too exciting.
> 
> Thanks,
> Oded
> 
> The following changes since commit 16981742717b04644a41052570fb502682a315d2:
> 
>   binder: fix incorrect calculation for num_valid (2019-12-14 09:10:47 +0100)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-12-14

Pulled and pushed out,t hanks.

greg k-h
