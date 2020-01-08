Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083E5C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B25206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 23:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="unEY8eZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgAHXnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 18:43:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAHXnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 18:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fzCIX28C4ZAC3u5qLAUDVcEdFKR+Sd0vbPoA2LC1SLo=; b=unEY8eZyBDUlUUgSjehECSefM
        EzW+niSQLElUiK2BUPNlO87WoFdIuL5PZFYcS0E9tIE9jXT4pCRSJksAwY+ADVKc/gQMySCe1tL6a
        IFsm2PcJLVq9fpjgTZrarTVXxPA39KsFwDKcZl7gptdgYEEx17JDCJB0G3JGtCVBihkDw9KUeazVF
        rUJVa9P5DrNBtI+rrO13g/g4qbJVjZBEnmfndVWg5VNESl5c9RZjMfb6O1k+5k+F1iYirOTB+4wUk
        beJW8dxyn5MRf8UPnFFAq8ec7IX2gjc/6Ne7vQS7Sol/KzQ6AMot4lZ+oAIqW8TQNs6XdQ7VO4R70
        9ein7qXFg==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipKyZ-0005Fa-RS; Wed, 08 Jan 2020 23:42:59 +0000
Subject: Re: reiserfs broke between 4.9.205 and 4.9.208
To:     Michael Brunnbauer <brunni@netestate.de>,
        linux-kernel@vger.kernel.org
References: <20200108193634.GA17390@netestate.de>
Cc:     reiserfs-devel@vger.kernel.org, Jan Kara <jack@suse.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <481c595b-46c9-0b4d-c618-a998ab6247c6@infradead.org>
Date:   Wed, 8 Jan 2020 15:42:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200108193634.GA17390@netestate.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/20 11:36 AM, Michael Brunnbauer wrote:
> 
> hi
> 
> after upgrading from 4.9.205 to 4.9.208, I get errors on two different
> reiserfs filesystems when doing cp -a (the chown part seems to fail) and
> on other occasions:
> 
>  kernel: REISERFS warning (device sda1): jdm-20004 reiserfs_delete_xattrs: Couldn't delete all xattrs (-95)
> 
>  kernel: REISERFS warning (device sdc1): jdm-20004 reiserfs_delete_xattrs: Couldn't delete all xattrs (-95)
> 
> This behaviour disappeared after a downgrade to 4.9.205.
> 
> I understand there have been changes to the file system code but I'm not
> sure they affect reiserfs, e.g.
> 
>  https://bugzilla.kernel.org/show_bug.cgi?id=205433
> 
> Any Idea?
> 
> Regards,
> 
> Michael Brunnbauer
> 

Looks to me like 4.9.207 contains reiserfs changes.

Adding CC's.

-- 
~Randy

