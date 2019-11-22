Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24D7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C703920730
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421305;
	bh=ifgfHgV49YcPx8kfrpEB/pTuXJnJCq8CYBm1IT5+Mr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Deyt+pv9rjPtRXhrueSLKD97GF+h2YOgL3vioDRr43FJxdyWmvQ66ZfbeoQqjWYYY
	 NXymsRGeBrnXAYyUlBL/fS7BZG/LlfKKEDQCAez7nxvkbzfD4Y8S09Ofh2uVUCkY9w
	 2gAAT9zkpfRsOY/2oPWtoK4iIT+OnxRRWbCC6gvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbfKVLPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729023AbfKVLPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:15:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F742070E;
        Fri, 22 Nov 2019 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574421300;
        bh=ifgfHgV49YcPx8kfrpEB/pTuXJnJCq8CYBm1IT5+Mr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=akcMeEEhNVQ1VdQfaigVjxBzNeeZwSIJS1+1WdyTMuyOfJwvUl+RA70E5BxdkSi9O
         dNWDFFc8AYEOpSzAcL1aykduSR2aj+5t/mNJGt9iqCH2+C960sUq/wJkBYHRlVfVx6
         uWX20twpjKgKAJRl4HqUv0QDR+84V0Qw5QQY5cEE=
Date:   Fri, 22 Nov 2019 12:14:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] {tty: serial, nand: onenand}: remove variable 'ufstat'
 set but not used
Message-ID: <20191122111410.GA2024666@kroah.com>
References: <1574421159-113624-1-git-send-email-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574421159-113624-1-git-send-email-chenwandun@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 07:12:39PM +0800, Chen Wandun wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/tty/serial/samsung_tty.c: In function s3c24xx_serial_rx_chars_dma:
> drivers/tty/serial/samsung_tty.c:549:24: warning: variable ufstat set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

Your subject line is really odd, can you please fix that up and resend?

thanks,

greg k-h
