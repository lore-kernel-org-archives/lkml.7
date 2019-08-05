Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A218EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DBB20880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="HUlQNsA+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="FJFW/qsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfHEPXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:23:41 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40854 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728468AbfHEPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:23:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 058F98EE1D4;
        Mon,  5 Aug 2019 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1565018620;
        bh=aMyazwj3Z0VFn9xhsT+XWnLTQQNH/fKqVwxQ2iZtBxw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HUlQNsA+bD7wqdyefKs+ZVuA6th1/suu/9NhiB+u3epmt2aWiSSCStNN6h69juJJ5
         Ns+WrgwP5toElCWTh+1hBEc4Gl9c3YgHmCgPAYHz9adv+k7WJnFIHd1jdvEzECiqHr
         57Za316mS0bAFUwIsqjSDEqmf0FdRFUeckpfykgw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IBEMwGROXGvb; Mon,  5 Aug 2019 08:23:39 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.71.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 417A38EE079;
        Mon,  5 Aug 2019 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1565018619;
        bh=aMyazwj3Z0VFn9xhsT+XWnLTQQNH/fKqVwxQ2iZtBxw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FJFW/qsA0Pn85ep+8zRELkYWeP+XaFOEOB3j0l1ADUy0LqwDku9XPp2R+h+UfS/Q4
         jt2XcZ3nHkrwyG+w34X9UllutHsvmrJ0orAFejjhSuc9EWpsta/mgjkZZA88+Ntdp1
         TBYkMWgCuZUfoQOJLirUAqwGsBN7TJ+WICeJZO3M=
Message-ID: <1565018618.3341.6.camel@HansenPartnership.com>
Subject: Re: [PATCH] MAINTAINERS: Update e-mail address for Andrea Parri
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Daniel Lustig <dlustig@nvidia.com>
Date:   Mon, 05 Aug 2019 08:23:38 -0700
In-Reply-To: <20190805151545.GA1615@aparri>
References: <20190805121517.4734-1-parri.andrea@gmail.com>
         <76010b66-a662-5b07-a21d-ed074d7d2194@gmail.com>
         <20190805151545.GA1615@aparri>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-05 at 17:15 +0200, Andrea Parri wrote:
> > Why don't you also add an entry in .mailmap as Will did in commit
> > c584b1202f2d ("MAINTAINERS: Update my email address to use
> > @kernel.org")?
> 
> I considered it but could not understand its purpose...  Maybe you
> can explain it to me?  ;-) (can resend with this change if
> needed/desired).

man git-shortlog gives you the gory detail, but its use is to "coalesce
together commits by the same person in the shortlog, where their name
and/or email address was spelled differently."  The usual way this
happens is that people have the name that appears in the From field
with and without initials.

James

