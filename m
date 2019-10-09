Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F92EECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F11218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570607026;
	bh=3O5Wcz3zKEo1TVNtELtRVQvf1FMDmg54ohtzb9xhDxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=is0St1UrtbgjV6uhAw1zSlycDS2VouBkWBvn6nLq6+FmImFhUI9OL/6lFXJY8CakS
	 0d7w/0E7yI7x9KpkqnC3hb9rxig/EPZcGJr0HJdxRY9HRSCzoZzSu4e4A4LW+P710Y
	 xjAvCBPMWtfHeKaK+EBhxab1kU655b6ODIqZwb48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfJIHnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfJIHnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:43:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D8632133F;
        Wed,  9 Oct 2019 07:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570607016;
        bh=3O5Wcz3zKEo1TVNtELtRVQvf1FMDmg54ohtzb9xhDxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bW1s4aWeeUCU/jbutULR/ebaFW0qWN8lSJjPWOEUHc1qsblR1/BCAEMQN5zTZjBIJ
         Qzo1EHTLXRFiG5zWqYdpFJEbANRlulxiZxgwl0Uivb155213Z7KQ9COZ6I228fs7bb
         KdqDhOPcY6ostP5gU9s19k6FwQ2bjwiCbQbQ4EHM=
Date:   Wed, 9 Oct 2019 09:43:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chandra Annamaneni <chandra627@gmail.com>
Cc:     devel@driverdev.osuosl.org, gneukum1@gmail.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        linux-kernel@vger.kernel.org, simon@nikanor.nu
Subject: Re: [PATCH] KPC2000: kpc2000_spi.c: Fix alignment and style problems.
Message-ID: <20191009074334.GA3842746@kroah.com>
References: <1570593039-19059-1-git-send-email-chandra627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570593039-19059-1-git-send-email-chandra627@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:50:39PM -0700, Chandra Annamaneni wrote:
> 	Fixed alignment and style issues raised by checkpatch.pl

Why is this padded?

Also, you need to break this up into "one logical change per patch",
you can't "fix all style issues" at once, sorry.

Please fix this up and send it as a patch series.

thanks,

greg k-h
