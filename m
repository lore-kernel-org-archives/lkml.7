Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8FD218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfCUOoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:44:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727844AbfCUOoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:44:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 929E7ACE7;
        Thu, 21 Mar 2019 14:44:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CA2FBDA938; Thu, 21 Mar 2019 15:45:49 +0100 (CET)
Date:   Thu, 21 Mar 2019 15:45:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: affs: fix a NULL pointer dereference
Message-ID: <20190321144547.GA8120@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Kangjie Lu <kjlu@umn.edu>,
        pakki001@umn.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190315074246.26426-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315074246.26426-1-kjlu@umn.edu>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 02:42:44AM -0500, Kangjie Lu wrote:
> If affs_bread fails, do not use ext_bh to avoid NULL pointer
>  dereference
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Tanks for the patch.  I'll need some more time to get familiar with the
AFFS code to review your patch.
