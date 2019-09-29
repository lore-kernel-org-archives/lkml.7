Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9B2C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E5921855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569852504;
	bh=2mc2WJAfFNYLm+JXii+VJzzTASUubxbZlUcpObv3R/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VprHth8GTSka9XVrwjbFOYjDb8JDdXQwDgjNZLjpR3+VcUpTS3YY7cL6HFBJjtoik
	 fzQvun5smEvrks9QJaHulS6GSviB8vjALLiPcd6xLRQA6XF55xeEG9t4ZUubcOIjMw
	 RT6Zr5kcyFPa/E6WI6+XtpiJNldrpYCAbtvs/0d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbfI3OIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbfI3OIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:08:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39150218DE;
        Mon, 30 Sep 2019 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569852501;
        bh=2mc2WJAfFNYLm+JXii+VJzzTASUubxbZlUcpObv3R/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGe3PHGQHW6M6wxHHWog/8+TUBx86qRsirrn3uYoGLop4V0MiGFBFkXPvt71++Bjr
         E07YsWeIqZAfoxGpFFMYOX/X5K30rZE+WRBxh2LMcF7gMOukh0ChjDeBoVI/0z31Jd
         7aM/Uu5+giWQANAKciJ6rWENkmlF7iR7NCXHQvWA=
Date:   Sun, 29 Sep 2019 16:59:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jesse Barton <jessebarton95@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Staging: exfat: exfat_super.c Fixed coding style
 issues.
Message-ID: <20190929145926.GC2017443@kroah.com>
References: <20190929145245.38816-1-jessebarton95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929145245.38816-1-jessebarton95@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 09:52:45AM -0500, Jesse Barton wrote:
> Removed function argument wrapping to new line.

I don't think you "removed" anything here :(

Writing the changelog is usually harder than writing the patch in the
first place, welcome to programming!  :)

thanks,

greg k-h
