Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558B0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8D321655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iyyibkwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfLLQJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:09:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbfLLQJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0iZv/b1MpMMgbVLW482W9UgK4Sf8KMy1U7+mvz4azrE=; b=IyyibkwovCItW2dvLXNZVbPgC
        lCqRmzxJxtzWAIbY0swXdfqLOLKL6W/+BEMG195vPuiS3/TmDffqSEXgveBsmkYNOPlrWVkqm4z3Y
        fxjPZrZTnpe+9v47Dlg6UAzgOEvoHYtU/1lmlD8fZYZJc0CLg4296F3if3xNZt2tq6lCQtb0nddVs
        7MmXMfGFMKxFdqfm49hqh0ipH8K2lxzG3jTtIfAmsURra1D94RGRIP5715y7GNhZf/BZ9meg+gPF9
        uyRuX/0Cqew0YsNHSq/zjZkB6ksyK2oSvGzJwCjz0HXxDeJmA9ULPIxpkF29bDhBlAIG8kZ8wIAVB
        74l+I3oAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifR2D-0004o9-NW; Thu, 12 Dec 2019 16:09:49 +0000
Date:   Thu, 12 Dec 2019 08:09:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 08/10] tty: serial: samsung_tty: use 'unsigned int' not
 'unsigned'
Message-ID: <20191212160949.GA10815@infradead.org>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-8-gregkh@linuxfoundation.org>
 <eb3cf8f9-3606-c2d6-ad90-4388a52c320b@free.fr>
 <20191212110834.GB1490894@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212110834.GB1490894@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 12:08:34PM +0100, Greg Kroah-Hartman wrote:
> Yes.  It's a long-time checkpatch warning, it's good to be explicit for
> this type of thing.

There is literally no practical benefit going either way.  It is
just checkpatch forcing one personal opinion on people.
