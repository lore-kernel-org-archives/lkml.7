Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE1EC76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074872173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563442865;
	bh=Fb8G4A6qNsFSNyTCqbMQF4OAkTQ4OaRytPgjtUsYaLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bjToyq+6uGqmfnpTj04tTM4LrxBNUC1FxD0A9rShqtzIkuqmVFfe+NjN4XfSVT4EF
	 BcmZOk8QpcP6PEy718uOua3A1bnz3POOKD7sB++nTzV6nyh8o2Rt3k7x+yHoi7uupM
	 C+hUAidoB7/RadDw06u1uNLm5cMt1zoiZXqyq9V8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389698AbfGRJlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfGRJlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:41:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6142020693;
        Thu, 18 Jul 2019 09:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563442863;
        bh=Fb8G4A6qNsFSNyTCqbMQF4OAkTQ4OaRytPgjtUsYaLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrd5WeEqzVllZPvqHA2derQJOjaJMgl1cRPtdhd4JTR6VIzWosvQnbtbTRzTo2xsw
         /Ky87P7Vyg+Kaus0cqXk+xlpT3bMg475D0qpYYr8shY0/MrcHaXLtemI87M7T/MXom
         fdHOYqWmZMo0haGl/5m8rYTPG3cuaRl6TUxEHQd0=
Date:   Thu, 18 Jul 2019 10:40:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     corbet@lwn.net, solar@openwall.com, keescook@chromium.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        tyhicks@canonical.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/security-bugs: provide more information
 about linux-distros
Message-ID: <20190718094057.e4nclrw6qd2t4vw7@willie-the-truck>
References: <20190717231103.13949-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717231103.13949-1-sashal@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 07:11:03PM -0400, Sasha Levin wrote:
> Provide more information about how to interact with the linux-distros
> mailing list for disclosing security bugs.
> 
> Reference the linux-distros list policy and clarify that the reporter
> must read and understand those policies as they differ from
> security@kernel.org's policy.
> 
> Suggested-by: Solar Designer <solar@openwall.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> 
> Changes in v2:
>  - Focus more on pointing to the linux-distros wiki and policies.
>  - Remove explicit linux-distros email.
>  - Remove various explanations of linux-distros policies.
> 
>  Documentation/admin-guide/security-bugs.rst | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
> index dcd6c93c7aac..380d44fd618d 100644
> --- a/Documentation/admin-guide/security-bugs.rst
> +++ b/Documentation/admin-guide/security-bugs.rst
> @@ -60,16 +60,15 @@ Coordination
>  ------------
>  
>  Fixes for sensitive bugs, such as those that might lead to privilege
> -escalations, may need to be coordinated with the private
> -<linux-distros@vs.openwall.org> mailing list so that distribution vendors
> -are well prepared to issue a fixed kernel upon public disclosure of the
> -upstream fix. Distros will need some time to test the proposed patch and
> -will generally request at least a few days of embargo, and vendor update
> -publication prefers to happen Tuesday through Thursday. When appropriate,
> -the security team can assist with this coordination, or the reporter can
> -include linux-distros from the start. In this case, remember to prefix
> -the email Subject line with "[vs]" as described in the linux-distros wiki:
> -<http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
> +escalations, may need to be coordinated with the private linux-distros mailing
> +list so that distribution vendors are well prepared to issue a fixed kernel
> +upon public disclosure of the upstream fix. Please read and follow the policies
> +of linux-distros as specified in the linux-distros wiki page before reporting:

can we add a "there" at the end of this sentence, so it can't be misread as
implying that you must follow the linux-distros policies before reporting to
security@kernel.org ?

Will
