Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A35CC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280742073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576167158;
	bh=Azp4PExRL32fMUK0pwp1jU+NLT+CnzCcl4VucWCqSZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1od1fXFfn8zMArXWq/QKlT6LMNEwAEwQV+m1KMPPZwSmnf52+wiTI+kOni8JVKw0K
	 bv1nrJ4imBKeOsg2VnT6qia+82V2RqDKjA8Wj807XTMO8fi4tpMidJuEePW1n6ewoA
	 oISSpitohwkBA/xIEfO0FVMrkLUmcc32u0JHQXYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfLLQMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:12:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbfLLQMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:12:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3296F21655;
        Thu, 12 Dec 2019 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576167156;
        bh=Azp4PExRL32fMUK0pwp1jU+NLT+CnzCcl4VucWCqSZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zv5XEkmmQalxPyaf7AEc8q81oVHR9o5hdyh6K+8+oY3CzqlqFr6QkOPzEuv2rEdQV
         TD/4IheA0gHL021w1XknTTTw8UYBPbdaOMxk7jJwKGllz+3mFP8lMrGn3lUzcm7dX5
         Kb754qsoSa/vvR05ri5uUEsjmRNviUBKzUlffUJo=
Date:   Thu, 12 Dec 2019 17:12:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 08/10] tty: serial: samsung_tty: use 'unsigned int' not
 'unsigned'
Message-ID: <20191212161234.GA1673430@kroah.com>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-8-gregkh@linuxfoundation.org>
 <eb3cf8f9-3606-c2d6-ad90-4388a52c320b@free.fr>
 <20191212110834.GB1490894@kroah.com>
 <20191212160949.GA10815@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212160949.GA10815@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 08:09:49AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 12, 2019 at 12:08:34PM +0100, Greg Kroah-Hartman wrote:
> > Yes.  It's a long-time checkpatch warning, it's good to be explicit for
> > this type of thing.
> 
> There is literally no practical benefit going either way.  It is
> just checkpatch forcing one personal opinion on people.

Fair enough, but, I was trying to align up the variables to be the same
type that was then used in a function call.  That's the only reason I
made this change.

thanks,

greg k-h
