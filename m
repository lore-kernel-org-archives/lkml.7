Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EC5CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441D020862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="msOZSol4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbfJ2FyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 01:54:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfJ2FyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 01:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e6RnrH2a/xpt2VMsLVKGZqzPeW9lRxkDro1R520eqQQ=; b=msOZSol4yz79J1fe4CsOfyuVj
        CNdbmyX/M4AxqpDVZGCsWG8UgR3sLsHZh6JfVG+GKO4uyHeKWQ1Ur5pFeXzU15bwsQOFkGvMfKbre
        bTdMpchI9RrZTKc0Mv16399xz+xAd06N/maT8aVXo+R8tyM7T5M8w4NVDZrvW34EfsuXuu1zVy6Sh
        pspzdWcGYgQDYZdgQwSj3qWIaagT8+HBedyFlVzGHfCqYKpWwbvkNQsYLAXvLE8muByumox6rzgDv
        2EjwSMepzaDya+Kk2ImMAJyCuCUMVth9KhyJgMHd3z6N21itwWxAhGOIqzpWaZ6xiULoghzuiHTcD
        fUsb/qk1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPKS7-00084L-BP; Tue, 29 Oct 2019 05:53:59 +0000
Date:   Mon, 28 Oct 2019 22:53:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Boaz Harrosh <boaz@plexistor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Please add the zuf tree to linux-next
Message-ID: <20191029055359.GA30787@infradead.org>
References: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
 <20191024023606.GA1884@infradead.org>
 <20191029160733.298c6539@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029160733.298c6539@canb.auug.org.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 04:07:33PM +1100, Stephen Rothwell wrote:
> > > Please add the zuf tree below to the linux-next tree.
> > > 	[https://github.com/NetApp/zufs-zuf zuf]  
> > 
> > I don't remember us coming to the conclusion that this actually is
> > useful doesn't just badly duplicate the fuse functionality.
> 
> So is that a hard Nak on inclusion in linux-next at this time?

As far as I'm concerned yes.  In the end we'll need to find rough
consensus as I'm not the only one to decide, though.
