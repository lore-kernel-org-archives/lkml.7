Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7114BC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442BB21A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570012541;
	bh=7PbPj/CVs84z5YM/u99/ThCu2FOpbQKMFVr1Mp3FZN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JzpUpHW7xyMb9CIH4CadsTvRwe4eBgjIlW/F99XMwSm4qDR3vBDSAjjHTJmSq71dG
	 ZcrDWVw2tT7JWxggjo4nOTxL3SM7YUgdt1grDb6zie/wVi6qzC+w6/7KoAp1chsm1Y
	 hiH0LFcIz8sWyy+pyEORQlA12koaEaLGoyqXDuAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfJBKfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:35:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfJBKfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9W9JLMUs8xLrB1r0qz1h7pbcAjO4GfqZ6Iq6k8jajmM=; b=ejzi6DCaHSObIby27WR+kU4g0
        RMcuK0ize48QcGmjzMobnMxp1rhVVwr+BOk7A0IlMaspZAi1svojcuYUzTZ2HBJYSKN3DukAWd75N
        nsXP2jGXYKQDB12PsRpXsoiRxNmKDQyzGRCuoe9AEn4beymwPMN/+p/g9GNBF/K5bXY8XBz1go9B0
        eb3HjYmSUQFC8Yj8HLPJ+ndpIoV3pTACZtHrBGjDJtEqv8QB5lgeiV8L4ALGn1VJb9hsv7hU9R+9B
        wVneZn9JW0mxAmyxsJ8cqjWRSzcd6LSDtsduQkIXc1VmkWwmN7NhOwijNaTi/guEWzm9nckcv2m9i
        4c7vCFIKA==;
Received: from 177.157.127.95.dynamic.adsl.gvt.net.br ([177.157.127.95] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFbyk-00020f-4i; Wed, 02 Oct 2019 10:35:30 +0000
Date:   Wed, 2 Oct 2019 07:35:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jeremy MAURO <jeremy.mauro@gmail.com>
Cc:     j.mauro@criteo.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION SCRIPTS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 1/2] scripts/sphinx-pre-install: Change the function
 'check_missing_file'
Message-ID: <20191002073526.228fc7e1@coco.lan>
In-Reply-To: <20191002095330.9863-1-j.mauro@criteo.com>
References: <j.mauro@criteo.com>
        <20191002095330.9863-1-j.mauro@criteo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed,  2 Oct 2019 11:53:30 +0200
Jeremy MAURO <jeremy.mauro@gmail.com> escreveu:

> The current implementation take a simple file as first argument, this
> change allows to take a list as a first argument.

Please change the title of this patch in a way that it will describe
what it will do, and not what function was changed.

Something like:

	scripts/sphinx-pre-install: allow checking for multiple missing files

> 
> Some file could have a different path according distribution version
> 
> Signed-off-by: Jeremy MAURO <j.mauro@criteo.com>
> ---
>  scripts/sphinx-pre-install | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index 3b638c0e1a4f..b5077ae63a4b 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -124,11 +124,13 @@ sub add_package($$)
>  
>  sub check_missing_file($$$)

As it is now expecting a list, I would change this function name as
well to:
	check_missing_files


With those changes, feel free to add:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>


>  {
> -	my $file = shift;
> +	my $files = shift;
>  	my $package = shift;
>  	my $is_optional = shift;
>  
> -	return if(-e $file);
> +	for (@$files) {
> +		return if(-e $_);
> +	}
>  
>  	add_package($package, $is_optional);
>  }
> @@ -343,10 +345,10 @@ sub give_debian_hints()
>  	);
>  
>  	if ($pdf) {
> -		check_missing_file("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
> +		check_missing_file(["/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"],
>  				   "fonts-dejavu", 2);
>  
> -		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
> +		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
>  				   "fonts-noto-cjk", 2);
>  	}
>  
> @@ -413,7 +415,7 @@ sub give_redhat_hints()
>  	}
>  
>  	if ($pdf) {
> -		check_missing_file("/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc",
> +		check_missing_file(["/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc"],
>  				   "google-noto-sans-cjk-ttc-fonts", 2);
>  	}
>  
> @@ -498,7 +500,7 @@ sub give_mageia_hints()
>  	$map{"latexmk"} = "texlive-collection-basic";
>  
>  	if ($pdf) {
> -		check_missing_file("/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc",
> +		check_missing_file(["/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc"],
>  				   "google-noto-sans-cjk-ttc-fonts", 2);
>  	}
>  
> @@ -528,7 +530,7 @@ sub give_arch_linux_hints()
>  	check_pacman_missing(\@archlinux_tex_pkgs, 2) if ($pdf);
>  
>  	if ($pdf) {
> -		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
> +		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
>  				   "noto-fonts-cjk", 2);
>  	}
>  
> @@ -549,11 +551,11 @@ sub give_gentoo_hints()
>  		"rsvg-convert"		=> "gnome-base/librsvg",
>  	);
>  
> -	check_missing_file("/usr/share/fonts/dejavu/DejaVuSans.ttf",
> +	check_missing_file(["/usr/share/fonts/dejavu/DejaVuSans.ttf"],
>  			   "media-fonts/dejavu", 2) if ($pdf);
>  
>  	if ($pdf) {
> -		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJKsc-Regular.otf",
> +		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJKsc-Regular.otf"],
>  				   "media-fonts/noto-cjk", 2);
>  	}
>  



Thanks,
Mauro
