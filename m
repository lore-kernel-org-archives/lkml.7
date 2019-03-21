Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACF0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD7120830
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfCUPND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:13:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbfCUPND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:13:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28A55AEE6;
        Thu, 21 Mar 2019 15:13:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9E269DA938; Thu, 21 Mar 2019 16:14:15 +0100 (CET)
Date:   Thu, 21 Mar 2019 16:14:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Stable patches that don't apply to older kernels and how to get them
Message-ID: <20190321151413.GB8120@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, gregkh@linuxfoundation.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

would it be possible to have a git repository with all patches that are
submitted to stable@ but don't apply directly?

I get notified by mail, that's fine though it's not that convenient to
see all the pending patches for backport to a given version.

My proposal:

- create a separate stable-unapplied git repository

- if a patch does not apply to a given version, it's stored as-is to a
  directory of the base version (like 4.4)

- once a fixed version is applied to stable-queue.git/released-4.4, the
  patch in the other repo is deleted

I believe this can be highly automated and once implemented would not
too much additional work to the stable workflow. I could possibly write
a scraper of the mail archives to pick the patches and manage the
repository but I think that a central repository could help other
maintainers too or to spread the load to all interested developers.

If something like that already exists, please let me know.
Thanks.
