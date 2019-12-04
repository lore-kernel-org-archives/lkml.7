Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE41C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537D220803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kZJJDJE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfLDRov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:44:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32878 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfLDRou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:44:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id y206so209960pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 09:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F9Qa6Puv7ezBDFINsGITxUb0gdMtfeyJWNm86YFTPaA=;
        b=kZJJDJE+eSZPXPBjvuRAiamWZtJg0meXDZiJSBQ/OgKPdYcV/vRtTi+g2tm2BMxS4S
         yBq0QCAF+CWwh5KNJGF5NjXTm2avaYTBI4IJU0omAS7KBFBoripTGSJ1wTpU9lLGF425
         P7R5G6u4RTAHq59GpetEHVthgwzineIep1X3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9Qa6Puv7ezBDFINsGITxUb0gdMtfeyJWNm86YFTPaA=;
        b=hShMN7+bY/hsrpXBSrTZivmcTZWQHSOkREkP0sC199sRpyArvQZlAO3bIHkhChX7+e
         1LJwgJWcmWfoxFqZTSj1tZOyPA2IG9OuvFUmdyjoBgkIBPV8dd25vawL7GZgx8TMf1+G
         ZPaEmXyu+iNtPqMbdE6J1appdxM31hXBAFB+IZv/hBFpKHbBozH/DTKtKS0Ca6xKXr48
         dJ42AulvbWY0+ArJnh0z6+RjdCW/rYQNXGdzaZpkK6UfwomE1ZYWtBcHH4I1ytzKV6Gp
         RoC73WiFbgA7cK0hC1WK1ubbD7mpJt0QenOrYlTNWPjs5WFJXbZHt0ESWEl/nZm3KswC
         uvKQ==
X-Gm-Message-State: APjAAAUN25lBfpZ6ptUpJ8kIqiE/+1jXBDHsA6oYIVY9dCEUAjKBbdX6
        wOaRw6JbNPOwW8ZNIOX8SbFHNg==
X-Google-Smtp-Source: APXvYqwgcPT4G/249WAVQBUzpvpK20eSRwudnC4aE++PyedRE5c3ZYx0sSLwuLtcw8WjbZy5uVsoPA==
X-Received: by 2002:a62:e817:: with SMTP id c23mr4358423pfi.24.1575481489391;
        Wed, 04 Dec 2019 09:44:49 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k4sm8512292pfa.25.2019.12.04.09.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 09:44:48 -0800 (PST)
Date:   Wed, 4 Dec 2019 12:44:47 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Include: Linux: rculist_nulls: Add docbook comment
 headers
Message-ID: <20191204174447.GE34402@google.com>
References: <20191204120357.11658-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204120357.11658-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 05:33:57PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch adds docbook comment headers for hlist_nulls_first_rcu
> and hlist_nulls_next_rcu in rculist_nulls.h.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Thanks. Could you send this to the list? I'd like Paul to review or apply
this one.

 - Joel

> ---
>  include/linux/rculist_nulls.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> index 517a06f36c7a..d796ef18ec52 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -38,9 +38,17 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
>  	}
>  }
>  
> +/**
> + * hlist_nulls_first_rcu - returns the first element of the hash list.
> + * @head: the head for your list.
> + */
>  #define hlist_nulls_first_rcu(head) \
>  	(*((struct hlist_nulls_node __rcu __force **)&(head)->first))
>  
> +/**
> + * hlist_nulls_next_rcu - returns the element of the list next to @node.
> + * @node: Element of the list.
> + */
>  #define hlist_nulls_next_rcu(node) \
>  	(*((struct hlist_nulls_node __rcu __force **)&(node)->next))
>  
> -- 
> 2.17.1
> 
