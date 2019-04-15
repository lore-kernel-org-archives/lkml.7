Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E59C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18CE20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfDOJrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:47:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfDOJrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:47:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7898B02C;
        Mon, 15 Apr 2019 09:47:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 251261E42AA; Mon, 15 Apr 2019 11:47:39 +0200 (CEST)
Date:   Mon, 15 Apr 2019 11:47:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     keescook@chromium.org, jack@suse.cz, arnd@arndb.de,
        akpm@linux-foundation.org, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/reiserfs/journal.c: Make remove_journal_hash static
Message-ID: <20190415094739.GA13684@quack2.suse.cz>
References: <20190414112438.GA23266@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414112438.GA23266@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 14-04-19 16:54:38, Bharath Vedartham wrote:
> This fixes the -WDecl sparse warning in journal.c. Function was declared
> as static void but the definition was void.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

Thanks! I've added your patch into my tree.

								Honza

> ---
>  fs/reiserfs/journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 8a76f9d..36346dc 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -1844,7 +1844,7 @@ static int flush_used_journal_lists(struct super_block *s,
>   * removes any nodes in table with name block and dev as bh.
>   * only touchs the hnext and hprev pointers.
>   */
> -void remove_journal_hash(struct super_block *sb,
> +static void remove_journal_hash(struct super_block *sb,
>  			 struct reiserfs_journal_cnode **table,
>  			 struct reiserfs_journal_list *jl,
>  			 unsigned long block, int remove_freed)
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
