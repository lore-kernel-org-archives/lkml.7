Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7B6CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A34222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571422118;
	bh=Zko5TFCbMuteiDkblLcIaxzpGObqH1iycSI0nGRXOco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QuDiQwdMxuuZSR2Vxg+HzO5R96+0iu6kb0prknE9u6yVlrVgKFKTu37xKnyzkmGE+
	 gDZmvIQCKXlpKrSIYlsxEA9yw6fgMdoUPz0+7gAkjkkhlansCXPki7TziJNouIKm7q
	 AnK09B8Av40jwbT83/zG5aeS0ttBUjUVB1iBWxQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502465AbfJRSIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505730AbfJRSHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:07:12 -0400
Received: from localhost (unknown [38.98.37.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C9A222C3;
        Fri, 18 Oct 2019 18:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571422030;
        bh=Zko5TFCbMuteiDkblLcIaxzpGObqH1iycSI0nGRXOco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qd5p81QhwjSfX3jgj6L0KhcaY7E8RZYgZh2mmPgsaswDClWm1TytloAVm24cxkxPE
         JU+TJeliFqeHF2fcJH2BbxrHvamG8ZtqRU2kjv9StnSez+N4g1CjQBorwSE+xmvvk7
         5shqLKf9NrwI6040ZgpaeTIx00ENzj7PwZEj1pfk=
Date:   Fri, 18 Oct 2019 11:06:52 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Jacky . Cao @ sony . com" <Jacky.Cao@sony.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/2] USB: dummy-hcd: increase max number of devices to 32
Message-ID: <20191018180652.GA1186697@kroah.com>
References: <7a9d6e35873d52ec0ab1e6b9827d9299a1f4fb0d.1571409250.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a9d6e35873d52ec0ab1e6b9827d9299a1f4fb0d.1571409250.git.andreyknvl@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 04:55:56PM +0200, Andrey Konovalov wrote:
> This patch increases the maximum number of Dummy UDC/HCD devices to 32.

Yes, that is a good description of _what_ the patch does, but it does
not tell us _why_ you want to do that.

Also, no signed-off-by, are you sure you ran your patches through
scripts/checkpatch.pl before sending it out?  It's a good idea to do
so...

thanks,

greg k-h
