Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99050C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A50B20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554374481;
	bh=UD3xgcf74DYSS+bdTgxJwl6LTh89wbG7DlaqaG4+Dkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hyCzXgmNCzwb4TQW0W5F+fYq1oEZOHwu89aXHRvJPEmJGhPHUatkPk1oM3zHy+Fv9
	 gDqZlFAax8H9+bjh9R+NA1K8LvxnYWROWndtTgxEjpTQirp+XKWW8k9h+CfhwKV3gQ
	 nNTQBCOHimSZfQPRRnzz+essFBPxV9OB2UAqJQwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfDDKlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDDKlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:41:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE4BE20820;
        Thu,  4 Apr 2019 10:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554374479;
        bh=UD3xgcf74DYSS+bdTgxJwl6LTh89wbG7DlaqaG4+Dkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5rmFiH0BgcWTynuZKWn4iDv07QUv0s3+XMk1uaqfJ2NvdIHlCGfsrg0FmSvVwTLK
         VG3O2uHWEFrPgdIkTYVMmVCtM8xnKahquRQnWqJTHfYsDQwZu4sOv/jDDW+3EUrBIk
         dbWOzFAj3p4KdcttTXtB3BIsOeKBljeEDaD01Khs=
Date:   Thu, 4 Apr 2019 12:41:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.0 070/246] kbuild: make -r/-R effective in top Makefile
 for old Make versions
Message-ID: <20190404104111.GA17018@kroah.com>
References: <20190404084619.236418459@linuxfoundation.org>
 <20190404084621.593150895@linuxfoundation.org>
 <CAK7LNAS5qfvnZEGKVQpqdQz3EOj88bd4qLc4bqcUDMhSVpJQmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS5qfvnZEGKVQpqdQz3EOj88bd4qLc4bqcUDMhSVpJQmw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 06:16:37PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> 
> On Thu, Apr 4, 2019 at 6:11 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 5.0-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > [ Upstream commit 3812b8c5c5d527239ac015f1f2c7654da7fcfbba ]
> 
> 
> Some people complaint about this commit.
> 
> If you backport this,
> could you please backport the following two as well?
> 
> 2b50f7ab63685cd247e32ad321f7338ed130d3d5
> 688931a5ad4e55ba0c215248ba510cd67bc3afb4

Now queued up, thanks!

greg k-h
