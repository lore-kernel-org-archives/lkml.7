Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C90C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385C32133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfCRRnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:43:00 -0400
Received: from ms.lwn.net ([45.79.88.28]:50968 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfCRRm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:42:57 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 659252B4;
        Mon, 18 Mar 2019 17:42:56 +0000 (UTC)
Date:   Mon, 18 Mar 2019 11:42:55 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] Convert vfs.txt to vfs.rst
Message-ID: <20190318114255.389851d3@lwn.net>
In-Reply-To: <20190318033430.GA27728@eros.localdomain>
References: <20190313040919.6937-1-tobin@kernel.org>
        <821449c9-e1f7-caa1-ff18-0cc1cc625596@infradead.org>
        <20190318033430.GA27728@eros.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 14:34:30 +1100
"Tobin C. Harding" <me@tobin.cc> wrote:

> > What does this patch set apply to?  Maybe Jon's git tree?  
> 
> I did this on top of Jon's tree before rc-1 came out (so during the
> merge window last week).  I can rebase and fire off another version if
> its easier for you Jon.

If you could do that, actually, and poke in Randy's Tested-by tag while
you're at it, I would appreciate it.

Thanks,

jon
