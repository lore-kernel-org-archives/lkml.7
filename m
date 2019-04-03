Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED86C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF8820882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554299957;
	bh=jvJ0rx7NpWT/hsZ3mJlQC3RoTkCD8aVPahBFWLHILp4=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=imNGN/hiBvGRoCiC4zmjgKAVVZtSYnt0pwXprWBW1t8K3c7WFhAVEjzIj66jWInP1
	 0yFM9PsrTN5c9WnVBJJzwyhpCCWIq4TvBzXkDDtE4Rp//wOepbbXueoxbua4kKZXK0
	 B4oRCU2xXb0iUSb3NvVDzs9G/kC52zQog7u0qQQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDCN7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDCN7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:59:15 -0400
Received: from localhost (217-101-180-136.cable.dynamic.v4.ziggo.nl [217.101.180.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E0532075E;
        Wed,  3 Apr 2019 13:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554299954;
        bh=jvJ0rx7NpWT/hsZ3mJlQC3RoTkCD8aVPahBFWLHILp4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=HYcrFO7luVjGOhkwXs9+QAiUOaoaKmhaCBJNIuFXJOpn1JxU6LEmopp5lEb3B+Ah7
         ZgQNOC0KI8vks+8jEa2sCfKYz3tukdkRNhEZv1AwUq7a/LfSgBf2LCbtgsXj7NJqsm
         lH5e1ynorEKwKmMTbb7W6musF8CrfifjbvHlSgXI=
Date:   Wed, 3 Apr 2019 15:59:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Theodore Ts'o <tytso@mit.edu>, Jari Ruusu <jari.ruusu@gmail.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 file system livelock and file system corruption, 4.9.166
 stable kernel
Message-ID: <20190403135912.GB8633@kroah.com>
References: <CACMCwJ+qLHV+cjQC2kAnLQP6qVz1bJ75V8BqQBV5HE1edRC-AQ@mail.gmail.com>
 <20190402103507.GA15511@kroah.com>
 <20190402161558.GA2781@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402161558.GA2781@mit.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 12:15:58PM -0400, Theodore Ts'o wrote:
> On Tue, Apr 02, 2019 at 12:35:07PM +0200, Greg Kroah-Hartman wrote:
> > So you need 5e86bdda4153 ("ext4: cleanup bh release code in
> > ext4_ind_remove_space()") applied to all of the stable and LTS kernels
> > at the moment (as that patch only showed up in 5.1-rc1)?
> > 
> > If so, I need an ack from the ext4 developers/maintainer to do so.
> 
> Acked-by: Theodore Ts'o <tytso@mit.edu>

Thanks for all of the responses here, patch is now queued up.

greg k-h
