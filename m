Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D42C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908B12133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561382491;
	bh=WAE1HR6hUH9xAcKn4xMqspK9ebAd/XkgtM/HqIgBdiw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=XLxS8uBZE7XY1HckuItGshPYBCPUvarcVY1O+Wye0NaiAneMpUp4QuL3sD+d8fB0a
	 g2UJbnpa0K5CCnmK4Y6Dr4DJO1/VdJfXmcqxbE3PGlzMNNkArQYJ23JeLzjndOIjZX
	 L8LBakZYv1p5uBr26UdbLSJuh+5176h0bDtuRuNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFXNVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfFXNV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:21:29 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4916120820;
        Mon, 24 Jun 2019 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561382488;
        bh=WAE1HR6hUH9xAcKn4xMqspK9ebAd/XkgtM/HqIgBdiw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=g8JlED+0oqILB6Ch8fwGlZ6lFtDGij9D2xNScUPrTW24XcjIZqN3PWDME2nCrPQHj
         jTfTQ37BG6gJhCI9mC4lB2ztn87SlhnIA3MIoPJGVfHXgFuhP36lfNf9D97jvgEAk9
         ha9OKapyPhY/qyD9EJbEttZLSeYCwIXergjN8nUQ=
Date:   Mon, 24 Jun 2019 15:21:23 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
cc:     Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, rjw@rjwysocki.net,
        Joey Lee <JLee@suse.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH V34 10/29] hibernate: Disable when the kernel is locked
 down
In-Reply-To: <20190622175208.GB30317@amd>
Message-ID: <nycvar.YFH.7.76.1906241520500.27227@cbobk.fhfr.pm>
References: <20190622000358.19895-1-matthewgarrett@google.com> <20190622000358.19895-11-matthewgarrett@google.com> <20190622175208.GB30317@amd>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2019, Pavel Machek wrote:

> > There is currently no way to verify the resume image when returning
> > from hibernate.  This might compromise the signed modules trust model,
> > so until we can work with signed hibernate images we disable it when the
> > kernel is locked down.
> 
> I keep getting these...
> 
> IIRC suse has patches to verify the images.

Yeah, Joey Lee is taking care of those. CCing.

-- 
Jiri Kosina
SUSE Labs

