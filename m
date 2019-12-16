Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A7EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18812176D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522082;
	bh=SvnSCSQcOsqWFa+T6Ah5WQXoMzAFSiKPjC46/fvWpi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j1pqB6WXcJYTGMwbJsJ0IusNb5BJcNKZWkfMgW4AjPabehtateH8CWu4z6R2uBWRt
	 /DiIrusNYV9GK/Eve2/rtFhvomhm4PvZdrfishzDKE1opYYSt6hmVlDl/I1DOrXTkJ
	 QXFnqrnWUZPtIAW/daph4dykdSb+KuhFaxlNp6P4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfLPSsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:48:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfLPSr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:47:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F072082E;
        Mon, 16 Dec 2019 18:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576522079;
        bh=SvnSCSQcOsqWFa+T6Ah5WQXoMzAFSiKPjC46/fvWpi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDrxqrctKmR69U+WD1YSkMvKiVa8+BuAxSowWebw8aeBOCn/3ZwWZjZPH7jXu6v4Y
         tlCuIlwm6ELnRJgiLoo+0gMK8SJ/xtLUwbWSC1UlahT1/2nwigaNCrzDSZggosc0l2
         pH/GBZ1j9js6jxxwEMJx8dwVnBNVuQ1zM6IV8gfs=
Date:   Mon, 16 Dec 2019 19:47:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kconfig: Add kernel config option for fuzz testing.
Message-ID: <20191216184756.GD2411653@kroah.com>
References: <20191216095955.9886-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <87v9qgunjk.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9qgunjk.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:34:55AM -0800, Andi Kleen wrote:
> Maybe the run time setting can be the same as locked down kernels.
> It seems to me locked down kernels should avoid all these operations too.

That's the same thing I said a ways back in the thread, but for some
unknown reason, no one seemed to like it :)

thanks,

greg k-h
