Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2126C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E3E218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567960904;
	bh=1Ubr+gGsLmIsNu1qigSSf3C36qMCG+gThIHB1/qjXbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T8mu3OXvhXnstTJjNYJ0iSssZtPYOhH9ZF4WhS7moZWumq2OFhUgUIMe6Rg3cJxtT
	 b4Vfy58v0pLCDWVErwOhxGzHMzHqTCua9DcnOmfJT6t/bw9pgPygQxaVAWtjecTt36
	 esfHkx2zAKA5+t8gsV8qElGj/7Cp896y9DZPVHyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfIHQln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbfIHQln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:41:43 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DED3216C8;
        Sun,  8 Sep 2019 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567960903;
        bh=1Ubr+gGsLmIsNu1qigSSf3C36qMCG+gThIHB1/qjXbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G0dR+fwzv+HiRlPvPZgpyPA/9b5tH876J4gao/qK5/G9jfAKCFDV9xRDvEZZWPZ43
         Pt/05+DarYy6Vb5ZzIr1VB/m0UqxzwATWgVnSDRxt+HZIe9nMhC2FKFNE8Vw1RY2fg
         aVkrufZcQvjLFwmmNjts6uCj1v7tKWS3HVdPpiIg=
Date:   Sun, 8 Sep 2019 17:41:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] staging: exfat: drop unused field access_time_ms
Message-ID: <20190908164140.GB8362@kroah.com>
References: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
 <20190908161015.26000-2-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908161015.26000-2-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 04:10:14PM +0000, Valentin Vidic wrote:
> Not used in the exfat-fuse implementation and spec defines
> this position should hold the value for CreateUtcOffset.

Then why not just put CreateUtcOffset in here instaed of deleting it?

I would much rather the fields match the spec in the structures for lots
of good reasons, instead of having loads of "reserved[]" variables.

thanks,

greg k-h
