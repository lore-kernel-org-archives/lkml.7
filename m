Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE39DC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 00:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FAF2464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 00:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575590689;
	bh=AHTJZcpN/qDv+wbWaTsS7NjJKUfm6INqxec1a3pa6FY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ksN84wvB2SjNywqw9zSWoiGJVDxQiFm7c/HuzYSDdZ6CuZtHKEa+/vGTRTkjvBOYc
	 nCQBbTkqwnP10A5CUPVVQuYaFXQPPOSzbF8w2N9bMU2tOgbv3/p/S+BRyfHnGM3Sdm
	 GkGE/RhIh7+EQBMYIgXfS43FoUXbPlE66uyZ8I0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfLFAEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 19:04:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfLFAEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 19:04:47 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 864BD2173E;
        Fri,  6 Dec 2019 00:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575590686;
        bh=AHTJZcpN/qDv+wbWaTsS7NjJKUfm6INqxec1a3pa6FY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MF82HqQXjxBVUdoCFnI8bNTstmeIMs1kGG0nx6Gei8RsgBLcHa6KrsYm55riGFZou
         IAcf5bo6L0J9oDd8x8lYIPGK7UpZEsHGeh8nYBzxW1IhvVDEf1iXj5VErZk3EsdcB0
         2yO1G34RiaaCIotKCsq3SkUnQoSxAGmmvmdoTVzc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 564BD3522782; Thu,  5 Dec 2019 16:04:46 -0800 (PST)
Date:   Thu, 5 Dec 2019 16:04:46 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     josh@joshtriplett.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] include: linux: rculist_nulls: Change docbook comment
 headers
Message-ID: <20191206000446.GW2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191205185352.1957-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205185352.1957-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 12:23:52AM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch changes the docbook comment "head for your list"
> to "head of the list".
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

I applied both with some updates to the subject line and commit log.
Could you please double-check for errors on my part?

							Thanx, Paul

> ---
>  include/linux/rculist_nulls.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> index 517a06f36c7a..bea311c884b3 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -104,7 +104,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
>   * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
>   * @tpos:	the type * to use as a loop cursor.
>   * @pos:	the &struct hlist_nulls_node to use as a loop cursor.
> - * @head:	the head for your list.
> + * @head:	the head of the list.
>   * @member:	the name of the hlist_nulls_node within the struct.
>   *
>   * The barrier() is needed to make sure compiler doesn't cache first element [1],
> @@ -124,7 +124,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
>   *   iterate over list of given type safe against removal of list entry
>   * @tpos:	the type * to use as a loop cursor.
>   * @pos:	the &struct hlist_nulls_node to use as a loop cursor.
> - * @head:	the head for your list.
> + * @head:	the head of the list.
>   * @member:	the name of the hlist_nulls_node within the struct.
>   */
>  #define hlist_nulls_for_each_entry_safe(tpos, pos, head, member)		\
> -- 
> 2.17.1
> 
