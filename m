Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEEEC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA3A206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfJHIaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:30:03 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:38186 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfJHIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:30:02 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990947AbfJHI37AjQK8 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 2 others);
        Tue, 8 Oct 2019 10:29:59 +0200
Date:   Tue, 8 Oct 2019 09:29:58 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Colin King <colin.king@canonical.com>
cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] netdevsim: fix spelling mistake "forbidded" ->
 "forbid"
In-Reply-To: <20191008081747.19431-1-colin.king@canonical.com>
Message-ID: <alpine.LFD.2.21.1910080921350.25653@eddie.linux-mips.org>
References: <20191008081747.19431-1-colin.king@canonical.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019, Colin King wrote:

> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
> index a3d7d39f231a..ff6ced5487b6 100644
> --- a/drivers/net/netdevsim/dev.c
> +++ b/drivers/net/netdevsim/dev.c
> @@ -486,7 +486,7 @@ static int nsim_dev_reload_down(struct devlink *devlink, bool netns_change,
>  		/* For testing purposes, user set debugfs dont_allow_reload
>  		 * value to true. So forbid it.
>  		 */
> -		NL_SET_ERR_MSG_MOD(extack, "User forbidded reload for testing purposes");
> +		NL_SET_ERR_MSG_MOD(extack, "User forbid the reload for testing purposes");

 If nitpicking about grammar, then FWIW I believe it should actually be:

		NL_SET_ERR_MSG_MOD(extack, "User forbade the reload for testing purposes");

(and then:

		NL_SET_ERR_MSG_MOD(extack, "User set up the reload to fail for testing purposes");

elsewhere).

  Maciej
