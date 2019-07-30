Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CB5C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F4720882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564471010;
	bh=EZGsfYm35kh/JoaDHIUDWu4Al1mBiLDpJGSHeDLLJ8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YboGF6UL3z1sU1kYiWss2xfFl8c3NgRrkROG/HNaGd8udmNJft/uh4RZV9HA5TInj
	 5bCK1Wz0nVwaBgl1IN0v9DmhYIaHC98VX9Nvwbf+QPuJLmjW9xhOujaEHEnzy6G9x3
	 0dz5z5zTLnUiyBCZUbY6rEGC4Wy0hsTiCv8+8VCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfG3HQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbfG3HQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:16:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7ADD20882;
        Tue, 30 Jul 2019 07:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564471007;
        bh=EZGsfYm35kh/JoaDHIUDWu4Al1mBiLDpJGSHeDLLJ8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=woasFcdOrjzYpsLq52g+KBPK0lIR1r//ehXphrlRc41/rU+R2YiVL8F09MB3iDvkD
         tPNReS9RGlQNJ7ENzbA2StziLTI/LHbPK+8KSE9WbXjr/T8kq+yxaC9VxuAtjX1s4e
         vyid/T4rARV20f1MssAk1jBZiuPDHah5zgeT5/qA=
Date:   Tue, 30 Jul 2019 09:16:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.3-rc3
Message-ID: <20190730071643.GA20059@kroah.com>
References: <20190729125502.GA2969@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729125502.GA2969@ogabbay-VM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 03:55:02PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is habanalabs fixes pull request for 5.3-rc3. 
> It contains two important fixes for BE architecture.

Pulled and pushed out, thanks.

greg k-h
