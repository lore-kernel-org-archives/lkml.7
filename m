Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E481C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781B92073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfDONpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:45:24 -0400
Received: from ms.lwn.net ([45.79.88.28]:59816 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfDONpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:45:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 328F52D6;
        Mon, 15 Apr 2019 13:45:21 +0000 (UTC)
Date:   Mon, 15 Apr 2019 07:45:20 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the jc_docs
 tree
Message-ID: <20190415074520.4ca92d50@lwn.net>
In-Reply-To: <a01e1602-3e82-f118-5fe4-1572647c06f9@linux.alibaba.com>
References: <20190412110518.46e329af@canb.auug.org.au>
        <20190415110902.41c3c201@canb.auug.org.au>
        <a01e1602-3e82-f118-5fe4-1572647c06f9@linux.alibaba.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 09:55:31 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> > This is now a conflict between the net-next tree and the jc_docs tree.  
> Sorry, Stephen, What I can do for this?

What you can do is to not worry.  A trivial conflict like this is easily
handled when everything goes upsteam.

jon
