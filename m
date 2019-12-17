Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E27AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C9C2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576611480;
	bh=tYP35VXrTs41pboITJSUY+kOGBdJF3MnzMU00b7I8eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bDZOAHbs+i/NzUI60AMoiKfCIx+NXsjHCQ9K8TlaJDfDnlvsQlmghAhPV8xBTIuz2
	 zVBlZRfzV4+JkxX3gxWCJTFkNJr3t4zjhw6itUgO2UxqriJEQ2fqA538eP/8QAjwOf
	 71QMNK9Cfz1dz69GBHnwgbOrVs+RivPVkMThXSPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfLQTh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfLQTh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:37:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D22962146E;
        Tue, 17 Dec 2019 19:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576611478;
        bh=tYP35VXrTs41pboITJSUY+kOGBdJF3MnzMU00b7I8eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FahD794mMIkI2Vn1o+dtoQSjiEHYAGkUkQEny2InsvA2MiTG6HDD7DIedbI+PyBL8
         0Y3uCpdZLtHtelJ87gvpRT2A64ztCmeNG4ca9RTeioud4Pt6BFy6X2xjkAtqzcm9KL
         OLA8DXnwgaugjYrWKrnEoF9BC2DdT1L1zfrPxoCY=
Date:   Tue, 17 Dec 2019 20:37:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     pr-tracker-bot@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] remove ksys_mount() and ksys_dup()
Message-ID: <20191217193755.GA4075755@kroah.com>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <157644301187.32474.6697415383792507785.pr-tracker-bot@kernel.org>
 <CAJmaN=ksaH5AgRUdVPGWKZzjEinU+goaCqedH1PW6OmKYc_TuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmaN=ksaH5AgRUdVPGWKZzjEinU+goaCqedH1PW6OmKYc_TuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:33:38AM -0800, Jesse Barnes wrote:
> Still debugging, but this causes a panic in console_on_rootfs() when we try
> to dup the fds for stderr and stdout.  Probably because in my config I have
> VT and framebuffer console disabled?
> Reverting 8243186f0cc7c57cf9d6a110cd7315c44e3e0be8
> and b49a733d684e0096340b93e9dfd471f0e3ddc06d worked around it for now...

Should already be fixed in Linus's tree.

thanks,

greg k-h
