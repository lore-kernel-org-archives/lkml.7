Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4810BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1717D21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553066653;
	bh=iYMkxaaY4EAzGgmmBwy9jHXzQfoY8EYeDnz3SGGiMWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iE2IdSTZhCkXv+mPf6MiLia9toXiq5LwlbnZIqBxihKmsL6broRJ6AeOB/hwfHMhT
	 jMYqMa5BKIb6oJj1nhtyEtCFlc+xRMceIzdfelNFZx1lZHcuCTSrwuuPBDizYM0Jm+
	 KBByJmtcLnFi5/U067hN6TQRu/lxixrwQy/ejF4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCTHYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfCTHYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:24:11 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4A221841;
        Wed, 20 Mar 2019 07:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553066650;
        bh=iYMkxaaY4EAzGgmmBwy9jHXzQfoY8EYeDnz3SGGiMWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUJmJ5zRZHKfgsIQaTUU6sArswaFRWq+24Mbgl0qbIFoMRW2i53M9n1kFDSu1EhF+
         z8NiM13rQRTsvqNQVK7eYqCyn+yvMOfHSNHVqYHuCePAg3ntzNs5HZzF/7GmtSu0SD
         0KVKABlYNnEJrgWV1vE/61eGnNhW/EhJ3uBrZgCo=
Date:   Wed, 20 Mar 2019 08:24:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     devel@driverdev.osuosl.org, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] staging: rtlwifi: rtl8822b: fix to avoid NULL pointer
 dereference
Message-ID: <20190320072408.GC2647@kroah.com>
References: <20190319202127.16692-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319202127.16692-1-pakki001@umn.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:21:25PM -0500, Aditya Pakki wrote:
> skb allocated via dev_alloc_skb can fail and return a NULL pointer.
> This patch avoids such a scenario and returns, consistent with other
> invocations.
> 
> ---
> v1: Patch collision with rtl_phydm.c, fix as per Greg
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

And here as well, please put above ---

