Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239CCC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 22:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDA420656
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556491753;
	bh=5ODc0wmV69R3H2qSQPV7YqDPVom0XqmtA0DWBHtabT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QkfxMvZqdrBLILa+eOC2pCZQPAunsXNzuIkdfqHZFlzoiI0aStkP2owyC9uroAkTj
	 IuQyy3kDxn3jgtItYyDKG/xAJwsxEZaf9L5WdCqReBXlDCsH78R9DD+z4BkkaJRUOX
	 vN9DQ+ETyFMb7Q2sQR8adkTbKdD0CjRidvTzB0qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfD1WtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 18:49:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfD1WtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 18:49:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0FAAAE16;
        Sun, 28 Apr 2019 22:49:10 +0000 (UTC)
Date:   Mon, 29 Apr 2019 00:49:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/oom_killer: Add task UID to info message on an oom
 kill
Message-ID: <20190428224907.GC956@dhcp22.suse.cz>
References: <1556130013-19021-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556130013-19021-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-04-19 14:20:13, Joel Savitz wrote:
> In the event of an oom kill, useful information about the killed
> process is printed to dmesg. Users, especially system administrators,
> will find it useful to immediately see the UID of the process.
> 
> In the following example, abuse_the_ram is the name of a program
> that attempts to iteratively allocate all available memory until it is
> stopped by force.

There was a more general rework of this message
http://lkml.kernel.org/r/1542799799-36184-1-git-send-email-ufo19890607@gmail.com
but I do not see it merged into Andrew's tree. Could you have a look and
pursue it, please?

-- 
Michal Hocko
SUSE Labs
