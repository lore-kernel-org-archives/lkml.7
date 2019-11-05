Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C99CA9EDB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53147206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572940054;
	bh=HOSqksOEOxuLPFJ/nye+bypmqdSlIzOajYUiFRJPI1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BdJsvvoBgF1nVx7G1OnmADSdxnwVxZFq+OrW7xtyEblcUakYJbK19u7T6CfQROAhB
	 wqgLjoiZUqNhqQin4d4151L6d9sSkcPgNM12uLEh0/yjuFVqD1Ye9hTzQDKCpTpf60
	 dvrB3QQsJci0gaD//ommYhWUpmsTBmsD7pqPKr/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387878AbfKEHrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:47:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387482AbfKEHrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:47:33 -0500
Received: from localhost (host6-102.lan-isdn.imaginet.fr [195.68.6.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 583F3206BA;
        Tue,  5 Nov 2019 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572940050;
        bh=HOSqksOEOxuLPFJ/nye+bypmqdSlIzOajYUiFRJPI1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tqh36OxmfEHUz18pWs0ecvnVyIj8QbGOo+3iz8aiqVT7AXIAwlSfmPb91uEIKKbye
         llA001qZul0TUaAXYe/1u9TXBwkIngxPKtQtQ5zpnIx3iJKFAq5RjFoOKnV0G8/tkI
         YJroHmeIFQRVBMqca766m82M3h7WNtzl9FRTjL70=
Date:   Tue, 5 Nov 2019 08:47:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL v2] extcon-next for v5.5
Message-ID: <20191105074722.GA2590260@kroah.com>
References: <CGME20191105045553epcas1p3aeb81b122b12c40e93bc5768272e2ce1@epcas1p3.samsung.com>
 <ff758fcb-8ff9-4e87-9ee8-0247dcf686c1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff758fcb-8ff9-4e87-9ee8-0247dcf686c1@samsung.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 02:01:30PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.5. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Detailed description for this pull request:
> 1. Clean up the and fix the minor issue of extcon provider driver
> - extcon-intel-cht-wc don't reset the USB data connection at probe time
>   in order to prevent the removing all devices from bus.
> - extcon-sm5502 reset the registers at proble time in order to
>   prevent the some stuck state. And remove the redundant variable
>   initialization.
> 
> Changes from v2 as following:
> - add the missed patch title of this pull request
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> 
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.5

Pulled and pushed out, thanks.

greg k-h
