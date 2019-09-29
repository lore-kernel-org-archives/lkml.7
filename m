Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C89C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C223E2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569852501;
	bh=/FN2WQ9yzMV8JVSSKNjmVUodL+U57Yr79DhmFiMtLXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gy8qMzxm8UVOoUoLlQFy20wyebBuKubHkjGPCH5IW9Fqcvvu4QPlL7GjUCzoJVA8H
	 o1K92st6/RwXyZayDj/TAxh4tlJodo3bD1gGfu8jpo0DnNwzAtfDa6J6fQVlJ4+eN5
	 aTtl6hSp4yhib7dQ7h+0fmqBBZ0DD2ZMJKLNBXw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfI3OIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbfI3OIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:08:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8014E20842;
        Mon, 30 Sep 2019 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569852499;
        bh=/FN2WQ9yzMV8JVSSKNjmVUodL+U57Yr79DhmFiMtLXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x498d0ztV1PSGakfabzcFv5iQVtrVtv1i2BNWuF3s9XYZWaqstVm9Fv799vLB+iKT
         Pr4XV9Nvg9o2hPIfwOTbL+SmF74EhbPNgPPUCx2Shn0p6FmH8430+sCxmv0447hcLQ
         uJORmsSWEebFukSlO+7zMWPNFF1mwfrc1Ux6Imzs=
Date:   Sun, 29 Sep 2019 16:58:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jesse Barton <jessebarton95@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Staging: exfat: exfat_super.c: fixed multiple coding
 style issues with camelcase and parentheses
Message-ID: <20190929145830.GB2017443@kroah.com>
References: <20190929145229.38561-1-jessebarton95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929145229.38561-1-jessebarton95@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 09:52:29AM -0500, Jesse Barton wrote:
> Changed Function Names:
> ffsGetVolInfo -> ffs_get_vol_info
> ffsLookupFile -> ffs_lookup_file
> ffsCreateFile -> ffs_create_file
> ffsReadFile -> ffs_read_file
> ffsWriteFile -> ffs_write_file
> ffsTruncateFile -> ffs_truncate_file
> ffsRemoveFile -> ffs_remove_file
> ffsMoveFile -> ffs_move_file
> ffsSetAttr -> ffs_set_attr
> ffsReadStat -> ffs_read_stat
> ffsWriteStat -> ffs_write_stat
> ffsMapCluster -> ffs_map_cluster
> 
> Removed BUG_ON() and added WARN_ON().
> Removed unnecessary parentheses:
> *(dir_entry->Name) - > *dir_entry->Name
> 
> Switched to lowercase o in these enums
> Opt_uid
> Opt_gid
> Opt_umask
> Opt_dmask
> Opt_fmask
> Opt_allow_utime
> Opt_codepage
> Opt_charset
> Opt_namecase
> Opt_debug
> Opt_err_cont
> Opt_err_panic
> Opt_err_ro
> Opt_utf8_hack
> Opt_err


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
