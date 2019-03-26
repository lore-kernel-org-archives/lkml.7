Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF72CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C36F20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfCZKVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:21:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:51638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfCZKVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:21:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6969AD3E;
        Tue, 26 Mar 2019 10:21:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 249441E42D1; Tue, 26 Mar 2019 11:21:49 +0100 (CET)
Date:   Tue, 26 Mar 2019 11:21:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] quota: remove trailing whitespaces
Message-ID: <20190326102149.GR8308@quack2.suse.cz>
References: <20190326075431.14198-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326075431.14198-1-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 08:54:31, Sascha Hauer wrote:
> This removes all trailing whitespaces in fs/quota/.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks. Applied.

								Honza

> ---
>  fs/quota/dquot.c    | 10 +++++-----
>  fs/quota/quota_v1.c |  2 +-
>  fs/quota/quota_v2.c |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index fc20e06c56ba..0036d27206a8 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -9,7 +9,7 @@
>   * on the Melbourne quota system as used on BSD derived systems. The internal
>   * implementation is based on one of the several variants of the LINUX
>   * inode-subsystem with added complexity of the diskquota system.
> - * 
> + *
>   * Author:	Marco van Wieringen <mvw@planets.elm.net>
>   *
>   * Fixes:   Dmitry Gorodchanin <pgmdsg@ibi.com>, 11 Feb 96
> @@ -51,7 +51,7 @@
>   *		Added journalled quota support, fix lock inversion problems
>   *		Jan Kara, <jack@suse.cz>, 2003,2004
>   *
> - * (C) Copyright 1994 - 1997 Marco van Wieringen 
> + * (C) Copyright 1994 - 1997 Marco van Wieringen
>   */
>  
>  #include <linux/errno.h>
> @@ -197,7 +197,7 @@ static struct quota_format_type *find_quota_format(int id)
>  		int qm;
>  
>  		spin_unlock(&dq_list_lock);
> -		
> +
>  		for (qm = 0; module_names[qm].qm_fmt_id &&
>  			     module_names[qm].qm_fmt_id != id; qm++)
>  			;
> @@ -2397,7 +2397,7 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
>  out_fmt:
>  	put_quota_format(fmt);
>  
> -	return error; 
> +	return error;
>  }
>  
>  /* Reenable quotas on remount RW */
> @@ -2775,7 +2775,7 @@ int dquot_get_state(struct super_block *sb, struct qc_state *state)
>  	struct qc_type_state *tstate;
>  	struct quota_info *dqopt = sb_dqopt(sb);
>  	int type;
> -  
> +
>  	memset(state, 0, sizeof(*state));
>  	for (type = 0; type < MAXQUOTAS; type++) {
>  		if (!sb_has_quota_active(sb, type))
> diff --git a/fs/quota/quota_v1.c b/fs/quota/quota_v1.c
> index 7ac5298aba70..9f2b2573b83c 100644
> --- a/fs/quota/quota_v1.c
> +++ b/fs/quota/quota_v1.c
> @@ -127,7 +127,7 @@ static int v1_check_quota_file(struct super_block *sb, int type)
>  {
>  	struct inode *inode = sb_dqopt(sb)->files[type];
>  	ulong blocks;
> -	size_t off; 
> +	size_t off;
>  	struct v2_disk_dqheader dqhead;
>  	ssize_t size;
>  	loff_t isize;
> diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
> index a73e5b34db41..3c30034e733f 100644
> --- a/fs/quota/quota_v2.c
> +++ b/fs/quota/quota_v2.c
> @@ -78,7 +78,7 @@ static int v2_check_quota_file(struct super_block *sb, int type)
>  	struct v2_disk_dqheader dqhead;
>  	static const uint quota_magics[] = V2_INITQMAGICS;
>  	static const uint quota_versions[] = V2_INITQVERSIONS;
> - 
> +
>  	if (v2_read_header(sb, type, &dqhead))
>  		return 0;
>  	if (le32_to_cpu(dqhead.dqh_magic) != quota_magics[type] ||
> -- 
> 2.20.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
