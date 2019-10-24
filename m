Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9DECA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88ED82084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o+3jGmAq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437122AbfJXCgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:36:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391468AbfJXCgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Fj9mHRF3mevdCZVhB7KKO9UNPbwjnvX89JMWBIzhco=; b=o+3jGmAqn0XHHr5GOXSJrA0oc
        shld319a6f6WtdzX9apf3HCHkkWxFIFvwfqb0yjN5VRW6deoAw04ZNe0ZCkPfy7eBFenlcN9RhOT6
        BTFxpLhy4E1hnVi6ZcuGjchtN1kNNgWOhClLWFZYDZh9ihdxRvewI17ri0YLZpTVAs/iEp1Wjroql
        ZWc9Dcga4AUhAll8gI8PzOAUYPzqhjPOvkrO1ztPsc01XrcZGaqB3PWXplDxB/qxFAPpTvyh8lJsN
        aOFFoNjRz8K90j07uU5/DKv7m/ptYEVTNun+vXQTyFCy7B5/G6K5SpWBzMHS/4JRkaCkIy7wV0Vn/
        SvJiFTAFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNSys-0001uQ-Pm; Thu, 24 Oct 2019 02:36:06 +0000
Date:   Wed, 23 Oct 2019 19:36:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Please add the zuf tree to linux-next
Message-ID: <20191024023606.GA1884@infradead.org>
References: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 03:34:29AM +0300, Boaz Harrosh wrote:
> Hello Stephen
> 
> Please add the zuf tree below to the linux-next tree.
> 	[https://github.com/NetApp/zufs-zuf zuf]

I don't remember us coming to the conclusion that this actually is
useful doesn't just badly duplicate the fuse functionality.
