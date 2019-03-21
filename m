Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C57020811
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfCUJDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:03:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfCUJDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:03:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 863FAAF57;
        Thu, 21 Mar 2019 09:03:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 763331E0CE4; Thu, 21 Mar 2019 10:03:38 +0100 (CET)
Date:   Thu, 21 Mar 2019 10:03:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] udf fixes for v5.1-rc2
Message-ID: <20190321090338.GB29086@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.1-rc2

to get two udf error handling fixes.

Top of the tree is 2b42be5eb245. The full shortlog is:

Jan Kara (2):
      udf: Fix crash on IO error during truncate
      udf: Propagate errors from udf_truncate_extents()

The diffstat is

 fs/udf/inode.c    | 4 +++-
 fs/udf/truncate.c | 8 ++++++--
 fs/udf/udfdecl.h  | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
