Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDCDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1607F213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552424018;
	bh=DqXy5Tw6EMnx2EWt8td2OZZbYFjTPfb/HHwNTXXzdOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UOp23leeOiR4foJciCyWWEul7P+v5aA5pcJ6+5GkWpFhb92UUidT2COAxe/7W/I8m
	 B9sQbozqSjOzi7lFSDoulAAIYFJQJZwIvQP426JIICHkM3MVVg4TW1Ir6Xy+E5KOWO
	 ZjgS9uCxVQc4Q1hmTwT5qy1qIuBqw0VdjwG8YMtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfCLUxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:53:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLUxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:53:36 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 595BBD9D;
        Tue, 12 Mar 2019 20:53:35 +0000 (UTC)
Date:   Tue, 12 Mar 2019 13:53:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop -Wdeclaration-after-statement
Message-Id: <20190312135334.9dca95d348bb6c0fdc869fe9@linux-foundation.org>
In-Reply-To: <20190312201853.GA9013@avx2>
References: <20190310133535.GA20473@avx2>
        <20190311173845.53c2e4e4d2257a3701fa2033@linux-foundation.org>
        <20190312172447.GA10166@avx2>
        <20190312125017.b1f5af3350434ca05b5fe35e@linux-foundation.org>
        <20190312201853.GA9013@avx2>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > It is not good in my opinion to stick to -Wdeclaration-after-statement.
> > 
> > Why?
> 
> It is useful to have declarations mixed with code.

Am inclined to agree.  Maybe.

> Once kernel will switch to C99 or C11 it _will_ be used to the point of
> requiring it on the coding style level. The superstition of declaring
> everything in the beginning of a function will fall, so might as well
> start earlier.

Sure, it's a matter of kernel coding conventions.

But this isn't the way to get those changed!  The process for making such
changes involves large numbers of people arguing at each other (perhaps
at kernel summit) until Linus comes in an tells everyone how it's going
to be.

