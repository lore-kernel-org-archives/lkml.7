Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70DCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9370A2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552396688;
	bh=wbazcXAsLV6GiVSMnJj6MygcFdjgL46hdIkVbCyMWyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P05n5zTVVG0QDCrrzz+Q27NwImZCaJmVQnyjON7+NjGMXBxgGwS/Qg1BTseEOudt1
	 4LN6uUtBWpVQnFqxtxqJYHD0d8zvXHldYrD1dlk3ODI9r8but24rmBM2seR7kDDb7i
	 LVT7DeQ3g33Wg3N8IFagdeo0PRbJswWVFSOX5Fd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCLNSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfCLNSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:18:06 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40498214D8;
        Tue, 12 Mar 2019 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552396686;
        bh=wbazcXAsLV6GiVSMnJj6MygcFdjgL46hdIkVbCyMWyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQ3GN8/4nkNV83jfuwN9vFzKL41GIDew9KTT344CV0O5haGoQRmZ3PSMw7LU9yNEV
         uFExcN5pDUYhvGQFAxlqwvIKjQKnKet+n1lOBVKzfeE0rq6I1ZLDcAfnKwRz0L/Tn1
         j9H+iJ7+lGU6/sGM+24SAleVb4L/ZHCPRfwxXeWk=
Date:   Tue, 12 Mar 2019 06:18:05 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: uio: Kconfig: pedantic formatting
Message-ID: <20190312131805.GC18103@kroah.com>
References: <1551896023-14007-1-git-send-email-info@metux.net>
 <1551925354-21162-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551925354-21162-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:22:34AM +0100, Enrico Weigelt, metux IT consult wrote:
> Formatting of Kconfig doesn't look so pretty, so just take
> a damp cloth and clean it up.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

As before, please fix up the s-o-b line.

thanks,

greg k-h
