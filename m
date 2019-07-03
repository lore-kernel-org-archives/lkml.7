Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC765C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7AC218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562168072;
	bh=f4B8WeG5XaSaTowaf4i88T69sN+OF2OOJodh5xJS0Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KJMtj14zn9RJ+qPapWn8PEznOL06F7SCF6At0CYWC7/hh+k6fbG11lI8jzK2dcmYn
	 Fk8Ot9Z09/lbDvDFuHIT+jgBGsW0tynqPjvTVZj6whoO08OImspYYOp4KvXLK56xBt
	 7WxcJZRIZomtRzlD3lMsmALWC4t8KsCTEi3Uc8Gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfGCPeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGCPeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:34:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DE392184C;
        Wed,  3 Jul 2019 15:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562168070;
        bh=f4B8WeG5XaSaTowaf4i88T69sN+OF2OOJodh5xJS0Bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6M7sZBu1YIVvwGE2Au8SNll8VXIuiSN48Zg487+1aC6P6JkFDY9k9spExJUx8EOC
         ND7Jo2KUiSIVRHFODVCmKnOBfFDLSxKXftJtzjuJ/v9SGmjQGLhCbjg5IscUp7zVLk
         38wqZ0T11ZlnqBZ8NgS0RWXPZrgWR472yDowaxNk=
Date:   Wed, 3 Jul 2019 17:34:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 0/4] intel_th: Fixes for v5.2
Message-ID: <20190703153428.GA14543@kroah.com>
References: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
 <87sgrnta0g.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgrnta0g.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 06:26:07PM +0300, Alexander Shishkin wrote:
> Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:
> 
> > Hi Greg,
> 
> Hi Greg,
> 
> > Here are the fixes I have for v5.2 cycle: two gcc warnings, one dma mapping
> > issue and a new PCI ID. All issues were introduced in the same cycle, so no
> > -stable involvement.
> >
> > All patches are aiaiai-clean. Signed git tag below. Individual patches in
> > follow-up emails. Please consider pulling or applying. Thanks!
> 
> Just in case this got buried under other email.

It did, but it is in good company :)

thanks,

greg k-h
