Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A13C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C951D229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 01:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564104326;
	bh=hQnoYefwpnCAAg9s0kL4bPLOBy5YHF5poTqfNE9a5Vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=R58Bs+xeozNMPSW/EY/Kscj9jM9UjF2zptcbQBJtuyG2zUHF45Ai0dcitISkKjeI5
	 rhXKguha1TKW5QntIrnSy6xqOPQWnWbyc36AgP284T6UfJ4UR4SLYI+abcDikgsOTt
	 C7tVe4gexXo6CqqPX5lRvo9VxoiTsT4u3URO3wto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfGZBZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 21:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfGZBZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 21:25:25 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1245B2082E;
        Fri, 26 Jul 2019 01:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564104324;
        bh=hQnoYefwpnCAAg9s0kL4bPLOBy5YHF5poTqfNE9a5Vo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ThVgeLizxHSdRe3N47YgrAndRU85laMix4d8o2Rpb4LGhK1vBi5DiqwmLG4HLx80f
         O/setgvAStrybhk4mZWgPlpatf3BBDtHBcZaUcAzFomBYgRIRS5Kd6L16040BVr3Dy
         ThT/tDroFFIlVles91icc/hF26M39A5O4qdikZig=
Date:   Thu, 25 Jul 2019 18:25:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v2] checkpatch.pl: warn on invalid commit id
Message-Id: <20190725182523.0d19ccd938688e5325be2e06@linux-foundation.org>
In-Reply-To: <5E31E2F6-1EE7-4A40-A7F5-68576C36A6AD@redhat.com>
References: <20190711001640.13398-1-mcroce@redhat.com>
        <20190724200707.2ba88e3affd73de1ce64fab6@linux-foundation.org>
        <CAGnkfhxZUw7wUgE6FRetc52HywgwnucZpqcvg3MTUU0M8O158w@mail.gmail.com>
        <20190725172205.6d5a3b5896e64f88116c0b21@linux-foundation.org>
        <5E31E2F6-1EE7-4A40-A7F5-68576C36A6AD@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 03:17:32 +0200 Matteo Croce <mcroce@redhat.com> wrote:

> > > If .git is not found, the check is disabled
> > 
> > We could permit user to set an environment variable to tell checkpatch
> > where the kernel git tree resides.
> > 
> 
> Maybe GIT_DIR already does it.

Yes, that works.  GIT_DIR=<wherever>/.git
