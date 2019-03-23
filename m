Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8D2C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4685B21902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553322757;
	bh=xYkqedQLnsIea2SH9S+am9SqhNCCG3uTIF6pQiTMWCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S45JJwCJyaD45MTq/UW8siPyuEncjq8pOykE2Wm64pXixZ7dMA6FU/ZW5r3acLfen
	 343We6kOyfTnmplvPE/EQv4aJeuedniy9PgDgtr8/C5rBwfPk1d6sswmGw8WF5xINr
	 aXaEhcjlYrPniBO3qqvKUybKufBuRNfQhHpP/wYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfCWGcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 02:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfCWGcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 02:32:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 097E0218B0;
        Sat, 23 Mar 2019 06:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553322755;
        bh=xYkqedQLnsIea2SH9S+am9SqhNCCG3uTIF6pQiTMWCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4nQPEEy5ZE/P7s3i1wVb7XOjckWp0KOPeh5nBiuIbxQqNuwg9e+2dMsMGy1DKtBi
         cgIuwvetj68CUdwFcfWdkI2U/rtEfPyGot+nvs4oiJSij/F12FCSeEFtUdmn7pcfr8
         FAAX83IHQnUdx0iRTTeu45oNu6zpXQ12tadyWhB0=
Date:   Sat, 23 Mar 2019 07:32:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3.18 107/134] tmpfs: fix link accounting when a tmpfile
 is linked in
Message-ID: <20190323063232.GA31361@kroah.com>
References: <20190322111210.465931067@linuxfoundation.org>
 <20190322111217.997579517@linuxfoundation.org>
 <alpine.LSU.2.11.1903221200490.2995@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1903221200490.2995@eggly.anvils>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 12:05:39PM -0700, Hugh Dickins wrote:
> The other patchsets posted today are complete - thanks -
> but this 3.18.137-rc1 tree still wants
> 29b00e609960 ("tmpfs: fix uninitialized return value in shmem_link")
> to be added to fix this one - thanks.

Thanks for letting me know, now queued up.

greg k-h
