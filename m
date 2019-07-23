Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD68C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD91D2239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563880609;
	bh=AdX4oB9t9mKVESg1WfxiSQ/A+oPDYrbD+GAC8Ag/gUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RTi74wxotDB10vKnYiB0SZSWb1wevbjigDgII/x1yRyafotIXAec5M1Xl/qUQSQu1
	 bUFu1V0nYM9AuPEVpKgWl9OCfia3JQv8IbL9YLiHD7tCvKV9A643IiYSG4YCd0cDvn
	 8g3FpikAxpTSKflUR3M2/0DC9NpXT47qStxFIqgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbfGWLQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbfGWLQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:16:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 652F82239E;
        Tue, 23 Jul 2019 11:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563880607;
        bh=AdX4oB9t9mKVESg1WfxiSQ/A+oPDYrbD+GAC8Ag/gUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7gA5bhmnCvLN66fqFX7z4VM/wym4Uc1172zf3hhFBFBMXnTaB52S+BJ8p8Iyoj4K
         iJXxyaV3KzniV5AH9NZ+s2CAkd4y9JOyOQth91wMOVdU+Dpu4gFR2A31TL2lm0sOB0
         FjtQ90T3Uhj41V6FUHPb1Ibk4t86bVVTWSGGjdkk=
Date:   Tue, 23 Jul 2019 13:16:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-stable <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.19] kconfig: fix missing choice values in auto.conf
Message-ID: <20190723111645.GA17396@kroah.com>
References: <20190723110936.13159-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723110936.13159-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:09:36PM +0900, Masahiro Yamada wrote:
> commit 8e2442a5f86e1f77b86401fce274a7f622740bc4 upstream.

Now queued up, thanks!

greg k-h
