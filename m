Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC8C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A20620868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555456724;
	bh=uAXe995f1+iiXcph6HwaL9wB4vcKhdPNuaoF6O+GOaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RWjf1bzzXx5d9Hjti6Fcq0hCjmIyms8rkr9CoLuh3kJ9kfcjuoAcvUzJHbX08umW8
	 BTyeB7KFO0yXFTdMXGgxIPv9WyqXpRT0/XBTbj2zJYC/hLrPDE3P8Fq5t6uw7/RDBS
	 7sYjqt2sJrQzA44WAIUI5ZLQAWpM+EHImv5ILn6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfDPXSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:18:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDPXSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:18:42 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8A8BFD90;
        Tue, 16 Apr 2019 23:18:41 +0000 (UTC)
Date:   Tue, 16 Apr 2019 16:18:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Oleksiy.Avramchenko@sony.com, Dan Streetman <ddstreet@ieee.org>
Subject: Re: [PATCH 0/4] z3fold: support page migration
Message-Id: <20190416161840.c54f8fce7557e24fe0922338@linux-foundation.org>
In-Reply-To: <b86e6a5e-44d6-2c1b-879e-54a1bc671ad3@gmail.com>
References: <b86e6a5e-44d6-2c1b-879e-54a1bc671ad3@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 17:32:12 +0200 Vitaly Wool <vitalywool@gmail.com> wrote:

> This patchset implements page migration support and slightly better
> buddy search. To implement page migration support, z3fold has to move
> away from the current scheme of handle encoding. i. e. stop encoding
> page address in handles. Instead, a small per-page structure is created
> which will contain actual addresses for z3fold objects, while pointers
> to fields of that structure will be used as handles.

Can you please help find a reviewer for this work?

For some reason I'm seeing a massive number of rejects when trying to
apply these.  It looks like your mail client performed some sort of
selective space-stuffing.  I suggest you email a patch to yourself,
check that the result applies properly.



