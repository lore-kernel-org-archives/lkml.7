Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77756C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABFC20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558634763;
	bh=CKBLQwm5TLwg9qQLu9mV1PTVvAZUGoRegOuK0dw6uao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V1j/YT6eoxOve9dsqcAmKOYoQMB5WtsxZa9z039ry2/e3NjeCM+wAeOHZSZaTwkAJ
	 S65wAXoXNl/8pwtQINQpni9D0At+dlTNN6pRCMISlI02QCF0t8yAUSjWdWmKMg0oxH
	 oGwUkILp9cHs7DqVU/my7dT1h1Sx6ZGYowEhrJc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbfEWSF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387408AbfEWSF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:05:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC65A2075B;
        Thu, 23 May 2019 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558634758;
        bh=CKBLQwm5TLwg9qQLu9mV1PTVvAZUGoRegOuK0dw6uao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5vv/po+GOlQxYTf/LxrUWLT009EPaUjlMycrpq2MmDV0LE/Fb/C+3BlBh8enV+nQ
         vMz2P/ZHooK7HCExYcE6JgJ/DjEoTJbFfz4uKIpfl1bXWAa7wB0/q9WlQEvbCxV7gH
         YnrN3psT/t4Om/SkrvbzTfOTuknA3o33JgIJLwGo=
Date:   Thu, 23 May 2019 20:05:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jeremy Sowden <jeremy@azazel.net>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: fieldbus: anybuss: Remove unnecessary variables
Message-ID: <20190523180556.GA25933@kroah.com>
References: <20190523063504.10530-1-nishka.dasgupta@yahoo.com>
 <20190523072220.GC24998@kroah.com>
 <b8cc12d9-2fe3-754b-be08-f23055a31ffe@yahoo.com>
 <20190523082702.GB28231@azazel.net>
 <20190523090918.GU31203@kadam>
 <CAGngYiWT3a5EYZsgxdRQsrEnu4Cw6FNmNWhzx721SY8DXYL4Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiWT3a5EYZsgxdRQsrEnu4Cw6FNmNWhzx721SY8DXYL4Rw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 09:02:11AM -0400, Sven Van Asbroeck wrote:
> On Thu, May 23, 2019 at 5:09 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Sven, you should add yourself to the MAINTAINERS file.
> 
> Greg, what do you think?

Yes!
