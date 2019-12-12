Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AB6C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB23C2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576148991;
	bh=+GFNXfvIWLY+SyoBzCk2uPC4c9BxTnXM+rB6AmqcWi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cNee1P9U0kdcNcmsNeLrSU+YLFtPNNjfLdzHAv6wHboSHJmFTJ/NyNR2cMk9W5xEB
	 glqT0nwp63NsVuIQZWb+2xqvSwoF37X/2s+LcEAOmEA2WliaOtO0oyFu78xfT20uwM
	 WxETKK8FbJ9eD7x/3ECk7YxZDbHthnNKVPNL6OZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfLLLJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:09:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbfLLLJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:09:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1CC32173E;
        Thu, 12 Dec 2019 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576148987;
        bh=+GFNXfvIWLY+SyoBzCk2uPC4c9BxTnXM+rB6AmqcWi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ir9rKrBJyZLhcb8cL8S3osHkFAebLn3LOLLxEQn1GXzulDC+tR9ZhMDLVa+m29V22
         AVEnnsapucoGJ0KWTtnniU0FFfkEwfuH/lq28WJAze2KDaN7zacX8dP894EdRi3IOU
         85Um7jiHOB6+SUWWV+gg+qtGjU88vV0wqKqVwY5Y=
Date:   Thu, 12 Dec 2019 12:09:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] tty: serial: samsung_tty: fix blank line
 checkpatch warning
Message-ID: <20191212110944.GC1490894@kroah.com>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-10-gregkh@linuxfoundation.org>
 <20191210151345.GI11222@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210151345.GI11222@pi3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:13:45PM +0100, Krzysztof Kozlowski wrote:
> On Tue, Dec 10, 2019 at 03:37:06PM +0100, Greg Kroah-Hartman wrote:
> > checkpatch is giving a bunch of:
> > 	WARNING: Missing a blank line after declarations
> > messages on this file, so fix up all instances of that issue.
> 
> I would prefer to squash it with previous. These are not bugs, just
> minor coding style violations so there is no point to split it per
> patch. Too much churn.

For coding style fixes, in staging, I require "one type of change per
patch" otherwise big "fix all the coding style issues" patches are
impossible to review.

Breaking it up into tiny pieces makes it easy/trivial to review, which
makes it easier for maintainers, which is the key here.  There is no
"churn".

thanks,

greg k-h
