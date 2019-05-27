Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB09DC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ED42184C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfE0PQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:16:11 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43893 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfE0PQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:16:10 -0400
Received: by mail-vs1-f66.google.com with SMTP id d128so10748822vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 08:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=heet0m6Ukj+33b2NagEJ1JJTF1aKH9z8EpwuLwTu/OQ=;
        b=m1L+HUQY3zjOxFKyvnMJEwe7gWIN8gPEl/wLr2+EixkYLWfPG5zp8j7r+uIWo94t+f
         ImEOxTurV7ElGD/XyScSYlLEzV6HJ5XvDjJDsFPCTGxSSlC8fCUu/aM4dJv1gw9+JRof
         Y5GuCFdxW0fXNNPnGq3Gf/vWkhzEp06TDCArWA2v35DxnZFJrtOh/WQmvijSRuGhzoSz
         OnPWKyZlRK1XEf/91wIBDTc8KUGuYJyBm5hpgAiNZMweL7hDpnHu2i1PNhaZYJ5+KAqS
         dMMDFaR1mip/2rMv4e3Kg3TTOrUJH02BWhbQXWeKqzvRafwLMqvcmEom/LF/3H6y7pMa
         7AsA==
X-Gm-Message-State: APjAAAX5p1DJFX7ZsT80kFxY2g7CrgFMGNuM75CMJRzTBzbAhnenAmTL
        V3K+z6+ouklHd4iTs7l4YiYN+g==
X-Google-Smtp-Source: APXvYqwdocOBlSnSfjGW16mOwDjdvYrUJdZr/e4ckXAUFLa4aZzP1mqKzP5SKIqb6K/ssLhgARGs/Q==
X-Received: by 2002:a67:fa48:: with SMTP id j8mr47163404vsq.143.1558970169731;
        Mon, 27 May 2019 08:16:09 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net. [100.0.197.103])
        by smtp.gmail.com with ESMTPSA id s65sm15219005vkd.36.2019.05.27.08.16.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 08:16:08 -0700 (PDT)
Date:   Mon, 27 May 2019 11:16:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>
Subject: Re: linux-next: manual merge of the vhost tree with the iommu tree
Message-ID: <20190527111543-mutt-send-email-mst@kernel.org>
References: <20190227152506.4696a59f@canb.auug.org.au>
 <2370af99-9dc1-b694-9f1c-1951d1e70435@arm.com>
 <20190227085546-mutt-send-email-mst@kernel.org>
 <20190228100442.GB1594@8bytes.org>
 <20190512131410-mutt-send-email-mst@kernel.org>
 <20190527092718.GC21613@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527092718.GC21613@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 11:27:18AM +0200, Joerg Roedel wrote:
> On Sun, May 12, 2019 at 01:16:26PM -0400, Michael S. Tsirkin wrote:
> > Joerg, what are we doing with these patches?
> > It was tested in next with no bad effects.
> > I sent an ack - do you want to pick it up?
> > Or have me include it in my pull?
> 
> I'd prefer it in my tree, if you are fine with the spec.
> 
> Regards,
> 
> 	Joerg

OK let me just check spec status.

-- 
MST
