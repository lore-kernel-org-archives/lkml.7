Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DD2C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F9421D80
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570023910;
	bh=MTpTC+HpWq0B/7qUmDdlkEO78yXoAdbvg8w/6mM/2Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k6SUCDpaNF/OTwODewBgA7frP8cQqx/EQIfAC5MVAmW/HzdMEL/1v8ooTBdMksmzX
	 6lcys6bxNiUalEtHYBQp+gWu8et2T3wcFhmLywxxmyRIHwUld9o7a10FVBQWtzM+QN
	 B4+x6JcuKixn259fWMepmVwbuks8Gph+8Y4FW9ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfJBNpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:45:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfJBNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nIye/+66snLtHmUYM3YmcJEBkBWMtqxkl+uqaI4t2ys=; b=AVCfkaJyqXZkIhqPOgL5rwltd
        B/ul2LTAfoelXfmdTG5odKiWDhc0qrl9KxSNRlchZdpPU0TsOyd3KkYQIOV7x+5HhKj9oJYcIQTuw
        5ir/x7ZdGOGK8ZFMup4LTb6Pgyry2FLNT3ncHx0YbBlGfOAJXrOPwXciLWwA2A4l4Y4jWWx+ttblK
        pcnHKrz9efXruzcWljiarQ9ITiHqqvVELUBsmD1ZStOzZ8DAbEjv2hMNA/i5yhkbqB/fXFDmHqjMs
        gx5RCZn8S3joy8dRWfwrlrWGqBGjLALB8G52RYX9rfkFivqM8cyIxu1bZxvpssjWxLsq6u8FnFjA1
        SJZhGOg9A==;
Received: from 177.157.127.95.dynamic.adsl.gvt.net.br ([177.157.127.95] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFewF-0005et-V2; Wed, 02 Oct 2019 13:45:08 +0000
Date:   Wed, 2 Oct 2019 10:45:04 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jeremy MAURO <jeremy.mauro@gmail.com>
Cc:     j.mauro@criteo.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION SCRIPTS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 2/2] scripts/sphinx-pre-install: Add a new path for
 the debian package "fonts-noto-cjk"
Message-ID: <20191002104504.515c6b7d@coco.lan>
In-Reply-To: <20191002133543.10909-1-j.mauro@criteo.com>
References: <20191002073636.68ad85de@coco.lan>
        <20191002133543.10909-1-j.mauro@criteo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed,  2 Oct 2019 15:35:42 +0200
Jeremy MAURO <jeremy.mauro@gmail.com> escreveu:

> The latest debian version "bullseye/sid" has changed the path of the file
> "notoserifcjk-regular.ttc", with the previous change and this change we
> keep the backward compatibility and add the latest debian version
> 
> Signed-off-by: Jeremy MAURO <j.mauro@criteo.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
> Changes in V2:
> - Align all lines
> 
>  scripts/sphinx-pre-install | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index b5077ae63a4b..1f9285274587 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -348,7 +348,8 @@ sub give_debian_hints()
>  		check_missing_file(["/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"],
>  				   "fonts-dejavu", 2);
>  
> -		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
> +		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
> +				   "/usr/share/fonts/opentype/noto/NotoSerifCJK-Regular.ttc"],
>  				   "fonts-noto-cjk", 2);
>  	}
>  



Thanks,
Mauro
